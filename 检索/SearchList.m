//
//  SearchList.m
//  检索
//
//  Created by Ss on 15/5/14.
//  Copyright (c) 2015年 Kevin. All rights reserved.
//

#import "SearchList.h"

@implementation SearchList



- (instancetype)initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber gender:(NSString *)gender
{
    if (self=[super init]) {
        self.name = name;
        self.phoneNumber = phoneNumber;
        self.gender = gender;
    }
    return self;
}


+ (instancetype)studentWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber gender:(NSString *)gender
{
    return [[SearchList alloc]initWithName:name phoneNumber:phoneNumber gender:gender];
}
@end
