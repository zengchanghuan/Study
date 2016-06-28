//
//  XZMeViewController.m
//  BaisiJie
//
//  Created by ZengChanghuan on 16/6/27.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZMeViewController.h"

@interface XZMeViewController ()

@end

@implementation XZMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    
    // 设置导航栏右边的按钮
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    settingButton.size = settingButton.currentBackgroundImage.size;
    [settingButton addTarget:self action:@selector(settingClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nightModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nightModeButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [nightModeButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    nightModeButton.size = nightModeButton.currentBackgroundImage.size;
    [nightModeButton addTarget:self action:@selector(nightModeClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[
                                                [[UIBarButtonItem alloc] initWithCustomView:settingButton],
                                                [[UIBarButtonItem alloc] initWithCustomView:nightModeButton]
                                                ];
}


- (void)settingClick
{
    XZLogFunc;
}

- (void)nightModeClick
{
    XZLogFunc;
}

@end
