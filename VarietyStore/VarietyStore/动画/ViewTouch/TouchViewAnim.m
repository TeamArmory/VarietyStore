//
//  TouchViewAnim.m
//  AnimationGather
//
//  Created by ongfei on 2018/1/30.
//  Copyright © 2018年 ongfei. All rights reserved.
//

#import "TouchViewAnim.h"

@implementation TouchViewAnim

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)createLayer:(NSSet *)touches {

    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    CALayer *waveLayer = [CALayer layer];
    
    waveLayer.frame = CGRectMake(point.x - 1, point.y - 1,10,10);
    
    waveLayer.borderColor = [UIColor colorWithRed:(arc4random() % 256 / 255.0) green:(arc4random() % 256 / 255.0) blue:(arc4random() % 256 / 255.0) alpha:1.0].CGColor;
    
    waveLayer.borderWidth = 0.5;

    waveLayer.cornerRadius = 5;
    
    [self setAnimation:waveLayer];
    
    [self.layer addSublayer:waveLayer];
}

- (void)setAnimation:(CALayer *)layer {
    
    const int max =20;
    
    if (layer.transform.m11 < max) {
        
        [layer setTransform:CATransform3DScale(layer.transform, 1.1, 1.1, 1.0)];
        layer.opacity -= 0.05;
        //_cmd 获取当前方法的名字
        [self performSelector:_cmd withObject:layer afterDelay:0.03];
        
    }else {
        
        [layer removeFromSuperlayer];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self createLayer:touches];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self createLayer:touches];
}

@end
