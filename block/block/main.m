//
//  main.m
//  block
//
//  Created by ZengChanghuan on 16/8/25.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  block
 1.可以保存代码
 2.有返回值
 3.有形参
 4.也是一种数据类型
 */

typedef int (^MyBlock)(int, int);
int main(int argc, const char * argv[]) {
    @autoreleasepool {
    
        MyBlock sumBlock = ^(int a,int b){
            return a + b;
        };
        
        NSLog(@"%d",sumBlock(1,3));
    }
    return 0;
}

/**
 *  有返回值，有形参的block
 */
void test2()
{
    int (^sumblock)(int,int) = ^(int a,int b){
        return a + b;
    };
}

/**
 *  没有返回值，没有形参的block
 */
void test()
{
    void (^myblock)() = ^{
        NSLog(@"block");
    };
}