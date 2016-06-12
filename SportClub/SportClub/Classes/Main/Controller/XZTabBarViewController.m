//
//  XZTabBarViewController.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/12.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZTabBarViewController.h"
#import "XZHomeViewController.h"
#import "XZLiveViewController.h"
#import "XZComposeViewController.h"
#import "XZDiscoverViewController.h"
#import "XZStoreViewController.h"
#import "XZUITabBar.h"
@interface XZTabBarViewController ()<XZTabBarDelegate>

@end

@implementation XZTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XZHomeViewController *home = [XZHomeViewController new];
    XZLiveViewController *live = [XZLiveViewController new];
    XZComposeViewController *compose = [XZComposeViewController new];
    XZDiscoverViewController *discover = [XZDiscoverViewController new];
    XZStoreViewController *store = [XZStoreViewController new];
    self.viewControllers = @[home,live,compose,discover,store];;
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    
}
-(void)tabBarDidClickPlusButton:(XZUITabBar *)tabBar
{
    
}
@end
