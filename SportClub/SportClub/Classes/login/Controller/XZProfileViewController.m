//
//  XZProfileViewController.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/20.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZProfileViewController.h"
#import "NSString+MD5.h"
#import "AFNetworking.h"
@interface XZProfileViewController ()
@property (weak, nonatomic) IBOutlet UIButton *userPhotoBtn;
@property (weak, nonatomic) IBOutlet UIButton *showPasswordBtn;

@end

@implementation XZProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -Button Method
/**
 *  上传用户头像
 *
 */
- (IBAction)userPhotoBtnClick:(id)sender {
}

/**
 *  是否显示密码
 *
 */
- (IBAction)isShowPassword:(id)sender {
}

/**
 *  完成注册
 *
 */
- (IBAction)completedRegister:(id)sender {
    NSString *urlSring = [NSString stringWithFormat:@"%@%@",SERVERURL,@"/v1/account/register"];

    NSLog(@"url = %@", urlSring);
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:3];
    [params setObject:@"13121551578" forKey:@"phone"];
    [params setObject:[@"518103" MD5] forKey:@"pwd"];
    [params setObject:@"Tristan" forKey:@"nickname"];

    UIImage *img = [UIImage imageNamed:@"set_user_photo"];
    NSData *imaData = UIImagePNGRepresentation(img);
    __weak XZProfileViewController *weakself = self;
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:urlSring parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imaData name:@"avatar" fileName:@"set_user_photo.png" mimeType:@"image/png"];

    } success:^(NSURLSessionDataTask *task, id responseObject) {
        XZLog(@"-------%@", responseObject);
        [weakself toLoginVC];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        XZLog(@"_______%@",error);
    }];
    
}

- (void)toLoginVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
