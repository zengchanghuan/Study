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
#import "NSString+MD5.h"

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
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)forgetPassword:(id)sender {
    
    [self.navigationController pushViewController:[XZForgetPasswordViewController new] animated:YES];
}
- (IBAction)login:(id)sender {
    __weak XZLogRegisterViewController *weakself = self;

    NSString *url = [NSString stringWithFormat:@"%@%@",SERVERURL,@"/v1/account/login"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:3];
    [params setObject:@"13121551578" forKey:@"phone"];
    [params setObject:[@"518103" MD5] forKey:@"pwd"];
    
    [XZNetManager post:url params:params success:^(id json) {
        XZLog(@"登录成功%@",json);
        [weakself dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        XZLog(@"%@",error);
    }];
    
}

@end
