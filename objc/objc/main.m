//
//  main.m
//  objc
//
//  Created by lee on 2018/6/8.
//  Copyright © 2018年 mjsfax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <malloc/malloc.h>

@interface Person : NSObject {
    int _age;
}
@property (assign, nonatomic) int height;
@end
@implementation Person
@end

@interface Student : Person {
    int _no;
    @public
    int _name;
}
@end
@implementation Student
@end

//person中不增加@property属性时类的结构
void classSizeDemoNoProperty() {
    
    /*  整体16bit因为：NSObject虽然分配16bit，但是isa只占用8bit
                    还有8bit的空闲，age跟着isa后占用4字节，所以整体下来还是16bit
                    符合内存对其规则：16位最大成员的倍数
     
         struct Person_IMPL {
         struct NSObject_IMPL NSObject_IVARS;   //16bit
         int _age;                              //4bit
         };
     */
    Person *person = [[Person alloc] init];
    NSLog(@"person-%zd", class_getInstanceSize([Person class]));//成员变量对其后占的内存空间
    NSLog(@"person-%zd", malloc_size((__bridge const void *)(person)));//系统分配的内存空间
    
    /*  整体为16bit因为： isa8bit，Person中age 4bit，还有4bit的空闲内存存放no
                    符合内存对其规则：16位最大成员的倍数
         struct Student_IMPL {
         struct Person_IMPL Person_IVARS;
         int _no;
         };
     
     */
    Student *stu = [[Student alloc] init];
    NSLog(@"stu-%zd", class_getInstanceSize([Student class]));
    NSLog(@"stu-%zd", malloc_size((__bridge const void *)(stu)));
    stu->_name = 2;
    
    
}

//person中增加@property属性类的结构
void classSizeDemoHasProperty() {
    /*
     struct Person_IMPL {
     struct NSObject_IMPL NSObject_IVARS;
     int _age;
     int _height;
     };
     
     //implement中自动生成的set、get方法
     static int _I_Person_height(Person * self, SEL _cmd) { return (*(int *)((char *)self + OBJC_IVAR_$_Person$_height)); }
     static void _I_Person_setHeight_(Person * self, SEL _cmd, int height) { (*(int *)((char *)self + OBJC_IVAR_$_Person$_height)) = height; }
     */
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //实例对象
        NSObject *object1 = [[NSObject alloc] init];
        //类对象 Class指针指向类对象
        //一个类的类对象在内存中是唯一的
        Class objectClass = [object1 class];
        Class objectClass1 = [NSObject class];
        
        //实例对象内存中存的自己的成员变量
        //类对象存储只有一份的东西：
        //isa指针 superclass指针 类的属性@property 类的对象方法instance method
        //类的协议信息protocol 类的成员描述信息ivar
        
        //元类对象
        Class objectMetaClass = object_getClass([NSObject class]);
        
        //类方法放在元类中，对象方法放在类对象中，实例变量存储自己成员变量的数据值
    }
    return 0;
}

