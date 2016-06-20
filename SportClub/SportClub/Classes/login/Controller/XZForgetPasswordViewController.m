//
//  XZForgetPasswordViewController.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/20.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZForgetPasswordViewController.h"
#import "XZVerifyViewController.h"
@interface XZForgetPasswordViewController ()

@end

@implementation XZForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)vefifyPhone:(id)sender {
    [self.navigationController pushViewController:[XZVerifyViewController new] animated:YES];
}


@end
