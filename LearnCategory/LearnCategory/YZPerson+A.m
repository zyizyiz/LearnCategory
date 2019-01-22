//
//  YZPerson+A.m
//  LearnCategory
//
//  Created by ios on 2019/1/8.
//  Copyright © 2019年 KN. All rights reserved.
//

#import "YZPerson+A.h"
#import <objc/runtime.h>

@implementation YZPerson (A)

+(void)load {
    NSLog(@"load YZPerson (A)");
}

+(void)initialize {
    NSLog(@"initialize YZPerson (A)");
}

-(void)print {
    NSLog(@"my name is A , age is 0");
}

- (void)setStudentState:(Boolean)isStudent {
    objc_setAssociatedObject(self, _cmd, [NSNumber numberWithBool:isStudent], OBJC_ASSOCIATION_ASSIGN);
}

- (Boolean)isStudent
{
    return (Boolean)objc_getAssociatedObject(self, @"setStudentState");
}

@end
