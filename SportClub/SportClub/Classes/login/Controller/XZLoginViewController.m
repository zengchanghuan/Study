//
//  XZLoginViewController.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/12.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZLoginViewController.h"

@interface XZLoginViewController ()

@end

@implementation XZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.backgroundColor = [UIColor grayColor];
    loginBtn.frame = CGRectMake(100, 100, 120, 100);
    [self.view addSubview:loginBtn];
}

- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
