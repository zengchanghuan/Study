//
//  XZEssenceViewController.m
//  BaisiJie
//
//  Created by ZengChanghuan on 16/6/27.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZEssenceViewController.h"

@interface XZEssenceViewController ()

@end

@implementation XZEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];

}

- (void)tagClick
{
    XZLogFunc;
}

@end
