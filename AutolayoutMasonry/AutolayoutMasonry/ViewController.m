//
//  ViewController.m
//  AutolayoutMasonry
//
//  Created by ZengChanghuan on 16/6/16.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "ViewController.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *blueView = [UIView new];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    
    
    
    [blueView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(20);
        make.right.offset(-20);
        make.top.offset(20);
        make.bottom.offset(-20);
        
    }];
    
    
}

- (void)test2
{
    UIView *blueView = [UIView new];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(50, 50, 50, 50));
        
    }];
}
- (void)test1
{
    UIView *blueView = [UIView new];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50);
        make.right.offset(-50);
        make.top.offset(50);
        make.bottom.offset(-50);
    }];
}
@end
