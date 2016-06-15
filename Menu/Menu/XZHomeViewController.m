//
//  XZHomeViewController.m
//  Menu
//
//  Created by ZengChanghuan on 16/6/15.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZHomeViewController.h"
#import "XZDock.h"


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

//-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
//{
//    
//}


-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) { // 横屏
        self.dock.width = HMDockLW;
        self.dock.height = HMScreenPW;
    } else { // 竖屏
        self.dock.width = HMDockPW;
        self.dock.height = HMScreenLW;
    }
}


@end
