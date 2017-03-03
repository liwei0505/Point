//
//  EOCNetworkFetcher.h
//  demo
//
//  Created by lee on 17/3/3.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EOCNetworkFetcher;
@protocol EOCNetworkFetcherDelegate <NSObject>

- (void)networkFetcher:(EOCNetworkFetcher *)fetcher didReceiveData:(NSData *)data;
@optional
- (void)networkFetcher:(EOCNetworkFetcher *)fetcher didFailWithError:(NSError *)error;

@end

@interface EOCNetworkFetcher : NSObject
@property (weak, nonatomic) id <EOCNetworkFetcherDelegate> delegate;
@end
