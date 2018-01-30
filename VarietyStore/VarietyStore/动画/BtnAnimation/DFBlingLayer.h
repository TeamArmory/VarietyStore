//
//  DFBlingLayer.h
//  AnimationGather
//
//  Created by ongfei on 2018/1/22.
//  Copyright © 2018年 ongfei. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DFBlingParams.h"

@interface DFBlingLayer : CALayer

@property (nonatomic, copy) void(^animEndBlock)(void);

- (instancetype)initWithFrame:(CGRect)frame andParams:(DFBlingParams *)params;
- (void)startAnim;

@end
