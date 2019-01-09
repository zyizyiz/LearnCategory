//
//  main.m
//  LearnCategory
//
//  Created by ios on 2019/1/8.
//  Copyright © 2019年 KN. All rights reserved.
//

/*
 如果多个分类中都有和原有类中同名的方法, 那么调用该方法的时候执行谁由编译器决定；编译器会执行最后一个参与编译的分类中的方法。
 调整编译文件的顺序 ： Build Phases -> Compile Sources
 
 Load方法: 在runtime加载类、分类时调用，无论有没有被引用、被加载和使用，而且每个类的Load只运行一次
          为Class 直接调用（可看runtime源码），先编译类，再分类。因此调用顺序为：class -> category
          并且分类按照编译的先后顺序执行
 initialize方法: 在类第一次接收到消息时调用。
                方法调用为objc_msgSend()（可看runtime源码）,因此只调用优先级高的方法，并只调用一次
                子类会优先调用父类的initialize方法，然后在调用自身的initialize方法 (父类initialize -> 子类initialize)
                如果子类未实现initialize方法，则会调用父类的initialize方法（父类的initialize会调用多次）(父类initialize)
 */

#import <Foundation/Foundation.h>
#import "YZPerson.h"
#import "YZStudent.h"
#import <objc/runtime.h>

void printClassMethod(Class cls) {
    unsigned int outCount = 0;
    Method *methods = class_copyMethodList(cls, &outCount);
    NSString *className = NSStringFromClass(cls);
    NSMutableString *methodNameList = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%@ -> ",className]];
    for (int i = 0; i < outCount; i++) {
        Method method = methods[i];
        NSString *methodName =  NSStringFromSelector(method_getName(method));
        [methodNameList appendString:methodName];
        [methodNameList appendString:@" "];
    }
    NSLog(@"%@",methodNameList);
    free(methods);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        [YZPerson alloc];
        [YZStudent alloc];
        
        
        YZPerson *man = [[YZPerson alloc]init];
        [man print];
        // YZPerson -> print print print .cxx_destruct name setName: print age setAge:
        printClassMethod([YZPerson class]);
        // YZStudent ->
        printClassMethod([YZStudent class]);
        
        // object_getClass跟随实例的isa指针，返回此实例所属的类。
        // 对于实例对象(instance)返回的是类(class),对于类(class)则返回的是元类(metaclass)
        // man : 实例对象  ->  class : 类  ->  metaClass : 元类
        Class class = object_getClass(man);
        // YZPerson -> print print print .cxx_destruct name setName: print age setAge:
        printClassMethod(class);
        
        // YZStudent -> initialize
        //        Class metaClass = object_getClass([YZStudent class]);
        Class metaClass = objc_getMetaClass("YZPerson");
        // YZPerson -> initialize load initialize load initialize load initialize load
        printClassMethod([metaClass class]);
        // isMetaClass 1
        NSLog(@"isMetaClass %i",class_isMetaClass(metaClass));
    }
    return 0;
}
