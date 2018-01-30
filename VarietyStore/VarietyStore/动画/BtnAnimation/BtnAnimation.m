//
//  BtnAnimation.m
//  AnimationGather
//
//  Created by ongfei on 2018/1/22.
//  Copyright © 2018年 ongfei. All rights reserved.
//

#import "BtnAnimation.h"

#import "DFBlingLayer.h"

#import "UIView+BaseAnimationGather.h"

@interface BtnAnimation ()

@property (nonatomic, strong) DFBlingLayer *controlLayer;

@end

@implementation BtnAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *picArr = @[@"heart",@"like",@"smile",@"star"];
    
    for (int i = 0 ; i < picArr.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        
        [self.view addSubview:btn];
        
        btn.frame = CGRectMake(self.view.frame.size.width/2 - 30, 120 * (i + 1), 60, 60);
        
        [btn setImage:[UIImage imageNamed:picArr[i]] forState:(UIControlStateNormal)];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        DFBlingParams *params = [[DFBlingParams alloc] init];
        
        if (i == 0) {
            params.allowRandomColor = YES;
            params.enableFlashing = YES;
        }
        
        if (i == 1) {
            params.allowRandomColor = YES;
            params.animDuration = 1;
        }
        
        if (i == 2) {
            params.animationCount = 15;
            params.animDuration = 2;
            params.smallAnimationOffsetAngle = -5;
        }

        DFBlingLayer *controlLayer = [[DFBlingLayer alloc] initWithFrame:btn.bounds andParams:params];
        [btn.layer addSublayer:controlLayer];
    }
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    [self.view addSubview:btn];
    
    btn.frame = CGRectMake(self.view.frame.size.width/2 - 60, self.view.frame.size.height - 100, 120, 60);
    
    [btn setTitle:@"Let's Go" forState:(UIControlStateNormal)];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    
    
    [btn addTarget:self action:@selector(go) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)btnClick:(UIButton *)sender {
    
    NSLog(@"btnClick");
    
    [sender startBlingAnim:^{
        NSLog(@"ending");
    }];
    
}

- (void)go {
    
    for (UIView *subV in self.view.subviews) {
        if ([subV isKindOfClass:[UIButton class]]) {
            [subV startBlingAnim:^{
                NSLog(@"ending");
            }];
        }
    }
}

@end
