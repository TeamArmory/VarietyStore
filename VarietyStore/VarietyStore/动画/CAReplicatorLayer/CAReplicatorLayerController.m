//
//  CAReplicatorLayerController.m
//  VarietyStore
//
//  Created by ongfei on 2018/1/31.
//  Copyright © 2018年 ongfei. All rights reserved.
//

#import "CAReplicatorLayerController.h"
#import "IntroduceController.h"

@interface CAReplicatorLayerController ()

@end

@implementation CAReplicatorLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"属性介绍" style:(UIBarButtonItemStyleDone) target:self action:@selector(introduce)];
    
    UILabel *introduceL = [[UILabel alloc] initWithFrame:CGRectMake(10, 74, self.view.frame.size.width - 20, 150)];
    [self.view addSubview:introduceL];
    introduceL.text = @"CAReplicatorLayer可以将自己的子图层复制指定的次数,并且会保持子复制图层的各种基础属性以及动画 \r frame position 等这些是外层的属性 而path fillcolor等这些是内层的属性";
    introduceL.numberOfLines = 0;
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.view addSubview:btn];
    
    btn.frame = CGRectMake(20, CGRectGetMaxY(introduceL.frame)+10, 50, 30);
    [btn setTitle:@"水波纹" forState:(UIControlStateNormal)];
    
    [btn addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.view addSubview:btn1];
    
    btn1.frame = CGRectMake(CGRectGetMaxX(btn.frame) + 10, CGRectGetMaxY(introduceL.frame)+10, 60, 30);
    [btn1 setTitle:@"加载中" forState:(UIControlStateNormal)];
    
    [btn1 addTarget:self action:@selector(click1) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *btn2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.view addSubview:btn2];
    
    btn2.frame = CGRectMake(CGRectGetMaxX(btn1.frame) + 10, CGRectGetMaxY(introduceL.frame)+10, 60, 30);
    [btn2 setTitle:@"等待中" forState:(UIControlStateNormal)];
    
    [btn2 addTarget:self action:@selector(click2) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *btn3 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.view addSubview:btn3];
    
    btn3.frame = CGRectMake(CGRectGetMaxX(btn2.frame) + 10, CGRectGetMaxY(introduceL.frame)+10, 60, 30);
    [btn3 setTitle:@"emmm" forState:(UIControlStateNormal)];
    
    [btn3 addTarget:self action:@selector(click3) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *btn4 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.view addSubview:btn4];
    
    btn4.frame = CGRectMake(CGRectGetMaxX(btn3.frame) + 10, CGRectGetMaxY(introduceL.frame)+10, 60, 30);
    [btn4 setTitle:@"emmm" forState:(UIControlStateNormal)];
    
    [btn4 addTarget:self action:@selector(click4) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)click {
    
    [self removeAllLayer];
//    画圆
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.backgroundColor = [UIColor purpleColor].CGColor;
    layer.frame = CGRectMake(0, 0, 100, 100);
    layer.position = self.view.center;
    layer.cornerRadius = 50;
    layer.opacity = 0;
//    transform动画
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1)];
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2, 2, 1)];
    anim.duration = 2;
//    透明度
    CABasicAnimation *alp = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alp.toValue = @0;
    alp.fromValue = @0.8;
    alp.duration = 2;
//    动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[anim,alp];
    group.duration = 2;
    group.repeatCount = HUGE;
    [layer addAnimation:group forKey:nil];
//  CAReplicatorLayer
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    [replicator addSublayer:layer];
    replicator.instanceCount = 3;//复制次数
    replicator.instanceDelay = 0.5;//动画延迟
    replicator.instanceAlphaOffset = -0.2;
//    replicator.instanceTransform 复制图层在被创建时产生的和上一个复制图层的位移 需要用CATransform3D。。
    
    [self.view.layer addSublayer:replicator];
}

- (void)click1 {
    [self removeAllLayer];

    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    shapelayer.frame = CGRectMake(0, 0, 20, 20);
    shapelayer.backgroundColor = [UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1].CGColor;
    
    shapelayer.cornerRadius = 10;
    shapelayer.transform = CATransform3DMakeScale(0, 0, 0);
 
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)];
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7, 0.7, 0.7)];
    anim.duration = 2;
    anim.repeatCount = HUGE;
    
    [shapelayer addAnimation:anim forKey:nil];
    
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    [replicator addSublayer:shapelayer];
    replicator.instanceCount = 20;//复制次数
    replicator.instanceDelay = 0.1;//动画延迟
    CGFloat angle = M_PI / 10.0;
    replicator.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1.0);
    replicator.frame = CGRectMake(0, 0, 100, 100);
    replicator.position = self.view.center;
    [self.view.layer addSublayer:replicator];
}

- (void)click2 {
    [self removeAllLayer];
    
    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    shapelayer.frame = CGRectMake(self.view.frame.size.width/2 - 60, self.view.frame.size.height/2, 30, 30);
    shapelayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 30, 30)].CGPath;
    shapelayer.strokeColor = [UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1].CGColor;
    shapelayer.fillColor = [UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1].CGColor;

    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 0.0)];
    scale.autoreverses = YES;
    scale.repeatCount = HUGE;
    scale.duration = 0.6;
    [shapelayer addAnimation:scale forKey:nil];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
//    replicatorLayer.frame = CGRectMake(0, 0, 100, 100);
    replicatorLayer.instanceDelay = 0.2;
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(40,0,0);
    [replicatorLayer addSublayer:shapelayer];
    
    [self.view.layer addSublayer:replicatorLayer];
}

- (void)click3 {
    [self removeAllLayer];
 
    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    shapelayer.frame = CGRectMake(0, 0, 30, 30);
    shapelayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 30, 30)].CGPath;
    shapelayer.strokeColor = [UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1].CGColor;
    shapelayer.fillColor = [UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1].CGColor;
    
    CABasicAnimation *transform = [CABasicAnimation animationWithKeyPath:@"transform"];
    transform.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DIdentity, 0.0, 0.0, 0.0, 0.0)];
    CATransform3D toValue = CATransform3DTranslate(CATransform3DIdentity, 75, 0.0, 0.0);
    toValue = CATransform3DRotate(toValue,120.0*M_PI/180.0, 0.0, 0.0, 1.0);
  
    transform.toValue = [NSValue valueWithCATransform3D:toValue];
    transform.autoreverses = NO;
    transform.repeatCount = HUGE;
    transform.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transform.duration = 0.8;
    
    [shapelayer addAnimation:transform forKey:nil];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, 30, 30);
    replicatorLayer.position = self.view.center;
    replicatorLayer.instanceDelay = 0.0;
    replicatorLayer.instanceCount = 3;
    CATransform3D trans3D = CATransform3DIdentity;
    trans3D = CATransform3DTranslate(trans3D, 75, 0, 0);
    trans3D = CATransform3DRotate(trans3D, 120.0*M_PI/180.0, 0.0, 0.0, 1.0);
    replicatorLayer.instanceTransform = trans3D;
    [replicatorLayer addSublayer:shapelayer];
    
    [self.view.layer addSublayer:replicatorLayer];
}

- (void)click4 {
    [self removeAllLayer];
 
    NSInteger column = 3;
    CGFloat between = 5.0;
    CGFloat radius = (100 - between * (column - 1))/column;
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, 0, radius, radius);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shape.fillColor = [UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1].CGColor;
    
//    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
//    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
//    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 0.0)];
//    scale.autoreverses = YES;
//    scale.repeatCount = HUGE;
//    scale.duration = 0.6;
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 0.0)];
    scale.autoreverses = YES;
    scale.repeatCount = HUGE;
    scale.duration = 0.8;

    
    CABasicAnimation *alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpha.fromValue = @(1.0);
    alpha.toValue = @(0.0);
    alpha.duration = 0.8;
    alpha.autoreverses = YES;

    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[scale,alpha];
    animationGroup.duration = 2.4;
    animationGroup.autoreverses = YES;
    animationGroup.repeatCount = HUGE;
    [shape addAnimation:animationGroup forKey:@"groupAnimation"];
    
    CAReplicatorLayer *replicatorLayerX = [CAReplicatorLayer layer];
    replicatorLayerX.frame = CGRectMake(0, 0, 100, 100);
    replicatorLayerX.instanceDelay = 0.3;
    replicatorLayerX.instanceCount = column;
    replicatorLayerX.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, radius+between, 0, 0);
    [replicatorLayerX addSublayer:shape];
    
    CAReplicatorLayer *replicatorLayerY = [CAReplicatorLayer layer];
    replicatorLayerY.frame = CGRectMake(0, 0, 100, 100);
    replicatorLayerY.position = self.view.center;
    replicatorLayerY.instanceDelay = 0.3;
    replicatorLayerY.instanceCount = column;
    replicatorLayerY.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, radius+between, 0);
    [replicatorLayerY addSublayer:replicatorLayerX];
    
    [self.view.layer addSublayer:replicatorLayerY];
   
}

#pragma mark - 跳转详情页
- (void)introduce {
    
    NSDictionary *dic = @{@"instanceCount":@"拷贝图层的次数,包括其所有的子图层,默认值是1",
                          @"instanceDelay":@"延迟时间（动画）",
                          @"instanceTransform":@"和上一个复制图层的位移",
                          @"preservesDepth":@"如果设置为YES,图层将保持于CATransformLayer类似的性质和相同的限制",
                          @"instanceColor":@"设置多个复制图层的颜色,默认位白色",
                          @"instanceRedOffset":@"设置每个复制图层相对上一个复制图层的红色偏移量",
                          @"instanceGreenOffset":@"设置每个复制图层相对上一个复制图层的绿色偏移量",
                          @"instanceBlueOffset":@"设置每个复制图层相对上一个复制图层的蓝色偏移量",
                          @"instanceAlphaOffset":@"设置每个复制图层相对上一个复制图层的透明度偏移量",
                          };
    
    IntroduceController *introduce = [IntroduceController new];
    introduce.className = @"CAReplicatorLayer";
    introduce.introduceDic = dic;
    [self.navigationController pushViewController:introduce animated:YES];
}

- (void)removeAllLayer {
    
    for (CALayer *layer in self.view.layer.sublayers) {
        if ([layer isKindOfClass:[CAReplicatorLayer class]]) {
            [layer removeAllAnimations];
            [layer removeFromSuperlayer];
        }
    }
}

@end
