//
//  XZComposeViewController.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/12.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZComposeViewController.h"

@interface XZComposeViewController ()

@end

@implementation XZComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(100, 80, 200, 60)];
    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
    [self setupNav];
}

- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    NSLog(@"send");
}
@end
