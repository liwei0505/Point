//
//  EOCPerson+Friendship.h
//  demo
//
//  Created by lee on 17/3/7.
//  Copyright © 2017年 lee. All rights reserved.
/*
   关联对象实现给categry添加属性
   注意：不建议将数据放在分类中，放在主接口里
*/

#import "EOCPerson.h"

@interface EOCPerson (Friendship)

@property(strong, nonatomic) NSArray *friends;

- (BOOL)isFriendsWith:(EOCPerson *)person;

@end
