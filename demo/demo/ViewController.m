//
//  ViewController.m
//  demo
//
//  Created by lw on 17/2/25.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "ViewController.h"
#import "EOCEmployee.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//类族模式 通过父类type创建不同子类使接口简单，但实际仍是返回的子类，并且执行的也是子类的方法
- (void)clusterDemo {

    EOCEmployee *developer = [EOCEmployee employeeWithType:EOCEmployeeTypeDeveloper];
    NSLog(@"%@",developer);
    [developer doADaysWork];
}


@end
