//
//  XZFriendTrendsViewController.m
//  BaisiJie
//
//  Created by ZengChanghuan on 16/6/27.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZFriendTrendsViewController.h"

@interface XZFriendTrendsViewController ()

@end

@implementation XZFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    UIButton *friendsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [friendsButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [friendsButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    friendsButton.size = friendsButton.currentBackgroundImage.size;
    [friendsButton addTarget:self action:@selector(friendsClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:friendsButton];
}

- (void)friendsClick
{
    XZLogFunc;
}





@end
