//
//  SQLiteViewController.m
//  demo
//
//  Created by lw on 17/2/25.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "SQLiteViewController.h"
#import "Person.h"
#import "SQLiteManager.h"

@interface SQLiteViewController ()

@end

@implementation SQLiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self demoInsertPerson];
    //    [self demoUpdatePerson];
    //    [self demoDeletePerson];
    //    [self insertManyPerson];
    [self demoSelectPerson];
}

-(void)demoSelectPerson{
    
    NSArray *array = [NSArray array];
    Person *p = [[Person alloc]init];
    array = [p selectPerson];
    NSLog(@"%@",array);
}
//插入大量数据
-(void)insertManyPerson{
    
    double start = CFAbsoluteTimeGetCurrent();
    NSLog(@"开始");
    //开始执行事务
    [[SQLiteManager sharedManager]exeSQL:@"BEGIN TRANSACTION;"];
    for (int i = 0; i < 2000; i++) {
        NSDictionary *dict = @{@"name":[NSString stringWithFormat:@"wangwu-%d",i],@"age":@20,@"height":@2.5,@"title":@"student"};
        Person *p = [Person personWithDict:dict];
        [p insertPerson];
        
        //执行回滚 模拟失败
        //        if (i == 1000) {
        //            [[SQLiteManager sharedManager] exeSQL:@"ROLLBACK TRANSACTION;"];
        //            break;
        //        }
    }
    //提交事务
    [[SQLiteManager sharedManager] exeSQL:@"COMMIT TRANSACTION;"];
    NSLog(@"结束%f",(CFAbsoluteTimeGetCurrent() - start));
}

-(void)demoDeletePerson{
    
    NSDictionary *dict = @{@"id":@10};
    Person *p = [Person personWithDict:dict];
    if ([p deletePerson]) {
        NSLog(@"删除%@成功",dict[@"id"]);
    }else{
        NSLog(@"删除失败");
    }
}
-(void)demoUpdatePerson{
    
    NSDictionary *dict = @{@"id":@3,@"name":@"aisi",@"age":@20,@"height":@2.5,@"title":@"火拳艾斯"};
    Person *p = [Person personWithDict:dict];
    if ([p updatePerson]) {
        NSLog(@"更新成功");
    }else{
        NSLog(@"更新失败");
    }
}

-(void)demoInsertPerson{
    
    NSDictionary *dict = @{@"name":@"wangwu",@"age":@20,@"height":@2.5,@"title":@"student"};
    Person *person = [Person personWithDict:dict];
    if ([person insertPerson]) {
        NSLog(@"插入成功 %@",person);
    }else{
        NSLog(@"插入失败");
    }
}

@end
