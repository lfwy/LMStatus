//
//  LMUserResult.m
//  李明微博
//
//  Created by tarena on 16/1/14.
//  Copyright © 2016年 lim. All rights reserved.
// 

#import "LMUserResult.h"

@implementation LMUserResult

- (int)messageCount {
    return _cmt+_dm+_mention_cmt+_mention_status;
}

- (int)totalCount {
    return self.messageCount + _status + _follower;
}

@end
