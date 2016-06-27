//
//  XZVerifyViewController.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/20.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZVerifyViewController.h"
#import "XZNewPasswordViewController.h"
@interface XZVerifyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *codeField;

@end

@implementation XZVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)phoneSucced:(id)sender {
    /*
    if (self.codeField.text == nil || [self.codeField.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请检查您的验证码是否正确"];
        
        return;
    } else {
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
        [params setObject:_phone forKey:@"phone"];
        NSLog(@"%@",self.codeField.text);
        [params setObject:self.codeField.text forKey:@"code"];
        
        
        
        NSString *urlSring = [NSString stringWithFormat:@"%@%@",SERVERURL,@"/v1/account/validate/code"];
        
        [XZNetManager post:urlSring params:params success:^(id json) {
            [self.navigationController pushViewController:[XZNewPasswordViewController new] animated:YES];
            
        } failure:^(NSError *error) {
            XZLog(@"%@",error);
        }];
        
        
    }
     */

    /*
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
    [params setObject:@"13121551578" forKey:@"phone"];
    [params setObject:@"123542" forKey:@"code"];

    NSString *url = [NSString stringWithFormat:@"%@%@",SERVERURL,@"/v1/account/validate/code"];
    [XZNetManager post:url params:params success:^(id json) {
        XZLog(@"%@",json);
        [self.navigationController pushViewController:[XZNewPasswordViewController new] animated:YES];

    } failure:^(NSError *error) {
        XZLog(@"--------------%@",error);
    }];
    */
    
    [self.navigationController pushViewController:[XZNewPasswordViewController new] animated:YES];

}


@end
