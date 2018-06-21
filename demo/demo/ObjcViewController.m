//
//  ObjcViewController.m
//  demo
//
//  Created by lee on 2018/6/8.
//  Copyright © 2018年 lee. All rights reserved.
/*
    消息发送机制
 */

#import "ObjcViewController.h"
#import "Person.h"
#import <objc/message.h>

@interface ObjcViewController ()

@end

@implementation ObjcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    alloc 分配内存空间 底层malloc()
//    init 初始化属性和方法
//    Person *p = [[Person alloc] init];
    // ==>
//    Person * p = objc_msgSend([Person class], @selector(alloc));
    // ==>
//    NSClassFromString(@"Person"); //底层 ==>
//    objc_getClass("Person")
    Person * p = objc_msgSend(objc_getClass("Person"), sel_registerName("alloc"));
//    p = objc_msgSend(p, @selector(init));
    // ==>
    p = objc_msgSend(p, sel_registerName("init"));
    
    [p eat];
}


@end
