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
          为Class 直接调用（可看runtime源码），先编译类，再分类。
          ******因此调用顺序为：class -> category , 父类的load调用在子类前
          并且分类按照编译的先后顺序执行
 initialize方法: 在类第一次接收到消息时调用。
                方法调用为objc_msgSend()（可看runtime源码）,因此只调用优先级高的方法，并只调用一次
                ******子类会优先调用父类的initialize方法，然后在调用自身的initialize方法
                        (父类initialize -> 子类initialize)
                ******如果子类未实现initialize方法，则会调用父类的initialize方法（父类的initialize会调用多次）
                        (父类initialize)
 用途： 1.在开发中我们使用数据库操作的时候，会缓存大量的数据，当用户刚开始打开App的时候，如果进行处理，那么就会产生开始使用的时候，出现卡顿几秒钟，这是在加载数据，但是这些数据我们开启App不能全部用到，因此我们将数据库的相关操作，写在initialize中，这样当用到的时候才进行数据的缓存，会提升整个App的性能。
       2.由于调用load方法时的环境很不安全，我们应该尽量减少load方法的逻辑。另一个原因是load方法是线程安全的，它内部使用了锁，所以我们应该避免线程阻塞在load方法中.load很常见的一个使用场景,交换两个方法的实现
       3.initialize方法主要用来对一些不方便在编译期初始化的对象进行赋值。比如NSMutableArray这种类型的实例化依赖于runtime的消息发送，所以显然无法在编译器初始化，所以在initialize中执行
       4.往往在一个应用APP中,导航条控制器的导航条几乎是统一的.再加上,一般情况一个应用APP会重写一个导航控制器类.那么initialize类方法就能出场了
             (void)initialize {
 
                NSLog(@”%s:%s”,FILE,func);
                //设置导航栏主题
 
                UINavigationBar *navBar = [UINavigationBar appearance];
                //接下来就可以对navBar坐各种统一的设置处理了.比如字体,背景….
             }
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
        NSLog(@"------------------------------");
        // YZPerson -> print print print .cxx_destruct name setName: print age setAge:
        printClassMethod([YZPerson class]);
        printClassMethod([man class]);
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
