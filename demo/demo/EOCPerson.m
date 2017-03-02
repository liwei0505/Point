//
//  EOCPerson.m
//  demo
//
//  Created by lee on 17/3/2.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "EOCPerson.h"

@implementation EOCPerson

- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {

    if (self = [super init]) {
        _firstName = firstName;
        _lastName = lastName;
    }
    return self;
}

- (NSString *)description {

    return [NSString stringWithFormat:@"<%@: %p, %@>",[self class], self, @{@"firstName":_firstName,@"lastName":_lastName}];
}

//断点控制台输出 po 时候调用此方法
//- (NSString *)debugDescription {
//
//}

@end
