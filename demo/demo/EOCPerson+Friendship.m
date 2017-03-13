//
//  EOCPerson+Friendship.m
//  demo
//
//  Created by lee on 17/3/7.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "EOCPerson+Friendship.h"
#import <objc/runtime.h>

static const NSString *kFriendsPropertyKey = @"kFriendsPropertyKey";

@implementation EOCPerson (Friendship)

- (BOOL)isFriendsWith:(EOCPerson *)person {

    return [self.friends containsObject:person];
}

- (NSArray *)friends {
    return objc_getAssociatedObject(self, (__bridge const void *)(kFriendsPropertyKey));
}

- (void)setFriends:(NSArray *)friends {
    objc_setAssociatedObject(self, (__bridge const void *)(kFriendsPropertyKey), friends, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
