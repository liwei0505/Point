//
//  ViewController.m
//  demo
//
//  Created by lw on 17/2/25.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "ViewController.h"
#import "EOCEmployee.h"
#import "EOCAutoDictionary.h"

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

//动态方法解析
//其他属性相似，要添加新属性，用@property定义，声明为@dynamic即可
//CoreAnimation框架中，CALayer就用了类似实现方式，使得CALayer成为“兼容于键值编码的”容器类，能随意添加属性，键值对形式访问
//于是，开发者可以向其中新增自定义属性，这些值的存储工作由基类直接负责，只要在CALayer子类中定义新属性即可
- (void)autoSelector {
    EOCAutoDictionary *dict = [EOCAutoDictionary new];
    dict.date = [NSDate dateWithTimeIntervalSince1970:475372800];
    NSLog(@"date = %@",dict.date);
    
}

@end
