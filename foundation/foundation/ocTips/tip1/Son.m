//
//  Son.m
//  foundation
//
//  Created by lee on 2018/4/28.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "Son.h"

@implementation Son
- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"%@",NSStringFromClass([self class]));
        NSLog(@"%@",NSStringFromClass([super class]));
    }
    return self;
}
@end
