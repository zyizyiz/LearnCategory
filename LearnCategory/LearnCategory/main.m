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
 
 Load方法: 只要类被编译就会被运行，无论有没有被引用、被加载和使用，而且每个类的Load只运行一次
          为Class 直接调用（可看runtime源码）
 initialize方法: 当类被创建时运行。
          方法调用为objc_msgSend()（可看runtime源码）,因此只调用优先级高的方法，并只调用一次
          子类会优先调用父类的initialize方法，然后在调用自身的initialize方法
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
        // YZStudent -> initialize
        Class metaClass = object_getClass([YZStudent class]);
        printClassMethod([metaClass class]);
        
    }
    return 0;
}
