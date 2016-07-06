//
//  XZHomefooterView.m
//  SportClub
//
//  Created by ZengChanghuan on 16/6/29.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZHomeFooterView.h"
@interface XZHomeFooterView()
@property (weak, nonatomic) IBOutlet UIView *moreUserView;

@end
@implementation XZHomeFooterView

- (IBAction)moreUser:(id)sender {
}

+(instancetype)footer
{
    return [[[NSBundle mainBundle]loadNibNamed:@"XZHomeFooterView" owner:nil options:nil]lastObject];
}

@end
