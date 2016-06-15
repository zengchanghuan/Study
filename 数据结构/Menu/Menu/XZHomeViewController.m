//
//  XZHomeViewController.m
//  Menu
//
//  Created by ZengChanghuan on 16/6/15.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZHomeViewController.h"
#import "XZDock.h"
//竖屏时的宽度
const CGFloat XZDoctPW = 150;
//横屏时宽度
const CGFloat XZDoctLW = 180;

const CGFloat XZScreenW = 768;
const CGFloat XZScreenH = 1024;

@interface XZHomeViewController ()
@property (weak, nonatomic) XZDock *dock;
@end

@implementation XZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XZDock *dock = [XZDock new];
    dock.width = 150;
    dock.height = self.view.height;
    _dock = dock;
    [self.view addSubview:dock];
    
    //根据屏幕方向设置dock属性
    [self willRotateToInterfaceOrientation:self.interfaceOrientation duration:0];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    
}

/*
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        NSLog(@"横屏");
        _dock.width = XZDoctLW;
        _dock.height = XZScreenW;
    } else {
        NSLog(@"竖屏");
        _dock.width = XZDoctPW;
        _dock.height = XZScreenH;
    }
}
*/

@end
