//
//  ViewController.m
//  VarietyStore
//
//  Created by ongfei on 2018/1/30.
//  Copyright © 2018年 ongfei. All rights reserved.
//

#import "ViewController.h"

#import "BtnAnimation.h"
#import "TouchAnimViewController.h"
#import "CAReplicatorLayerController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *mutableArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mutableArr = [NSMutableArray arrayWithObjects:@"Btn动画",@"TouchViewAnim",@"CAReplicatorLayer",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    
    UITableView *tableV = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStylePlain)];
    [self.view addSubview:tableV];
    
    tableV.delegate = self;
    tableV.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.mutableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = self.mutableArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SEL sel = NSSelectorFromString(self.mutableArr[indexPath.row]);
    
    if ([self respondsToSelector:sel]) {
        
        [self performSelector:sel];
    }
}

- (void)Btn动画 {
    BtnAnimation *btn = [BtnAnimation new];
    [self.navigationController pushViewController:btn animated:YES];
}

- (void)TouchViewAnim {
    
    TouchAnimViewController *touchVC = [TouchAnimViewController new];
    [self.navigationController pushViewController:touchVC animated:YES];
}

- (void)CAReplicatorLayer {
    
    CAReplicatorLayerController *replicator = [CAReplicatorLayerController new];
    [self.navigationController pushViewController:replicator animated:YES];
}


#pragma mark - tableviewCell 滑动操作 8.0-later
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:@"测试" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"————11");
        
    }];
    
    
    action.backgroundColor = [UIColor colorWithRed:arc4random()%256/256.0 green:arc4random()%256/256.0 blue:arc4random()%256/256.0 alpha:1];
    
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleNormal) title:@"测试2" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"————2222");
    }];
    action1.backgroundColor = [UIColor colorWithRed:arc4random()%256/256.0 green:arc4random()%256/256.0 blue:arc4random()%256/256.0 alpha:1];
    
    return @[action,action1];
    
}


#pragma mark - tableviewCell 滑动操作 11-later
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (@available(iOS 11.0, *)) {
        UIContextualAction *action = [UIContextualAction contextualActionWithStyle:(UIContextualActionStyleNormal) title:@"测试" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            
            NSLog(@"111");
            completionHandler(YES);
            
        }];
        
        action.backgroundColor = [UIColor colorWithRed:arc4random()%256/256.0 green:arc4random()%256/256.0 blue:arc4random()%256/256.0 alpha:1];
        
        UIContextualAction *action2 = [UIContextualAction contextualActionWithStyle:(UIContextualActionStyleDestructive) title:@"测试2" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            
            NSLog(@"2222");
            completionHandler(YES);
            
        }];
        
        action2.backgroundColor = [UIColor colorWithRed:arc4random()%256/256.0 green:arc4random()%256/256.0 blue:arc4random()%256/256.0 alpha:1];
        
        UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[action,action2]];
        
        config.performsFirstActionWithFullSwipe = NO;
        
        return config;
    } else {
        // Fallback on earlier versions
        return nil;
    }
}

- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (@available(iOS 11.0, *)) {
        UIContextualAction *action = [UIContextualAction contextualActionWithStyle:(UIContextualActionStyleNormal) title:@"测试" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            
            NSLog(@"111");
            completionHandler(YES);
            
        }];
        
        action.backgroundColor = [UIColor colorWithRed:arc4random()%256/256.0 green:arc4random()%256/256.0 blue:arc4random()%256/256.0 alpha:1];
        
        UIContextualAction *action2 = [UIContextualAction contextualActionWithStyle:(UIContextualActionStyleDestructive) title:@"测试2" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            
            NSLog(@"2222");
            completionHandler(YES);
            
        }];
        
        action2.backgroundColor = [UIColor colorWithRed:arc4random()%256/256.0 green:arc4random()%256/256.0 blue:arc4random()%256/256.0 alpha:1];
        
        UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[action,action2]];
        
        config.performsFirstActionWithFullSwipe = NO;
        
        return config;
    } else {
        // Fallback on earlier versions
        return nil;
    }
}


@end
