//
//  XZTabBarController.m
//  BaisiJie
//
//  Created by ZengChanghuan on 16/6/27.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZTabBarController.h"
#import "XZEssenceViewController.h"
#import "XZNewViewController.h"
#import "XZFriendTrendsViewController.h"
#import "XZMeViewController.h"
#import "XZTabBar.h"
#import "XZNavigationController.h"
@interface XZTabBarController ()

@end

@implementation XZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UINavigationBar appearance];

    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // 添加子控制器
    [self setupChildVc:[[XZEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVc:[[XZNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupChildVc:[[XZFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVc:[[XZMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    [self setValue:[[XZTabBar alloc] init] forKeyPath:@"tabBar"];
}

- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    
    XZNavigationController *nav = [[XZNavigationController alloc] initWithRootViewController:vc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [self addChildViewController:nav];

    // 添加为子控制器
    [self addChildViewController:nav];
}

@end
