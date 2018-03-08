//
//  OrderDemo.m
//  foundation
//
//  Created by lw on 2018/3/7.
//  Copyright © 2018年 lee. All rights reserved.
//
/*
 typedef NS_ENUM(NSInteger, NSComparisonResult) {
 NSOrderedAscending = -1L, //值为－1 代表升序排列
 NSOrderedSame,            //值为0
 NSOrderedDescending       //值为1   待变降序排列
 };
 
*/

#import "OrderDemo.h"

//NSComparisonResult和NSComparator
@implementation OrderDemo

- (void)test1 {
    NSString *a = @"aaaA";//'A'的ASCII码值是65
    NSString *b = @"aaaa";//'a'的ASCII码值是97
    NSComparisonResult comparisonResult = [a compare:b];
    if (comparisonResult == NSOrderedAscending) {
        NSLog(@"b > a");
    } else if (comparisonResult == NSOrderedDescending) {
        NSLog(@"a > b");
    } else if (comparisonResult == NSOrderedSame) {
        NSLog(@"a = b");
    }
    NSLog(@"comparisonResult = %ld",comparisonResult);
}

- (void)test2 {
    NSNumber *num1 = [[NSNumber alloc]initWithFloat:15.5];
    NSNumber *num2 = [[NSNumber alloc]initWithFloat:15.5];
    NSComparisonResult result = [num1 compare:num2];
    if (result == NSOrderedSame) {
        NSLog(@"a");
    }
    NSLog(@"result = %ld",result);
}

- (void)test3 {
//升序
    NSArray *stringArray = [NSArray arrayWithObjects:@"abc 21", @"abc 1", @"abc 12",@"abc 13",@"abc 05",nil];
    NSComparator sortBlock = ^(id string1, id string2) {
        return [string1 compare:string2];
//        return (NSComparisonResult)NSOrderedDescending;
    };
    
    //利用数组的sortedArrayUsingComparator调用 NSComparator ，obj1和obj2指的数组中的对象
    NSArray *sortArray = [stringArray sortedArrayUsingComparator:sortBlock];
    NSLog(@"sortArray = %@", sortArray);
    
    //或者(升序)
    NSArray *sortArray1 = [stringArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
    }];
    NSLog(@"sortArray1 = %@", sortArray1);
}

- (void)test4 {
//降序
    NSArray *numArray = [NSArray arrayWithObjects:@1,@21,@12,@13,@05,nil];
    
    NSComparator com = ^(id obj1, id obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    NSArray *sortNumArray = [numArray sortedArrayUsingComparator:com];
//    NSArray *sortNumArray = [numArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
//        if ([obj1 integerValue] > [obj2 integerValue]) {
//            return (NSComparisonResult)NSOrderedAscending;
//        }
//        if ([obj1 integerValue] < [obj2 integerValue]) {
//            return (NSComparisonResult)NSOrderedDescending;
//        }
//        return (NSComparisonResult)NSOrderedSame;
//    }];
    NSLog(@"sortNumArray = %@",sortNumArray);
}

@end
