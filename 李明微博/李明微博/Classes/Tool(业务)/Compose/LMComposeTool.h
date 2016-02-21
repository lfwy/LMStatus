//
//  LMComposeTool.h
//  李明微博
//
//  Created by tarena on 16/1/17.
//  Copyright © 2016年 lim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMComposeTool : UIView

+ (void)composeWithStatus:(NSString *)status success:(void(^)())success failure:(void(^)(NSError *error))failure;

+ (void)composeWithImage:(UIImage *)image status:(NSString *)status success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
