//
//  DFBlingLayer.m
//  AnimationGather
//
//  Created by ongfei on 2018/1/22.
//  Copyright © 2018年 ongfei. All rights reserved.
//

#import "DFBlingLayer.h"

@interface DFBlingLayer ()<CAAnimationDelegate>

@property (nonatomic, strong) NSMutableArray *bigLayers;

@property (nonatomic, strong) NSMutableArray *smallLayers;

@property (nonatomic, strong) CADisplayLink *displaylink;

@property (nonatomic, strong) DFBlingParams *params;

@end

@implementation DFBlingLayer

- (instancetype)initWithFrame:(CGRect)frame andParams:(DFBlingParams *)params {
    
    if (self = [super init]) {
        self.opacity = 0.0;
        self.frame = frame;
        self.params = params;
        
        [self addLayers];

    }
    return self;
}

- (void)addLayers {
    
    self.bigLayers = [NSMutableArray array];
    self.smallLayers = [NSMutableArray array];
    
    CGFloat startAngle = 0;
    CGFloat angle = M_PI*2/self.params.animationCount + startAngle;

    if (self.params.animationCount%2 != 0) {
        startAngle = M_PI*2 - angle/self.params.animationCount;
    }
    CGFloat radius = self.frame.size.width/2 * self.params.animationDistanceMultiple;
    for (int i = 0; i < self.params.animationCount; i++) {
        
        CAShapeLayer *bigLayer = [CAShapeLayer layer];
        CGFloat bigWidth = self.frame.size.width * 0.15;
        if (self.params.animationSize != 0) {
            bigWidth = self.params.animationSize;
        }
        CGPoint center = [self getAnimCenter:startAngle + angle * i radius:radius];
    
        CGPathRef path = [UIBezierPath bezierPathWithArcCenter:center radius:bigWidth startAngle:0 endAngle:M_PI*2 clockwise:false].CGPath;
        
        bigLayer.path = path;
        
        
        if (self.params.allowRandomColor) {
            NSInteger index = arc4random()%self.params.colorRandom.count;
            bigLayer.fillColor = self.params.colorRandom[index].CGColor;
        }else {
            bigLayer.fillColor = [self.params.bigAnimationColor CGColor];
        }
        [self addSublayer:bigLayer];
        [self.bigLayers addObject:bigLayer];

        CAShapeLayer *smallLayer = [CAShapeLayer layer];
        CGFloat smallWidth = bigWidth*0.66;
        CGPoint smallCenter = [self getAnimCenter:startAngle + angle*i - self.params.smallAnimationOffsetAngle*M_PI/180 radius:radius-bigWidth];
        CGPathRef smallPath = [UIBezierPath bezierPathWithArcCenter:smallCenter radius:smallWidth startAngle:0 endAngle:M_PI*2 clockwise:false].CGPath;
        smallLayer.path = smallPath;
        if (self.params.allowRandomColor) {
            NSInteger index = arc4random()%self.params.colorRandom.count;
            smallLayer.fillColor = self.params.colorRandom[index].CGColor;
        }else {
            smallLayer.fillColor = [self.params.smallAnimationColor CGColor];
        }
        [self addSublayer:smallLayer];
        [self.smallLayers addObject:smallLayer];
    }
}

- (CGPoint)getAnimCenter:(CGFloat)angle radius:(CGFloat)radius {
    
    CGFloat centx = self.frame.origin.x+self.frame.size.width/2;
    CGFloat centy = self.frame.origin.y+self.frame.size.height/2;
    NSInteger multiple = 0;
    if (angle >= 0 && angle <= (90 * M_PI/180)) {
        multiple = 1;
    }else if (angle <= M_PI && angle > (90 * M_PI/180)) {
        multiple = 2;
    }else if (angle > M_PI && angle <= (270 * M_PI/180)) {
        multiple = 3;
    }else {
        multiple = 4;
    }
    
    CGFloat resultAngel = multiple*(90 * M_PI/180) - angle;
    
    double a = sin(resultAngel)*radius;
    double b = cos(resultAngel)*radius;
    
    if (multiple == 1) {
        return CGPointMake(centx+b, centy-a);
    }else if (multiple == 2) {
        return CGPointMake(centx+a, centy+b);
    }else if (multiple == 3) {
        return CGPointMake(centx-b, centy+a);
    }else {
        return CGPointMake(centx-a, centy-b);
    }
}


- (void)startAnim {

    [self removeAllAnimations];
    self.opacity = 1.0;
    CGFloat radius = self.frame.size.width/2 * self.params.animationDistanceMultiple*1.4;
    CGFloat startAngle = 0;
    CGFloat angle = M_PI*2/self.params.animationCount + startAngle;
    if (self.params.animationCount%2 != 0) {
        startAngle = M_PI*2 - angle/self.params.animationCount;
    }
    
    for (int i = 0 ; i < self.params.animationCount; i++) {
    
        CAShapeLayer *bigLayer = self.bigLayers[i];
        
        CABasicAnimation *bigAnim = [self getAngleAnim:bigLayer angle:startAngle + angle*i radius:radius];
        
        CAShapeLayer *smallLayer = self.smallLayers[i];

        CGFloat radiusSub = self.frame.size.width*0.15*0.66;
        if (self.params.animationSize != 0) {
            radiusSub = self.params.animationSize*0.66;
        }
        
        CABasicAnimation *smallAnim = [self getAngleAnim:smallLayer angle:startAngle + angle*i - self.params.smallAnimationOffsetAngle*M_PI/180 radius:radius-radiusSub];
        
        [bigLayer addAnimation:bigAnim forKey:@"path"];
        [smallLayer addAnimation:smallAnim forKey:@"path"];
        
        if (self.params.enableFlashing) {
            CABasicAnimation *bigFlash = [self getFlashAnim];
            CABasicAnimation *smallFlash = [self getFlashAnim];
            [bigLayer addAnimation:bigFlash forKey:@"bigFlash"];
            [smallLayer addAnimation:smallFlash forKey:@"smallFlash"];
        }
    }
    
    CABasicAnimation *angleAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    angleAnim.duration = self.params.animDuration * 0.87;
    angleAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    angleAnim.fromValue = 0;
    angleAnim.toValue = @(self.params.animationTurnAngle*M_PI/180);
    angleAnim.delegate = self;
    [self addAnimation:angleAnim forKey:@"rotate"];
    if (self.params.enableFlashing) {
        [self startFlas];
    }
   
}

- (void)startFlas {
    
    self.displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(flashAction)];
    self.displaylink.frameInterval = 10;
    [self.displaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)flashAction {
    
    for (int i = 0; i<self.params.animationCount; i++) {
        CAShapeLayer *bigLayer = self.bigLayers[i];
        CAShapeLayer *smallLayer = self.smallLayers[i];
        NSInteger index1 = arc4random()%self.params.colorRandom.count;
        bigLayer.fillColor = self.params.colorRandom[index1].CGColor;
        NSInteger index2 = arc4random()%self.params.colorRandom.count;
        smallLayer.fillColor = self.params.colorRandom[index2].CGColor;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (flag) {
        if (self.animEndBlock) {
            self.animEndBlock();
        }
        [self.displaylink invalidate];
        self.displaylink = nil;
        [self removeAllAnimations];
//        [self removeFromSuperlayer];
    }
}

- (CABasicAnimation *)getAngleAnim:(CAShapeLayer *)shapeLayer angle:(CGFloat)angle radius:(CGFloat)radius {

    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.duration = self.params.animDuration * 0.87;
    anim.fromValue = (__bridge id _Nullable)(shapeLayer.path);
    CGPoint center = [self getAnimCenter:angle radius:radius];
    CGPathRef path = [UIBezierPath bezierPathWithArcCenter:center radius:0.1 startAngle:0 endAngle:M_PI*2 clockwise:false].CGPath;
    anim.toValue = (__bridge id _Nullable)(path);
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    anim.removedOnCompletion = false;
    anim.fillMode = kCAFillModeForwards;
    return anim;
}

- (CABasicAnimation *)getFlashAnim {
    
    CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
    flash.fromValue = @1.0;
    flash.toValue = @0.0;
    CGFloat duration = (arc4random()%20+60)/1000.0;
    flash.duration = duration;
    flash.repeatCount = MAXFLOAT;
    flash.removedOnCompletion = false;
    flash.autoreverses = true;
    flash.fillMode = kCAFillModeForwards;
    return flash;
}

@end
