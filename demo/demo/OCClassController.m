//
//  OCClassController.m
//  demo
//
//  Created by lee on 2018/6/11.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "OCClassController.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>

@interface OCClassController ()

@end

@implementation OCClassController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSObject *obj = [[NSObject alloc] init];
    
    //获得NSObject类的实例对象的大小
    // 8
    //源码：返回成员变量的大小
    NSLog(@"%zd", class_getInstanceSize([NSObject class]));
    
    //获得obj指针指向内存的大小
    // 16
    NSLog(@"%zd", malloc_size((__bridge const void *)obj));
    
    //总结：分类了16字节，利用了8个
    
}

@end
