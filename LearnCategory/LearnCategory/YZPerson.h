//
//  YZPerson.h
//  LearnCategory
//
//  Created by ios on 2019/1/8.
//  Copyright © 2019年 KN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZPerson : NSObject

// 名字
@property(nonatomic,copy)NSString *name;

// 年龄
@property(nonatomic,copy)NSString *age;

// 打印
-(void)print;

@end
