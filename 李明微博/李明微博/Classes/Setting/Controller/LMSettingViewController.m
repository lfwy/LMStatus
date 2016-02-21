//
//  LMSettingViewController.m
//  李明微博
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMSettingViewController.h"
#import "LMBaseSetting.h"
#import "LMCommonSettingViewController.h"


@interface LMSettingViewController ()

@end

@implementation LMSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setUpNavigation];
    
    //添加group0
    [self setUpGroup0];
    //添加group1
    [self setUpGroup1];
    //添加group2
    [self setUpGroup2];
    //添加group3
    [self setUpGroup3];
    
}

- (void)setUpGroup0 {
    
    //账号管理
    LMBadgeItem *account = [LMBadgeItem itemWithTitle:@"账号管理"];
    account.badgeValue = [NSString stringWithFormat:@"%d",10];
    LMGroupItem *group = [[LMGroupItem alloc]init];
    group.items = @[account];
    //添加到groups数组中
    [self.groups addObject:group];
}

- (void)setUpGroup1 {
    
    //我的相册
    LMArrowItem *album = [LMArrowItem itemWithTitle:@"我的相册"];
    //通用设置
    LMArrowItem *gernal = [LMArrowItem itemWithTitle:@"通用设置"];
    //设置跳转控制器类名
    gernal.destVCClass = [LMCommonSettingViewController class];
    //隐私与安全
    LMArrowItem *safety = [LMArrowItem itemWithTitle:@"隐私与安全"];
    LMGroupItem *group = [[LMGroupItem alloc]init];
    group.items = @[album,gernal,safety];
    //添加到groups数组中
    [self.groups addObject:group];
}

- (void)setUpGroup2 {
    
    //意见反馈
    LMArrowItem *feedback = [LMArrowItem itemWithTitle:@"意见反馈"];
    //关于微博
    LMArrowItem *about = [LMArrowItem itemWithTitle:@"关于微博"];
    LMGroupItem *group = [[LMGroupItem alloc]init];
    group.items = @[feedback,about];
    //添加到groups数组中
    [self.groups addObject:group];
}

- (void)setUpGroup3 {
    
    //退出当前账号
    LMLabelItem *quit = [[LMLabelItem alloc]init];
    quit.text = @"退出当前账号";
    LMGroupItem *group = [[LMGroupItem alloc]init];
    group.items = @[quit];
    //添加到groups数组中
    [self.groups addObject:group];
}

- (void)setUpNavigation {
    self.navigationItem.title = @"设置";
}


@end
