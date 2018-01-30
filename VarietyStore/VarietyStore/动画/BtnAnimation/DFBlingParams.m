//
//  DFBlingParams.m
//  AnimationGather
//
//  Created by ongfei on 2018/1/25.
//  Copyright © 2018年 ongfei. All rights reserved.
//

#import "DFBlingParams.h"

@implementation DFBlingParams

- (instancetype)init {
    if (self = [super init]) {
        
        self.allowRandomColor = NO;
        self.animDuration = 2;
        self.bigAnimationColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        self.enableFlashing = NO;
        self.animationCount = 7;
        self.animationTurnAngle = 20;
        self.animationDistanceMultiple = 1.5;
        self.smallAnimationOffsetAngle = 20;
        self.smallAnimationColor = [UIColor lightGrayColor];
        self.animationSize = 0;
        self.colorRandom = @[
                             [UIColor colorWithRed:255/255.0 green:255/255.0 blue:153/255.0 alpha:1],
                             [UIColor colorWithRed:255/255.0 green:204/255.0 blue:204/255.0 alpha:1],
                             [UIColor colorWithRed:153/255.0 green:102/255.0 blue:153/255.0 alpha:1],
                             [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1],
                             [UIColor colorWithRed:255/255.0 green:255/255.0 blue:102/255.0 alpha:1],
                             [UIColor colorWithRed:244/255.0 green:67/255.0 blue:54/255.0 alpha:1],
                             [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1],
                             [UIColor colorWithRed:204/255.0 green:204/255.0 blue:0 alpha:1],
                             [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1],
                             [UIColor colorWithRed:153/255.0 green:153/255.0 blue:51/255.0 alpha:1]
                             ];
    }
    return self;
}

@end
