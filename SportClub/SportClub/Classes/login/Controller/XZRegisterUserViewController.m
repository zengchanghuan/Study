//
//  XZRegisterUserViewController.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/20.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZRegisterUserViewController.h"
#import "XZAgreementViewController.h"
#import "XZProfileViewController.h"
@interface XZRegisterUserViewController ()
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;

@end

@implementation XZRegisterUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_timeBtn addTarget:self action:@selector(startTime) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)agreement:(id)sender {
    [self.navigationController pushViewController:[XZAgreementViewController new] animated:YES];
}
- (IBAction)nextStep:(id)sender {
    [self.navigationController pushViewController:[XZProfileViewController new] animated:YES];
}

- (void)startTime
{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_timeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                _timeBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_timeBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _timeBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

@end
