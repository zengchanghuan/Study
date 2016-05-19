//
//  ViewController.m
//  QR
//
//  Created by ZengChanghuan on 16/5/19.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *image;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self creartqr];
}

/**
 *  生成二维码
 */
- (void)creartqr
{
    //实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性,因为滤境有可能保存上次的属性
    [filter setDefaults];
    
    //将字符串转换成NSData
    NSData *data = [@"http://www.bing.com/?mkt=zh-CN" dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜,传入data,将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    
    //生成二维码
    CIImage *outputImage = [filter outputImage];
    
    UIImage *image = [UIImage imageWithCIImage:outputImage];
    
    
    //设置生成好的二维码到image
    _image.image = image;

}
@end
