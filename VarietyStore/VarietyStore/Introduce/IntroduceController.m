//
//  IntroduceController.m
//  VarietyStore
//
//  Created by ongfei on 2018/1/31.
//  Copyright © 2018年 ongfei. All rights reserved.
//

#import "IntroduceController.h"
#import <objc/runtime.h>
#import "AlertViewController.h"

@interface IntroduceController ()<UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) NSMutableArray *arr;

@end

@implementation IntroduceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"3DTouch按按咯";
    self.arr = [NSMutableArray array];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    unsigned int count;
    objc_property_t *propertyArray = class_copyPropertyList([NSClassFromString(self.className) class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyArray[i];
        const char *cName = property_getName(property);
        NSString *instroduce = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [self.arr addObject:instroduce];
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellID];
    }

    cell.textLabel.text = self.arr[indexPath.row];
    
    if ([self.introduceDic.allKeys containsObject:self.arr[indexPath.row]]) {
        cell.detailTextLabel.text = [self.introduceDic objectForKey:self.arr[indexPath.row]];
    }
//3DTouch 设置
    [self registerForPreviewingWithDelegate:self sourceView:cell];

    
    return cell;
}

#pragma mark - peek的代理方法，轻按即可触发弹出vc
- (UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{

    UITableViewCell *cell = (UITableViewCell* )[previewingContext sourceView];
    AlertViewController *alertVC = [[AlertViewController alloc] init];
    NSString *str = [NSString stringWithFormat:@"属性名：%@ \n\n 介绍：%@",cell.textLabel.text,cell.detailTextLabel.text];
    alertVC.str = str;
    return alertVC;
}
#pragma mark -  pop的代理方法，在此处可对将要进入的vc进行处理
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    //使劲按下去会触发
}


@end
