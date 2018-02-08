//
//  AlertViewController.m
//  VarietyStore
//
//  Created by ongfei on 2018/1/31.
//  Copyright © 2018年 ongfei. All rights reserved.
//

#import "AlertViewController.h"

@interface AlertViewController ()

@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:self.view.frame];
    [self.view addSubview:lable];
    lable.text = self.str;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.numberOfLines = 0;
}
#pragma mark - 3Dtouch 往上滑会触发
-(NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    UIPreviewAction * action = [UIPreviewAction actionWithTitle:@"了解" style:0 handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    return @[action];
}

@end
