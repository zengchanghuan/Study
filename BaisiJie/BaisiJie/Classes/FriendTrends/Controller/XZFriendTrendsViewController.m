//
//  XZFriendTrendsViewController.m
//  BaisiJie
//
//  Created by ZengChanghuan on 16/6/27.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZFriendTrendsViewController.h"
#import "XZRecommendViewController.h"
#import "XZLoginRegisterViewController.h"
@interface XZFriendTrendsViewController ()

@end

@implementation XZFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
}
- (IBAction)loginRegister:(id)sender {
    [self presentViewController:[XZLoginRegisterViewController new] animated:YES completion:nil];
}

- (void)friendsClick
{
    [self.navigationController pushViewController:[XZRecommendViewController new] animated:YES];
}





@end
