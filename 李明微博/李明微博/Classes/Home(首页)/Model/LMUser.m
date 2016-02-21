//
//  LMUser.m
//  李明微博
//
//  Created by tarena on 16/1/13.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMUser.h"

@implementation LMUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}

@end
