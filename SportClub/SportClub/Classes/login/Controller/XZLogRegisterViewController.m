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

@interface XZLogRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation XZLogRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/**
 *  状态栏的颜色
 *
 */
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (IBAction)closed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registerUser:(id)sender {
    XZRegisterUserViewController *vc = [[XZRegisterUserViewController alloc] init];
//    XZNavigationController *na = [[XZNavigationController alloc] initWithRootViewController:vc];
//    [self.navigationController pushViewController:na animated:YES];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)forgetPassword:(id)sender {
}
@end
