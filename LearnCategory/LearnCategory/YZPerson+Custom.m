//
//  YZPerson+Custom.m
//  LearnCategory
//
//  Created by ios on 2019/1/8.
//  Copyright © 2019年 KN. All rights reserved.
//

#import "YZPerson+Custom.h"

@implementation YZPerson (Custom)

+(void)load {
    NSLog(@"load YZPerson (Custom)");
}

+(void)initialize {
    NSLog(@"initialize YZPerson (Custom)");
}

- (void)print {
    NSLog(@"my name is YZCustom,age is 100");
}

- (void)printCustom {
    NSLog(@"my name is YZCustom,age is 100");
}

@end
