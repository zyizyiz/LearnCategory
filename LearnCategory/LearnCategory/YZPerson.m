//
//  YZPerson.m
//  LearnCategory
//
//  Created by ios on 2019/1/8.
//  Copyright © 2019年 KN. All rights reserved.
//

#import "YZPerson.h"

@implementation YZPerson

+(void)load {
    NSLog(@"load YZPerson");
}

+(void)initialize {
    NSLog(@"initialize YZPerson");
}

-(void)print {
    NSLog(@"my name is %@,age is %@",_name,_age);
}
@end
