//
//  XZHomeViewController.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/12.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZHomeViewController.h"
#import "XZLoginViewController.h"
@interface XZHomeViewController ()

@end

@implementation XZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
}

#pragma mark -setupNav
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(login)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)login
{
    XZLoginViewController *login = [XZLoginViewController new];
    [self.navigationController pushViewController:login animated:YES];
}

- (void)search
{
    
}
@end
