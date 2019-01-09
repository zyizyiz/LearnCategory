//
//  YZPerson+Custom2.m
//  LearnCategory
//
//  Created by ios on 2019/1/8.
//  Copyright © 2019年 KN. All rights reserved.
//

#import "YZPerson+Custom2.h"

@implementation YZPerson (Custom2)

+(void)load {
    NSLog(@"load YZPerson (Custom2)");
}

+(void)initialize {
    NSLog(@"initialize YZPerson (Custom2)");
}

-(void)print {
    NSLog(@"my name is YZCustom2,age is 200");
}
@end
