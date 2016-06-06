//
//  ViewController.m
//  runloop
//
//  Created by ZengChanghuan on 16/6/6.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(run) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}


@end
