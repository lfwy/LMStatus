//
//  LMTabBarController.m
//  李明微博
//
//  Created by tarena on 16/1/6.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMTabBarController.h"
#import "UIImage+Image.h"
#import "LMTabBar.h"
#import "LMNavigationController.h"

#import "LMHomeTableViewController.h"
#import "LMMessageTableViewController.h"
#import "LMDiscoverTableViewController.h"
#import "LMProfileTableViewController.h"
#import "LMComposeViewController.h"

#import "LMUserTool.h"
#import "LMUserResult.h"

@interface LMTabBarController ()<LMTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic,strong) LMHomeTableViewController *home;
@property (nonatomic,strong) LMMessageTableViewController *message;
@property (nonatomic,strong) LMDiscoverTableViewController *discover;
@property (nonatomic,strong) LMProfileTableViewController *profile;


@end

@implementation LMTabBarController

- (NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

//什么时候调用：程序一启动的时候就会把所有的类加载进内存
//作用：加载类的时候调用
//+ (void)load {
//    
//}
//当一次使用这个类或者子类时调用
//作用：初始化类
//appearance只要一个类遵守UIAppearance，就能获取全局外观
+ (void)initialize {
    //获取所有的tabBarItem外观标识
    //UITabBarItem *item = [UITabBarItem appearance];
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    //设置富文本
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:attributes forState:UIControlStateSelected];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //UIViewController的view是懒加载的，只有要显示了才会调用该方法，其他控制器一创建就会加载view
//    NSLog(@"%s",__func__);
    
    //添加子控制器
    [self setUpAllChildViewController];
    
    //自定义tabBar
    [self setUpTabBar];
    //每隔一段时间请求未读数
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(resuestUnreadCount) userInfo:nil repeats:YES];

}

- (void)setUpTabBar {
    //修改系统tabBar上面的按钮位置
    LMTabBar *tabBar = [[LMTabBar alloc]initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    //设置代理
    tabBar.delegate = self;
    
    //给tabBar传递tabBarItem模型
    tabBar.items = self.items;
    
    [self.tabBar addSubview:tabBar];
}

#pragma mark - 当点击tabBar上的按钮调用
- (void)tabBar:(LMTabBar *)tabBar didClickButton:(NSInteger)index
{
    if (index == 0 && self.selectedIndex == index) {//点击首页刷新
        [_home refresh];
    }
    self.selectedIndex = index;
}
//点击加号按钮调用
- (void)tabBarDidClickPlusButton:(LMTabBar *)tabBar {
    //创建控制器
    LMComposeViewController *composeViewController = [[LMComposeViewController alloc]init];
    LMNavigationController *navi = [[LMNavigationController alloc]initWithRootViewController:composeViewController];
    
    //突出控制器
    [self presentViewController:navi animated:YES completion:nil];
}

//在此处移除系统tabBar，有bug
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    //移除系统tabBar
//    for (UIView *tabBarButton in self.tabBar.subviews) {
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            [tabBarButton removeFromSuperview];
//        }
//    }
//}
//可在此处移除系统自带tabBarButton，也可在navigationController的willShow协议方法中移除
//- (void)viewWillLayoutSubviews {
//    //移除系统tabBar
//    for (UIView *tabBarButton in self.tabBar.subviews) {
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            [tabBarButton removeFromSuperview];
//        }
//    }
//}

//Item：就是苹果的模型，继承于NSObject。命名规范
//tabBarItem决定着tabBars上按钮的内容
//如果通过模型设置空间的文字颜色，只能通过文本属性（富文本：颜色、字体、空心、阴影、图文混排）

//在ios7之后，默认会把UITabBar上的按钮图片渲染成蓝色
#pragma mark - 添加所有的子控制器
- (void)setUpAllChildViewController {
    //主页
    LMHomeTableViewController *home = [[LMHomeTableViewController alloc]init];
    [self setUpOneChileViewController:home image:[UIImage imageWithOriginalName:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] andTitle:@"首页"];
    _home = home;
    //消息
    LMMessageTableViewController *message = [[LMMessageTableViewController alloc]init];
    [self setUpOneChileViewController:message image:[UIImage imageWithOriginalName:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] andTitle:@"消息"];
    _message = message;
    //发现
    LMDiscoverTableViewController *discover = [[LMDiscoverTableViewController alloc]init];
    [self setUpOneChileViewController:discover image:[UIImage imageWithOriginalName:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] andTitle:@"发现"];
    _discover = discover;
    //我
    LMProfileTableViewController *profile = [[LMProfileTableViewController alloc]init];
    [self setUpOneChileViewController:profile image:[UIImage imageWithOriginalName:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] andTitle:@"我"];
    _profile = profile;
}

#pragma mark - 添加一个子控制器
- (void)setUpOneChileViewController:(UIViewController *)viewController image:(UIImage *)image selectedImage:(UIImage *)selectedImage andTitle:(NSString *)title{
    //导航栏的title由栈顶控制器的title决定
    //tabBar的title由当前控制器title决定
    viewController.title = title;
    viewController.tabBarItem.image = image;
    viewController.tabBarItem.selectedImage = selectedImage;
    //设置badgeView
    //viewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"10"];
    //将tabBarItem添加到数组中
    [self.items addObject:viewController.tabBarItem];
    
    LMNavigationController *nav = [[LMNavigationController alloc]initWithRootViewController:viewController];

    [self addChildViewController:nav];
}

#pragma mark - 定时器请求数据
- (void)resuestUnreadCount {
    
    //请求微博的未读数(后台请求)
    
    //请求微博的未读数(前台请求)
    [LMUserTool unreadWithSuccess:^(LMUserResult *result) {
        //设置首页的未读数
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        //设置消息的未读数
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        //设置我的未读数
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        //设置app未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
    } failure:^(NSError *error) {
        
    }];
}

@end
