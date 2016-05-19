//
//  ViewController.m
//  ReadQR
//
//  Created by ZengChanghuan on 16/5/19.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) AVCaptureSession *session;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //实例化拍摄设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //设备输入设备
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    //实例化拍摄元数据输出
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    //数据代理
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //实例化拍摄会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    
    //添加会话输入
    [session addInput:input];
    
    //添加会话输出
    [session addOutput:output];
    
    //设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    //实例化预览图层
    AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession:session];
    preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    preview.frame = self.view.bounds;
    [self.view.layer insertSublayer:preview atIndex:100];
    self.previewLayer = preview;
    [session startRunning];
    
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    // 会频繁的扫描，调用代理方法
    // 1. 如果扫描完成，停止会话
    [self.session stopRunning];
    // 2. 删除预览图层
    [self.previewLayer removeFromSuperlayer];
    
//    NSLog(@"%@", metadataObjects);
    // 3. 设置界面显示扫描结果
    
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        // 提示：如果需要对url或者名片等信息进行扫描，可以在此进行扩展！
        //        _label.text = obj.stringValue;
        NSLog(@"%@", obj.stringValue);
    }
}

@end
