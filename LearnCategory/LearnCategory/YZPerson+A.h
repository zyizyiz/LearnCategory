//
//  YZPerson+A.h
//  LearnCategory
//
//  Created by ios on 2019/1/8.
//  Copyright © 2019年 KN. All rights reserved.
//

#import "YZPerson.h"

@interface YZPerson (A)

// 是否是学生
@property(nonatomic,assign,setter=setStudentState:)Boolean isStudent;

-(void)print;

@end
