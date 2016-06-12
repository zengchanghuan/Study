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
#import "XZNavigationController.h"
@interface XZTabBarViewController ()<XZTabBarDelegate>

@end

@implementation XZTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XZHomeViewController *home = [XZHomeViewController new];
    [self addChildVc:home title:@"热点" image:@"tabbar_home" selectedImage:@"tabbar_home"];
    
    XZLiveViewController *live = [XZLiveViewController new];
    [self addChildVc:live title:@"看点" image:@"tabbar_live" selectedImage:@"tabbar_live"];


    XZDiscoverViewController *discover = [XZDiscoverViewController new];
    [self addChildVc:discover title:@"操场" image:@"tabbar_discover" selectedImage:@"tabbar_discover"];

    XZStoreViewController *store = [XZStoreViewController new];
    [self addChildVc:store title:@"背包" image:@"tabbar_store" selectedImage:@"tabbar_store"];
    XZUITabBar *tabBar = [XZUITabBar new];
    tabBar.XZTabBarDelegate = self;
    [self setValue:tabBar forKey:@"tabBar"];

}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    if (iOS7) {
        childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    
    XZNavigationController *nav = [[XZNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];

}
-(void)tabBarDidClickPlusButton:(XZUITabBar *)tabBar
{
    
}
@end
