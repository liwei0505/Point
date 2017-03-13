//
//  EOCDataModel.m
//  demo
//
//  Created by lee on 17/3/3.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "EOCDataModel.h"

@interface EOCDataModel() <EOCNetworkFetcherDelegate>

@property (strong, nonatomic) NSData *data;

@end

@implementation EOCDataModel

#pragma mark - block

- (void)fetchBlockData {
    NSURL *url = [NSURL URLWithString:@""];
    EOCNetworkFetcher *fetcher = [[EOCNetworkFetcher alloc] initWithURL:url];
    [fetcher startWithCompletionHandler:^(NSData *data) {
        _data = data;
    } failureHandler:^(NSError *error) {
       //handle failure
    }];
}

#pragma mark - delegate

- (void)fetchFooData {
    EOCNetworkFetcher *fetcher = [[EOCNetworkFetcher alloc] init];
    fetcher.delegate = self;
}

- (void)networkFetcher:(EOCNetworkFetcher *)fetcher didReceiveData:(NSData *)data {
    _data = data;
}

- (void)networkFetcher:(EOCNetworkFetcher *)fetcher didFailWithError:(NSError *)error {}

@end
