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

    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:3];
    [params setObject:@"13121551578" forKey:@"phone"];
    [params setObject:[@"518103" MD5] forKey:@"pwd"];
    [params setObject:@"Tristan" forKey:@"nickname"];
    
    UIImage *img = [UIImage imageNamed:@"set_user_photo"];
    NSData *imaDaga = UIImagePNGRepresentation(img);
    
  
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:urlSring parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imaDaga name:@"avatar" fileName:@"set_user_photo" mimeType:@"image/png"];

        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        XZLog(@"註冊成功");

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XZLog(@"注册接口%@",error);

    }];
    

}

@end
