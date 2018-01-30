//
//  UIView+BaseAnimationGather.h
//  AnimationGather
//
//  Created by ongfei on 2018/1/23.
//  Copyright © 2018年 ongfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BaseAnimationGather)
//放大缩小抖动
- (void)startVibrateAnimation:(CGFloat)duration values:(NSArray *)values;
- (void)startBlingAnim:(void(^)(void))complete;
@end
