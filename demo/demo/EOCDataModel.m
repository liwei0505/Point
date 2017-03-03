//
//  EOCDataModel.m
//  demo
//
//  Created by lee on 17/3/3.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "EOCDataModel.h"
#import "EOCNetworkFetcher.h"

@interface EOCDataModel() <EOCNetworkFetcherDelegate>

@end

@implementation EOCDataModel

- (void)networkFetcher:(EOCNetworkFetcher *)fetcher didReceiveData:(NSData *)data {}

- (void)networkFetcher:(EOCNetworkFetcher *)fetcher didFailWithError:(NSError *)error {}

@end
