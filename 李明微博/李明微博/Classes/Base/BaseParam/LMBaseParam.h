//
//  LMBaseParam.h
//  李明微博
//
//  Created by tarena on 16/1/14.
//  Copyright © 2016年 lim. All rights reserved.
//  基本参数模型类

#import <Foundation/Foundation.h>

@interface LMBaseParam : NSObject
/**
 *  采用OAuth授权方式为必填参数,访问的命令牌
 */
@property (nonatomic,copy) NSString *access_token;

+ (instancetype)param;

@end
