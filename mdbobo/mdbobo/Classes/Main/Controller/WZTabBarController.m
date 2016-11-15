//
//  WZTabBarController.m
//  mdbobo
//
//  Created by WangZhen on 2016/11/13.
//  Copyright © 2016年 WangZhen. All rights reserved.
//

#import "WZTabBarController.h"
#import "WZNavigationController.h"
#import "WZHomeVC.h"
#import "WZShoppingCartVC.h"
#import "WZMeVC.h"

@interface WZTabBarController ()

@end

@implementation WZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    // 设置渲染颜色
    self.tabBar.tintColor = [UIColor redColor];
    
    // 添加所有子控制器
    [self addAllChildViewController];
    
    // 添加工具条所有的按钮
    [self setupAllTabbarButton];
}



#pragma mark - 添加TabBar控制器的所有子控制器
- (void)addAllChildViewController {

    // 添加首页(包装成一个导航控制器)
    WZNavigationController *homeNav = [[WZNavigationController alloc] initWithRootViewController:[[WZHomeVC alloc] init]];
    [self addChildViewController:homeNav];
    
    
    // 添加购物车页(包装成一个导航控制器)
    WZNavigationController *shoppingCartNav = [[WZNavigationController alloc] initWithRootViewController:[[WZShoppingCartVC alloc] init]];
    [self addChildViewController:shoppingCartNav];
    
    
    // 添加我的页:UITableVC
    [self addChildViewController:[[WZMeVC alloc] init]];
}

#pragma mark - 添加TabBar控制器的工具条所有的按钮
- (void)setupAllTabbarButton {
    // 取出TabBar控制器的子控制器设置tabBarItem
    
    // 首页按钮
    WZNavigationController *nav0 = self.childViewControllers[0];
    nav0.tabBarItem.image = [UIImage imageNamed:@"tabBar_home_icon"];
    nav0.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_home_click_icon"];
    nav0.tabBarItem.title = @"首页";
    
    // 购物车按钮
    WZNavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_shopping_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_shopping_click_icon"];
    nav1.tabBarItem.title = @"购物车";
    
    // 我的按钮
    WZMeVC *meVC = self.childViewControllers[2];
    meVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    meVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    meVC.tabBarItem.title = @"我的";
}

@end
