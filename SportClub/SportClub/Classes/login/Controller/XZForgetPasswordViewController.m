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
@property (weak, nonatomic) IBOutlet UITextField *phoneTextfiled;

@end

@implementation XZForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)vefifyPhone:(id)sender {
    /*
    if (_phoneTextfiled.text == nil || [_phoneTextfiled.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请检查您的手机号是否正确"];
        
        return;
    } else {
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];
        [params setObject:_phoneTextfiled.text forKey:@"phone"];
        
        
        
        NSString *urlSring = [NSString stringWithFormat:@"%@%@",SERVERURL,@"/v1/sendCode"];
        
        [XZNetManager post:urlSring params:params success:^(id json) {
            [self.navigationController pushViewController:[XZVerifyViewController new] animated:YES];
            
        } failure:^(NSError *error) {
            XZLog(@"%@",error);
        }];
        
        
    }
    */
    
    

    [self.navigationController pushViewController:[XZVerifyViewController new] animated:YES];

    
    
//    [self.navigationController pushViewController:[XZVerifyViewController new] animated:YES];
}


@end
