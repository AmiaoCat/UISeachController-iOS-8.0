//
//  SearchList.h
//  检索
//
//  Created by Ss on 15/5/14.
//  Copyright (c) 2015年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchList : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phoneNumber;
@property (nonatomic,copy) NSString *gender;

- (instancetype)initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber gender:(NSString*)gender;

+ (instancetype)studentWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber gender:(NSString*)gender;


@end
