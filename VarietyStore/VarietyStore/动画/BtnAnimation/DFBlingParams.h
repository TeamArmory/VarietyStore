//
//  DFBlingParams.h
//  AnimationGather
//
//  Created by ongfei on 2018/1/25.
//  Copyright © 2018年 ongfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DFBlingParams : NSObject
//颜色随机
@property (nonatomic, assign) BOOL allowRandomColor;
/// 动画时间，秒
@property (nonatomic, assign) CGFloat animDuration;
/// 大圈的颜色
@property (nonatomic, strong) UIColor *bigAnimationColor;
/// 是否需要Flash效果
@property (nonatomic, assign) BOOL enableFlashing;
/// 个数
@property (nonatomic, assign) NSInteger animationCount;
/// 扩散的旋转角度
@property (nonatomic, assign) CGFloat animationTurnAngle;
/// 扩散的范围的倍数
@property (nonatomic, assign) CGFloat animationDistanceMultiple;
/// 小圈大圈之前的角度差异
@property (nonatomic, assign) CGFloat smallAnimationOffsetAngle;
/// 小圈的颜色
@property (nonatomic, strong) UIColor *smallAnimationColor;
/// 圈的大小
@property (nonatomic, assign) CGFloat animationSize;
//随机颜色数组
@property (nonatomic, strong) NSArray<UIColor *> *colorRandom;

@end
