//
//  main.cpp
//  TestC2
//
//  Created by ZengChanghuan on 16/5/29.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#include <iostream>
using namespace std;

int F (int X){
    if (X == 0) {
        return 0;
    } else {
        return 2 * F(X - 1) + X * X;
    }
}
int main(int argc, const char * argv[]) {
    // insert code here...
    
    int x;
    while (cin >> x) {
        cout << F(x) << endl;
    }
    
    return 0;
}
