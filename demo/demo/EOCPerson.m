//
//  EOCPerson.m
//  demo
//
//  Created by lee on 17/3/2.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "EOCPerson.h"

@implementation EOCPerson {
    NSMutableSet *_friends;
}

- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {

    if (self = [super init]) {
        _firstName = [firstName copy];
        _lastName = [lastName copy];
        _friends = [NSMutableSet new];
    }
    return self;
}



#pragma mark - 实现copy功能
//1.遵守NSCopying协议 2.实现copyWithZone:
//之前会把内存分成不同的区zone，现在每个程序只有一个zone
- (id)copyWithZone:(NSZone *)zone {
    EOCPerson *copy = [[[self class] allocWithZone:zone] initWithFirstName:_firstName lastName:_lastName];
    
    //浅拷贝
    copy->_friends = [_friends mutableCopy];//不是属性，不能用点语法
    return copy;
}

//深拷贝
- (instancetype)deepCopy {
    EOCPerson *copy = [[[self class] alloc] initWithFirstName:_firstName lastName:_lastName];
    
    //YES：该方法会向数组中的每个元素发送copy消息，用copy好的元素创建新的set
    copy->_friends = [[NSMutableSet alloc] initWithSet:_friends copyItems:YES];
    return copy;
}

- (void)addFriend:(EOCPerson *)person {
    [_friends addObject:person];
}

- (void)removeFriend:(EOCPerson *)person {
    [_friends removeObject:person];
}

#pragma mark - description

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, %@>",[self class], self, @{@"firstName":_firstName,@"lastName":_lastName}];
}

//断点控制台输出 po 时候调用此方法
//- (NSString *)debugDescription {
//
//}



@end
