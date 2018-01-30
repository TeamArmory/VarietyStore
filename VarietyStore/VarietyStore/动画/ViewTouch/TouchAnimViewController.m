//
//  TouchAnimViewController.m
//  AnimationGather
//
//  Created by ongfei on 2018/1/30.
//  Copyright © 2018年 ongfei. All rights reserved.
//

#import "TouchAnimViewController.h"
#import "TouchViewAnim.h"

@interface TouchAnimViewController ()

@end

@implementation TouchAnimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"点按屏幕哦";

    TouchViewAnim *viewAnim = [[TouchViewAnim alloc] initWithFrame:self.view.frame];
    self.view = viewAnim;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
