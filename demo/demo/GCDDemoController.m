//
//  GCDDemoController.m
//  demo
//
//  Created by lee on 2018/3/26.
//  Copyright © 2018年 lee. All rights reserved.
/*
    同步不开线程，异步开
    （异步）开线程数：串行队列开一条，并发队列n条，条数由GCD决定
 */

#import "GCDDemoController.h"
#import "Singleton.h"

@interface GCDDemoController ()

@end

@implementation GCDDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [Singleton test];
    [self demo12];
}

#pragma mark - 调度组
- (void)demo12 {
    //group监听任务 queue调度任务
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t q = dispatch_get_global_queue(0, 0);
    
    dispatch_group_async(group, q, ^{
        NSLog(@"no1 %@",[NSThread currentThread]);
    });
    dispatch_group_async(group, q, ^{
        NSLog(@"no2 %@",[NSThread currentThread]);
    });
    dispatch_group_async(group, q, ^{
        NSLog(@"no3 %@",[NSThread currentThread]);
    });
    
    //监听所有任务完成后 由队列调度block中任务
//    dispatch_group_notify(group, q, ^{
//        NSLog(@"completion %@",[NSThread currentThread]);
//    });
    //也可以设置队列
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"completion %@",[NSThread currentThread]);
    });
    
    //群组等待 等到所有任务完成：阻塞式等待 群组任务不执行完后序代码不执行
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

#pragma mark - 全局队列
//本身是一个并发队列，方便用提供的
- (void)demo11 {
    //参数1:优先级（宏） DISPATCH_QUEUE_PRIORITY_DEFAULT(7.0) QOS_CLASS_UTILITY(8.0以上)
    //    2:保留参数：为0
    dispatch_queue_t q = dispatch_get_global_queue(0, 0);
    
}

#pragma mark - 同步执行的作用
- (void)demo10 {
    dispatch_queue_t q = dispatch_queue_create("dependent", DISPATCH_QUEUE_CONCURRENT);
    //异步队列同步执行 可以让任务 依赖 某一个任务
    //登录后才能下载
//    dispatch_sync(q, ^{ //同步任务不执行完不会继续执行，会马上执行login
//        NSLog(@"login %@",[NSThread currentThread]);
//    });
//    // login后会开线程异步执行下边两个任务
//    dispatch_async(q, ^{
//        NSLog(@"download a %@",[NSThread currentThread]);
//    });
//
//    dispatch_async(q, ^{
//        NSLog(@"download b %@",[NSThread currentThread]);
//    });
    
/*登录耗时不能在主线程*/
//    dispatch_async(q, ^{
//        NSLog(@"login %@",[NSThread currentThread]);
//        dispatch_async(q, ^{
//            NSLog(@"download a %@",[NSThread currentThread]);
//        });
//
//        dispatch_async(q, ^{
//            NSLog(@"download b %@",[NSThread currentThread]);
//        });
//    });
    
    void (^task)(void) = ^ {
        dispatch_sync(q, ^{ //同步任务不执行完不会继续执行，会马上执行login
            NSLog(@"login %@",[NSThread currentThread]);
        });
        // login后会开线程异步执行下边两个任务
        dispatch_async(q, ^{
            NSLog(@"download a %@",[NSThread currentThread]);
        });
    
        dispatch_async(q, ^{
            NSLog(@"download b %@",[NSThread currentThread]);
        });
    };
    
    dispatch_async(q, task);
    
}

#pragma mark - 主队列

//主队列同步执行
//主队列与主线程互相等待：死锁
- (void)demo9 {
    NSLog(@"aaaaaa");
    dispatch_queue_t q = dispatch_get_main_queue();
    for (int i=0; i<10; i++) {
        dispatch_sync(q, ^{
            NSLog(@"%@--%d",[NSThread currentThread],i);
        });
    }
    NSLog(@"sleep");
    [NSThread sleepForTimeInterval:1.0];
    NSLog(@"come here");
    
}

//主队列：负责在主线程调度任务，所有任务在主线程执行
//主队列（队列调度任务）与主线程（线程执行代码）不是一个概念
- (void)demo8 {
    //主队列：程序启动，主线程就已经存在，主队列也同时存在了，只需获取 不需要创建
    dispatch_queue_t q = dispatch_get_main_queue();
    for (int i=0; i<10; i++) {
        dispatch_async(q, ^{
            NSLog(@"%@--%d",[NSThread currentThread],i);
        });
    }
    NSLog(@"sleep");
    [NSThread sleepForTimeInterval:1.0];
    NSLog(@"come here");
}

#pragma mark - 队列

//并发队列 同步执行
//不开线程 顺序执行
- (void)demo7 {
    dispatch_queue_t q = dispatch_queue_create("bingfa_queue", DISPATCH_QUEUE_CONCURRENT);
    for (int i=0; i<10; i++) {
        dispatch_sync(q, ^{
            NSLog(@"%@  %d",[NSThread currentThread], i);
        });
    }
    NSLog(@"come here");
}

//并发队列           异步执行
//同时调度多个任务     可以开启线程
//队列：本质上是‘先进先出’ 具体执行由CPU决定！
- (void)demo6 {
    dispatch_queue_t q = dispatch_queue_create("bingfa_queue", DISPATCH_QUEUE_CONCURRENT);
    for (int i=0; i<10; i++) {
        dispatch_async(q, ^{
            NSLog(@"%@  %d",[NSThread currentThread], i);
        });
    }
    NSLog(@"come here");
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