//
//  YZPerson+A.m
//  LearnCategory
//
//  Created by ios on 2019/1/8.
//  Copyright © 2019年 KN. All rights reserved.
//

#import "YZPerson+A.h"

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
@end
