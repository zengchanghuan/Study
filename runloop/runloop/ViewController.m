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
    
    UIView *animationView = [UIView new];
    animationView.frame = CGRectMake(0, 0, 100, 100);
    animationView.center = self.view.center;
    animationView.backgroundColor = [UIColor grayColor];
    animationView.layer.cornerRadius = CGRectGetWidth(animationView.frame) * 0.5;
    [self.view addSubview:animationView];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 2.5;
    animation.repeatCount = 9999;
    animation.autoreverses = YES;
    animation.fromValue = @(1.0);
    animation.toValue = @(2.0);
    
    [animationView.layer addAnimation:animation forKey:@"animationView.scale"];

//    NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(run) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}


@end
