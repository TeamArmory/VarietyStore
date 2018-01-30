
//
//  UIView+BaseAnimationGather.m
//  AnimationGather
//
//  Created by ongfei on 2018/1/23.
//  Copyright © 2018年 ongfei. All rights reserved.
//

#import "UIView+BaseAnimationGather.h"

#import "DFBlingLayer.h"

@implementation UIView (BaseAnimationGather)

- (void)startVibrateAnimation:(CGFloat)duration values:(NSArray *)values {
    [self.layer removeAllAnimations];
    CGFloat delayTime = duration < 0 ? 0.6 : duration;
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    anim.duration = delayTime;
    anim.values = values == nil ? @[@0.4, @1, @0.9, @1] : values;
    anim.calculationMode = kCAAnimationCubic;
    [self.layer addAnimation:anim forKey:@"scale"];
}

- (void)startBlingAnim:(void(^)(void))complete {
    
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer isKindOfClass:[DFBlingLayer class]]) {
            DFBlingLayer *controlLayer = (DFBlingLayer *)layer;
            [controlLayer startAnim];
            controlLayer.animEndBlock = ^{
                complete();
            };
        }
    }
}

@end
