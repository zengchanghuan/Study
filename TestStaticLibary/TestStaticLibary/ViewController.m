//
//  ViewController.m
//  TestStaticLibary
//
//  Created by ZengChanghuan on 16/5/18.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "ViewController.h"
#import "XZTool.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int sum = [XZTool sum:1 andNum2:3];
    NSLog(@"%d",sum);
}


@end
