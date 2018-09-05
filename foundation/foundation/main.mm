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

#import "StringTest.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        Person *p = [Person alloc];
//        p = [p init];
//        NSURL *url = [NSURL URLWithString:@"https://www.jianshu.com/p/41ecb06ae95f"];
        
//        getchar(); //防止屏幕退出，接收一个字符才退出
    
//        dispatch_queue_t q = dispatch_get_global_queue(0, 0);
//        dispatch_sync(q, ^{
//            NSLog(@"%@",[NSThread currentThread]);
//        });
//        dispatch_async(q, ^{
//            NSLog(@"%@",[NSThread currentThread]);
//        });
        
//        NSString *str = @"cheet";
//        str = @"cheetmmmm";
//        void(^block)() = ^{
//            NSLog(@"%@",str);
//        };
//        str = @"moble";
//        block();
        
//
//        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:10];
//        for(int i=0; i<10; i++) {
//            [arr addObject:[NSNumber numberWithInt:i]];
//        }
//
//        for(NSNumber *num in arr){
//            [arr removeObject:num];
//        }
 
        for (int i=0; i<50; i++) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSLog(@"%@",[NSThread currentThread]);
                sleep(10);
            });
        }
        NSLog(@"finish");
    }
    return 0;
}

void sortArray() {
    NSArray *array = @[@"b",@"f",@"a",@"e",@"g"];
    //用系统默认compare方法排序：只支持升序
    NSArray *a = [array sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"%@%@",a,array);
}

void stringTest() {
    NSMutableString *mstr = [NSMutableString stringWithFormat:@"abc"];
    StringTest *t = [[StringTest alloc] init];
    t.test = mstr;
    
    [t.test stringByAppendingString:@"def"];
    
    NSLog(@"%@",t.test);
    [mstr insertString:@"mmm" atIndex:1];
    NSLog(@"%@",t.test);
}

void cppSortDemo() {
    int n = 10;
    int *arr = SortHelper::generateRandomArray(n, 5, 9);
    for (int i=0; i<n; i++) {
        NSLog(@"%d",arr[i]);
    }
}

