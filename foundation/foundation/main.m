//
//  main.m
//  foundation
//
//  Created by lw on 2018/3/7.
//  Copyright © 2018年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderDemo.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        OrderDemo *o = [OrderDemo new];
        [o test3];
        [o test4];
    }
    return 0;
}
