//
//  main.m
//  RegularExpressions
//
//  Created by ZengChanghuan on 16/5/23.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //5-11
        NSString *qq = @"249998620122";
        NSString *pattern = @"^\\d{5,11}$";
        NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
        NSArray *results = [regex matchesInString:qq options:0 range:NSMakeRange(0, qq.length)];
        NSLog(@"%zd",results.count);
    }
    return 0;
}
