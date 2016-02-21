//
//  LMAccountTool.h
//  李明微博
//
//  Created by tarena on 16/1/13.
//  Copyright © 2016年 lim. All rights reserved.
//  专门处理账号的业务（账号的存储）

#import <Foundation/Foundation.h>
#import "LMAccount.h"

@interface LMAccountTool : NSObject

+ (void) saveAccount:(LMAccount *)account;

+ (LMAccount *) account;
//换取accessToken
+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
