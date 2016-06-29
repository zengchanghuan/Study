//
//  XZLogRegisterViewController.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/20.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZLogRegisterViewController.h"
#import "XZRegisterUserViewController.h"
#import "XZNavigationController.h"
#import "XZForgetPasswordViewController.h"
@interface XZLogRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation XZLogRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号登录";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(closed)image:@"navigationButtonReturn"highImage:@"navigationButtonReturnClick"];
    
    
}

/**
 *  状态栏的颜色
 *
 */
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)closed {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registerUser:(id)sender {
    XZRegisterUserViewController *vc = [[XZRegisterUserViewController alloc] init];
//    XZNavigationController *na = [[XZNavigationController alloc] initWithRootViewController:vc];
//    [self.navigationController pushViewController:na animated:YES];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)forgetPassword:(id)sender {
    
    [self.navigationController pushViewController:[XZForgetPasswordViewController new] animated:YES];
}
@end
