//
//  NSThreadDemoController.m
//  demo
//
//  Created by lee on 2018/3/23.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "NSThreadDemoController.h"

@interface NSThreadDemoController ()

@end

@implementation NSThreadDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self demo4];
}

#pragma mark - 创建、执行线程、线程属性

- (void)demo1 {
    //新建线程可以控制执行时间
    NSThread *t = [[NSThread alloc] initWithTarget:self selector:@selector(longOperation:) object:@"NSThread"];
    
    //线程被添加到可调度线程池，就绪状态等待cpu调度执行（并不是start就马上执行）
    t.name = @"app thread";
    
    //栈区大小512k 可以修改
    [NSThread currentThread].stackSize = 1024 * 1024; //1M
    [t start];
}

- (void)demo2 {
    //新建线程直接添加到调度线程池
    [NSThread detachNewThreadSelector:@selector(longOperation:) toTarget:self withObject:@"detach"];
}

- (void)demo3 {
    //NSObject的一个分类方法
    //新建线程直接添加到调度线程池
    [self performSelectorInBackground:@selector(longOperation:) withObject:@"in back"];
}

- (void)longOperation:(id)obj {
    for (int i=0; i<10; i++) {
        NSLog(@"%@--%d--%@--线程名%zd--栈区大小%tuK",[NSThread currentThread], i, obj,[NSThread currentThread].name,[NSThread currentThread].stackSize/1024);
    }
}

#pragma mark - 线程阻塞、死亡状态

- (void)demo4 {
    NSThread *t = [[NSThread alloc] initWithTarget:self selector:@selector(blockOperation:) object:nil];
    [t start];
}

- (void)blockOperation:(id)obj {
    NSLog(@"sleep");
    //sleep 1s
    [NSThread sleepForTimeInterval:1.0];
    for (int i=0; i<10; i++) {
        NSLog(@"%@--%d--%@",[NSThread currentThread], i, obj);
        if (i==5) {
            NSLog(@"sleep again");
            //sleep到date的时间
            [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
        }
        if (i==8) {
            //退出当前线程，一旦退出后续代码都不会执行
            //注意：直接执行exit退出后不会清理资源，注意release
            //⚠️不能在主线程exit，程序就挂了
            [NSThread exit];
        }
    }
    NSLog(@"线程死亡后我不会输出");
}

#pragma mark - 线程属性

- (void)demo5 {
    
}


@end
