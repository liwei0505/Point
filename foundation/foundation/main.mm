//
//  main.m
//  foundation
//
//  Created by lw on 2018/3/7.
//  Copyright © 2018年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "SortHelper.hpp"
#import <objc/message.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *p = [Person alloc];
        p = [p init];
        
//        getchar(); //防止屏幕退出，接收一个字符才退出
    }
    return 0;
}

void cppSortDemo() {
    int n = 10;
    int *arr = SortHelper::generateRandomArray(n, 5, 9);
    for (int i=0; i<n; i++) {
        NSLog(@"%d",arr[i]);
    }
}

