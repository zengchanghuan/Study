//
//  XZAgreementViewController.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/20.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZAgreementViewController.h"

@interface XZAgreementViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation XZAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //加载网页
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Software_agreement" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}



@end
