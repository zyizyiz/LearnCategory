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
 */

#import <Foundation/Foundation.h>
#import "YZPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        YZPerson *person = [[YZPerson alloc]init];
        [person print];
    }
    return 0;
}
