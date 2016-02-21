//
//  main.m
//  李明微博
//
//  Created by tarena on 16/1/6.
//  Copyright © 2016年 lim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//1.创建UIApplication对象
//2.创建AppDelegate对象，并且成为UIApplication对象代理属性
//3.开启主运行循环：目的让程序一直跑起来
//4.加载info.plist文件，判断info.plist文件里有没有制定main。storyboard，如果制定，就取加载main.storyboard

//main.storyboard
//1.初始化窗口
//2.加载storyboard文件,并且创建箭头指向的控制器
//3.把新创建的控制器作为窗口的根控制器，让窗口显示
int main(int argc, char * argv[]) {
    @autoreleasepool {
        
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"main" bundle:nil];
//        //instantiateInitialViewController:默认加载箭头指向的控制器
//        [storyboard instantiateInitialViewController];
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
