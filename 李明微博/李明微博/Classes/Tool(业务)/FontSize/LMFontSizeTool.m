//
//  LMFontSizeTool.m
//  李明微博
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMFontSizeTool.h"

#define LMUserDefaults [NSUserDefaults standardUserDefaults]
#define LMFontSizeKey @"fontSize"
@implementation LMFontSizeTool

+ (void)saveFontSize:(NSString *)fontSize {
    [LMUserDefaults setObject:fontSize forKey:LMFontSizeKey];
    [LMUserDefaults synchronize];
}

+ (NSString *)fontSize {
    return [LMUserDefaults objectForKey:LMFontSizeKey];
}

@end
