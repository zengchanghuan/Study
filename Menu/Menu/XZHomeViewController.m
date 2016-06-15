//
//  XZHomeViewController.m
//  Menu
//
//  Created by ZengChanghuan on 16/6/15.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZHomeViewController.h"
#import "XZDock.h"
#import "Masonry.h"

@interface XZHomeViewController ()
@property (weak, nonatomic) XZDock *dock;
@property (weak, nonatomic) UIViewController *showingChildVC;
@end

@implementation XZHomeViewController

- (XZDock *)dock
{
    if (!_dock) {
        XZDock *dock = [XZDock new];
        [self.view addSubview:dock];
        self.dock = dock;
        
    }
    return _dock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置背景色
    self.view.backgroundColor = HMColor(55, 55, 55);
    
    // 初始化子控制器
    [self setupChildVcs];
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarDidSelect:) name:HMTabBarDidSelectNotification object:nil];
    
    
    //根据屏幕方向设置dock属性
    [self willRotateToInterfaceOrientation:self.interfaceOrientation duration:0];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tabBarDidSelect:(NSNotification *)notification
{
    int index = [notification.userInfo[HMTabBarSelectIndex] intValue];
    
    [self switchChildVc:index];
}

- (void)setupChildVcs{
    for (int i = 0; i < 6; i++) {
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = HMRandomColor;
        [self addChildViewController:vc];
    }
    [self switchChildVc:0];
}

/**
 *  切换子控制器
 *
 *  @param index 最新子控制器的索引
 */

- (void)switchChildVc:(int)index
{
    [self.showingChildVC.view removeFromSuperview];
    
    UIViewController *newChildVC = self.childViewControllers[index];
    [self.view addSubview:newChildVC.view];
    self.showingChildVC = newChildVC;
    
    [newChildVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.dock.mas_right);
    }];
    
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) { // 横屏
        self.dock.width = HMDockLW;
        self.dock.height = HMScreenPW;
    } else { // 竖屏
        self.dock.width = HMDockPW;
        self.dock.height = HMScreenLW;
    }
}


@end
