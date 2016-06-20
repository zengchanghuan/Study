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

@end

@implementation XZVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)phoneSucced:(id)sender {
    [self.navigationController pushViewController:[XZNewPasswordViewController new] animated:YES];
}


@end
