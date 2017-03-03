//
//  EOCNetworkFetcher.m
//  demo
//
//  Created by lee on 17/3/3.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "EOCNetworkFetcher.h"

@interface EOCNetworkFetcher()
{
    //在实例中嵌入一个含有“位段”的结构体，每个位段表示delegate对象是否实现了协议中的相关方法。
    //相关方法调用多次时就不用每次都检查委托对象是否能响应某个选择子，优化程序效率
    struct {
        unsigned int didReceiveData         : 1;
        unsigned int didFailWithError       : 1;
        unsigned int didUpdateProgressTo    : 1;
    } _delegateFlags;
}
@end

@implementation EOCNetworkFetcher

- (void)callDelegateMethod {

    NSData *data = nil;
    if ([self.delegate respondsToSelector:@selector(networkFetcher:didReceiveData:)]) {
        [self.delegate networkFetcher:self didReceiveData:data];
    }
    
    //如果方法过多，优化程序，不用每次都检测，引入“位段”结构体
    if (_delegateFlags.didFailWithError) {
        NSError *error = nil;
        [self.delegate networkFetcher:self didFailWithError:error];
    }
    
}

//缓存delegeta是否能响应特定选择子
- (void)setDelegate:(id<EOCNetworkFetcherDelegate>)delegate {
    _delegate = delegate;
    _delegateFlags.didReceiveData = [delegate respondsToSelector:@selector(networkFetcher:didReceiveData:)];
    _delegateFlags.didFailWithError = [delegate respondsToSelector:@selector(networkFetcher:didFailWithError:)];
}

@end
