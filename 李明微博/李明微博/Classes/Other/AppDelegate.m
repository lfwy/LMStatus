//
//  AppDelegate.m
//  李明微博
//
//  Created by tarena on 16/1/6.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "AppDelegate.h"
#import "LMOAuthViewController.h"
#import "LMAccountTool.h"
#import "LMRootViewControllerTool.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>

//偏好设置存储的好处
//1.不需要关心文件名，系统管理
//2.快速进行键值对的存储

//封装思想：如果以后项目中有相同的功能，抽取一个类，封装好
//如何封装：自己的事情交给自己管理
//抽方法：一般一个功能就抽一个方法
/*
    LaunchScreen:代替之前的启动图片
    程序中碰见模拟器尺寸不对，马上去找启动图片，默认模拟器的尺寸由启动图片决定
    好处：
    1.可以展示更多的东西
    2.可以只需要出一个大尺寸的图片
    
    启动图片的优先级 < LaunchScreen.xib的优先级
 */
@interface AppDelegate ()

@property (nonatomic,strong) AVAudioPlayer *player;

@end

@implementation AppDelegate
//补充：控制器的view

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //注册通知
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil]];
    
    //创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //判断有没有授权
    if ([LMAccountTool account]) {
        //选择根控制器
        [LMRootViewControllerTool chooseRootViewController:self.window];
    }else {
        //进行授权
        LMOAuthViewController *oauthViewController = [[LMOAuthViewController alloc]init];
        //设置窗口的根控制器
        self.window.rootViewController = oauthViewController;
    }

    //显示窗口
    [self.window makeKeyAndVisible];
    
    //makeKeyAndVisible底层实现
    //1.application.keyWindow = self.window;
    //2.self.window.hidden = NO;
    
    return YES;
}
//接收到内存警告时调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    //停止所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    //删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}
//即将失去焦点的时候播放音乐，0KB的音乐
- (void)applicationWillResignActive:(UIApplication *)application {
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"silence" withExtension:@"mp3"];
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    //无限循环播放
    player.numberOfLoops = -1;
    [player play];
    _player = player;
}
//程序进入后台时调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    //开启后台任务(时间不确定，优先级低，如果系统关闭应用，首先关闭此应用)
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        //当后台任务结束时调用
        [application endBackgroundTask:ID];
    }];
    //如何提高后台任务优先级 欺骗苹果此应用为后台播放程序
    //target中修改Capbilities中修改backgroundMode
    //但是苹果会检测你的程序当时有没有播放音乐,如果没有,会被关闭
    //微博:在程序即将失去焦点时播放静音音乐
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
