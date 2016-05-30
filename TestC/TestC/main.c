//
//  main.c
//  TestC
//
//  Created by ZengChanghuan on 16/5/29.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#include <stdio.h>



int F (int X){
    if (X == 0) {
        return 0;
    } else {
        return 2 * F(X - 1) + X * X;
    }
}
int main(int argc, const char * argv[]) {
    // insert code here...
    
    return 0;
}
