//
//  main.m
//  licenseTest
//
//  Created by ZengChanghuan on 16/9/28.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "License.h"
#import "NSDictionary+KeepNilSafe.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
      
        
        
        
        NSString *name = [NSString stringWithFormat:@"%s", __FILE__];
        NSRange range = [name rangeOfString:[name lastPathComponent]];
        NSString *jsonPath = [[name substringToIndex:range.location] stringByAppendingString:@"license2.txt"];
        NSData *data = [NSData dataWithContentsOfFile:jsonPath];
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"rootDic = %@",rootDic);

        NSError *err;
        NSData *jsonData = [NSJSONSerialization  dataWithJSONObject:rootDic options:kNilOptions error:&err];
        NSString *myString = [[NSString alloc] initWithData:jsonData   encoding:NSUTF8StringEncoding];
        NSString *newString = [myString stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];

        NSLog(@"%@",newString);
        
    }
    return 0;
}

