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
#import "MenuLabel.h"
#import "HyPopMenuView.h"
#import <POP.h>
#import "XZTestViewController.h"
#define Objs @[[MenuLabel CreatelabelIconName:@"tabbar_compose_idea" Title:@"文字"],[MenuLabel CreatelabelIconName:@"tabbar_compose_photo" Title:@"相册"],[MenuLabel CreatelabelIconName:@"tabbar_compose_camera" Title:@"拍摄"],[MenuLabel CreatelabelIconName:@"tabbar_compose_lbs" Title:@"签到"],[MenuLabel CreatelabelIconName:@"tabbar_compose_review" Title:@"点评"],[MenuLabel CreatelabelIconName:@"tabbar_compose_more" Title:@"更多"],]



@interface XZTabBarViewController ()<XZTabBarDelegate>

@end

@implementation XZTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XZTestViewController *test = [XZTestViewController new];
    [self addChildVc:test title:@"测试" image:@"tabbar_home" selectedImage:@"tabbar_home"];
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
    
    CGFloat x,y,w,h;
    x = CGRectGetWidth(self.view.bounds)/2 - 213/2;
    y = CGRectGetHeight([UIScreen mainScreen].bounds)/2 * 0.3f;
    w = 213;
    h = 57;
    //自定义的头部视图
    UIImageView *topView = [[ImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    topView.image = [UIImage imageNamed:@"compose_slogan"];
    topView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSMutableDictionary *AudioDictionary = [NSMutableDictionary dictionary];
    
    //添加弹出菜单音效
    [AudioDictionary setObject:@"composer_open" forKey:kHyPopMenuViewOpenAudioNameKey];
    [AudioDictionary setObject:@"wav" forKey:kHyPopMenuViewOpenAudioTypeKey];
    //添加取消菜单音效
    [AudioDictionary setObject:@"composer_close" forKey:kHyPopMenuViewCloseAudioNameKey];
    [AudioDictionary setObject:@"wav" forKey:kHyPopMenuViewCloseAudioTypeKey];
    //添加选中按钮音效
    [AudioDictionary setObject:@"composer_select" forKey:kHyPopMenuViewSelectAudioNameKey];
    [AudioDictionary setObject:@"wav" forKey:kHyPopMenuViewSelectAudioTypeKey];
    
    [HyPopMenuView CreatingPopMenuObjectItmes:Objs TopView:topView /*nil*/OpenOrCloseAudioDictionary:AudioDictionary /*nil*/ SelectdCompletionBlock:^(MenuLabel *menuLabel, NSInteger index) {
        NSLog(@"index:%ld ItmeNmae:%@",(long)index,menuLabel.title);
    }];
    
    
    
//    XZComposeViewController *compose = [XZComposeViewController new];
//    XZNavigationController *nav = [[XZNavigationController alloc] initWithRootViewController:compose];
//    [self presentViewController:nav animated:YES completion:nil];
}
@end
