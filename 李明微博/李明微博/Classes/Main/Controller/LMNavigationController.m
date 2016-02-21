//
//  LMNavigationController.m
//  李明微博
//
//  Created by tarena on 16/1/9.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMNavigationController.h"
#import "UIBarButtonItem+Item.h"
#import "LMTabBarController.h"

@interface LMNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) id popDelegate;

@end

@implementation LMNavigationController

+ (void)initialize {
    //获取当前类下的barButtonItem对象（外观）
    UIBarButtonItem *btnItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    //设置backButtonItem的title隐藏
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [btnItem setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    //设置不可用状态下的文字颜色
    //注意导航条上按钮不可用，不能用文字属性设置
//    titleAttr = [NSMutableDictionary dictionary];
//    titleAttr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    [btnItem setTitleTextAttributes:titleAttr forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //将返回的viewController保存下来
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //设置非根控制器导航条的内容
    if (self.viewControllers.count != 0) {//根控制器
        //设置导航的内容
        //如果设置了导航条的左边按钮，则系统提供的滑动返回功能就没有了
        //左边
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
        //右边
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more" ] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];
    }
    [super pushViewController:viewController animated:animated];
    
}

//导航控制器跳转完成时调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController == self.viewControllers[0]) {//是根控制器
        //还原滑动返回手势的代理
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }else {//不是根控制器
        //实现滑动返回功能
        //清空滑动返回手势的代理，就能实现滑动返回
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}
//在导航控制器即将显示时，移除系统tabBar
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //LMKeyWindow是pch文件中的宏定义
    UITabBarController *tabBarController = (UITabBarController *)LMKeyWindow.rootViewController;
    for (UIView *tabBarButton in tabBarController.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
}

- (void)backToPre {
    [self popViewControllerAnimated:YES];
}

- (void)backToRoot {
    [self popToRootViewControllerAnimated:YES];
}

@end
