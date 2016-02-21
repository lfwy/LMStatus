//
//  LMStatusResult.m
//  李明微博
//
//  Created by tarena on 16/1/14.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMStatusResult.h"
#import "LMStatus.h"

@implementation LMStatusResult

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"statuses":[LMStatus class]};
}

@end
