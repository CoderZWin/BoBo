//
//  WZHomeVC.m
//  mdbobo
//
//  Created by WangZhen on 2016/11/13.
//  Copyright © 2016年 WangZhen. All rights reserved.
//

#import "WZHomeVC.h"
#import "WZNewTVC.h"
#import "WZHotTVC.h"
#import "WZChannelsTVC.h"
#import "WZAttentionTVC.h"

@interface WZHomeVC ()

@end

@implementation WZHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    // 设置NavigationItem:导航条
    [self setNavigationItem];
    
    // 添加所有子控制器
    [self addAllChildViewController];
}

- (void)setNavigationItem {
    
    // 左
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"magnifying"] style:UIBarButtonItemStyleDone target:nil action:nil];
    
    // 中
    self.navigationItem.title = @"麻豆播播";
    
    // 右
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"register"] style:UIBarButtonItemStylePlain target:nil action:nil];
}


- (void)addAllChildViewController {
    
    WZNewTVC *newTvc = [[WZNewTVC alloc] init];
    newTvc.title = @"最新";
    [self addChildViewController:newTvc];
    
    WZHotTVC *hotTvc = [[WZHotTVC alloc] init];
    hotTvc.title = @"最热";
    [self addChildViewController:hotTvc];
    
    WZChannelsTVC *channelsTvc = [[WZChannelsTVC alloc] init];
    channelsTvc.title = @"频道";
    [self addChildViewController:channelsTvc];
    
    WZAttentionTVC *attentionTvc = [[WZAttentionTVC alloc] init];
    attentionTvc.title = @"关注";
    [self addChildViewController:attentionTvc];
}

@end
