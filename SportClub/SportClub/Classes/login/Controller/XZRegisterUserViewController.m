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
#import "XZAccountManager.h"


//服务器地址
#define SERVERURL @"http://114.112.98.72:8089"
@interface XZRegisterUserViewController ()
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneNubmer;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (copy, nonatomic) NSString *phone;
@end

@implementation XZRegisterUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_timeBtn addTarget:self action:@selector(getIdentifyingCode) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)agreement:(id)sender {
    [self.navigationController pushViewController:[XZAgreementViewController new] animated:YES];
}
- (IBAction)nextStep:(id)sender {
    
    /*
    if (self.codeField.text == nil || [self.codeField.text isEqualToString:@""] || _phone == nil || [_phone isEqualToString:@""]) {
        [MBProgressHUD showError:@"请检查您的手机和验证码是否正确"];

        return;
    } else {
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
        [params setObject:_phone forKey:@"phone"];
        NSLog(@"%@",self.codeField.text);
        [params setObject:self.codeField.text forKey:@"code"];
        
        
        
        NSString *urlSring = [NSString stringWithFormat:@"%@%@",SERVERURL,@"/v1/account/validate/code"];
        
        [XZNetManager post:urlSring params:params success:^(id json) {
            [self.navigationController pushViewController:[XZProfileViewController new] animated:YES];
            
        } failure:^(NSError *error) {
            XZLog(@"%@",error);
        }];

        
    }
     */
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

- (void)getIdentifyingCode{
    
    
    [self startTime];

    if (![self validatePhone:self.phoneNubmer.text]) {
        [MBProgressHUD showError:@"手机格式不正确"];
    } else {
        _phone = self.phoneNubmer.text;
        NSLog(@"%@",self.phoneNubmer.text);
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];
        
        [params setObject:self.phoneNubmer.text forKey:@"phone"];
        
        NSString *url = [NSString stringWithFormat:@"%@%@",SERVERURL,@"/v1/sendCode"];
        
        [XZNetManager post:url params:params success:^(id json) {
//            [self startTime];
        } failure:^(NSError *error) {
            XZLog(@"%@",error);
        }];

    }
    
    
}

//手机号判断
- (BOOL)validatePhone:(NSString *)phone
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:phone] == YES)
        || ([regextestcm evaluateWithObject:phone] == YES)
        || ([regextestct evaluateWithObject:phone] == YES)
        || ([regextestcu evaluateWithObject:phone] == YES))
    {
        if([regextestcm evaluateWithObject:phone] == YES) {
            NSLog(@"China Mobile");
        } else if([regextestct evaluateWithObject:phone] == YES) {
            NSLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:phone] == YES) {
            NSLog(@"China Unicom");
        } else {
            NSLog(@"Unknow");
        }
        
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
