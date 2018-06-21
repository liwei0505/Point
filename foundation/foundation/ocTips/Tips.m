//
//  Tips.m
//  foundation
//
//  Created by lee on 2018/5/24.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "Tips.h"

typedef void(^capture)(void);
capture capture2;

@implementation Tips

void aboutCopy() {
    NSString *str = @"abcdef";
    NSMutableString *str1 = [NSMutableString stringWithString:str];
    NSString *str2 = [str1 copy];
    NSString *str3 = [str1 mutableCopy];
    //是否mutable属性mutableCopy一定会新分配内存
    
    NSLog(@"%p",str);
    //mutable属性 -> copy与mutableCopy都会重新分配内存空间
    NSLog(@"%p",str1);
    NSLog(@"%p",str2);
    NSLog(@"%p",str3);
    //非mutable属性 -> copy不分配新内存指向原内存地址
    NSString *cstr = [str copy];
    NSString *mcopy = [str mutableCopy];
    NSString *p = str;
    NSLog(@"%p",cstr);
    NSLog(@"%p",mcopy);
    NSLog(@"%p",p);
}

void block2() {
    int __block global = 1000;
    NSLog(@"%d==%p",global,&global); //1000
    void (^block)(void) = ^() {
        global++;   //不加__block：改变局部变量编译不通过
        NSLog(@"%d==%p",global,&global);//1001
    };
    block();
    NSLog(@"%d==%p",global,&global);//1000
}

@end
