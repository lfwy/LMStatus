//
//  LMRootViewControllerTool.m
//  李明微博
//
//  Created by tarena on 16/1/13.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMRootViewControllerTool.h"
#import "LMTabBarController.h"
#import "LMNewFeatureCollectionViewController.h"


#define LMVersionKey @"version"

@implementation LMRootViewControllerTool

//选择根控制器
+ (void)chooseRootViewController:(UIWindow *)keyWindow {
    //1.获取当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    //2.获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:LMVersionKey];
    
    //3.判断当前是否有新的版本
    if ([currentVersion isEqualToString:lastVersion]) {//没有更新版本
        //创建tabBarVC
        LMTabBarController *tabBarVC = [[LMTabBarController alloc]init];
        //设置窗口的根控制器
        keyWindow.rootViewController = tabBarVC;
    }else {//有更新版本
        //有新特性，进入新特性界面
        LMNewFeatureCollectionViewController *newFeatureViewController = [[LMNewFeatureCollectionViewController alloc] init];
        keyWindow.rootViewController = newFeatureViewController;
        //保存当前的版本，用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:LMVersionKey];
    }
}

@end
