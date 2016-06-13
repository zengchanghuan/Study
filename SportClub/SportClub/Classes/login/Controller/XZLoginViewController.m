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
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(100, 80, 200, 60)];
    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
    [self setupNav];
  
}

- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];

}

- (void)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
