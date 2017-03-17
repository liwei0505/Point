//
//  QueueModel.m
//  demo
//
//  Created by lee on 17/3/17.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "QueueModel.h"

@interface QueueModel()

{
    NSString *_someString;
    dispatch_queue_t _syncQueue;
}

@end

@implementation QueueModel

- (instancetype)init
{
    self = [super init];
    if (self) {
//        _syncQueue = dispatch_queue_create("syncQueue", NULL);
        _syncQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    return self;
}

#pragma mark - 串行同步队列
//思路：把set与get都放在串行同步队列中，实现线程安全

- (NSString *)someString {

    __block NSString *localSomeString;
    dispatch_sync(_syncQueue, ^{
        localSomeString = _someString;
    });
    return localSomeString;
}

//- (void)setSomeString:(NSString *)someString {
//    dispatch_sync(_syncQueue, ^{
//        _someString = someString;
//    });
//}

#pragma mark - 引入栅栏块实现写入操作
//栅栏块：并发队列中栅栏块必须单独执行，不能与其他块并行
//注意：同步比异步要快：异步需要拷贝块，拷贝块需要的时间有可能比执行块慢
- (void)setSomeString:(NSString *)someString {
    dispatch_barrier_async(_syncQueue, ^{
        _someString = someString;
    });
}

#pragma mark - 延迟执行某方法
- (void)delay {
    //方法一：
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:5.0];
    
    //方法二：
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 5.0 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self delayMethod];
    });
}

#pragma mark - 把任务放在主线程执行
- (void)onMain {
    //方法一
    [self performSelectorOnMainThread:@selector(delayMethod) withObject:nil waitUntilDone:NO];
    //方法二
    dispatch_async(dispatch_get_main_queue(), ^{
        [self delayMethod];
    });
}

- (void)delayMethod {
    NSLog(@"延迟执行");
}


@end
