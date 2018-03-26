//
//  GCDDemoController.m
//  demo
//
//  Created by lee on 2018/3/26.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "GCDDemoController.h"

@interface GCDDemoController ()

@end

@implementation GCDDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self demo5];
}

//并发队列
- (void)demo6 {
    
}


//串行队列 同步执行
- (void)demo5 {
    //串行队列任务是一个接一个完成的，同步执行不开新线程
    //只开一个线程，所以按顺序执行 come here等前边执行完再执行
    dispatch_queue_t q = dispatch_queue_create("chuanxing_queue", DISPATCH_QUEUE_SERIAL);
    for (int i=0; i<10; i++) {
        dispatch_sync(q, ^{
            NSLog(@"%@",[NSThread currentThread]);
        });
    }
    NSLog(@"come here%@",[NSThread currentThread]);//在最后执行
}

//串行队列 异步执行
- (void)demo4 {
    //串行队列任务是一个接一个完成的，开线程是因为是异步执行
    //由于开线程了log在子线程中执行，come here在主线程执行，所以顺序无法预计
    dispatch_queue_t q = dispatch_queue_create("chuanxing_queue", DISPATCH_QUEUE_SERIAL);
    for (int i=0; i<10; i++) {
        dispatch_async(q, ^{
            NSLog(@"%@",[NSThread currentThread]);
        });
    }
    NSLog(@"come here%@",[NSThread currentThread]);//不一定在什么时候执行
}

//线程间通讯
- (void)demo3 {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"耗时操作%@",[NSThread currentThread]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"更新UI%@",[NSThread currentThread]);
        });
    });
}

// 异步：会开启线程
- (void)demo1 {
    //全局队列
    dispatch_queue_t q = dispatch_queue_create(0, 0);
    void (^block)(void) = ^(void) {
        NSLog(@"%@",[NSThread currentThread]);
    };
    dispatch_async(q, block);
}

//同步:不开启新线程，在当前线程执行
- (void)demo2 {
    dispatch_queue_t q = dispatch_queue_create(0, 0);
    void (^block)(void) = ^(void) {
        NSLog(@"%@",[NSThread currentThread]);
    };
    dispatch_sync(q, block);
}

@end
