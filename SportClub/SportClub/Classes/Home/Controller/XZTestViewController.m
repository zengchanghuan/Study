//
//  XZTestViewController.m
//  SportClub
//
//  Created by ZengChanghuan on 16/7/26.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "XZTestViewController.h"

@interface XZTestViewController ()

@end

@implementation XZTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
        
}


- (NSString *)getTimeNow
{
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    //[formatter setDateFormat:@"YYYY.MM.dd.hh.mm.ss"];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
    date = [formatter stringFromDate:[NSDate date]];
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@", date];
    NSLog(@"%@", timeNow);
    return timeNow;
}
@end
