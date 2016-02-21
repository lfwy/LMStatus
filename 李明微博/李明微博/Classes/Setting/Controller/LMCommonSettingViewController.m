//
//  LMCommonSettingViewController.m
//  李明微博
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMCommonSettingViewController.h"
#import "LMBaseSetting.h"
#import "LMFontSizeViewController.h"
#import "LMFontSizeTool.h"

#define LMFontSizeNote @"fontSizeNote"

@interface LMCommonSettingViewController ()

@property (nonatomic,weak) LMSettingItem *font;

@end

@implementation LMCommonSettingViewController

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
    //添加group4
    [self setUpGroup4];
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFontSize) name:LMFontSizeNote object:nil];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//只要点击字体界面的模型，就会调用
- (void)changeFontSize {
    
    //修改模型
    _font.subTitle = [LMFontSizeTool fontSize];
    //更新界面
    [self.tableView reloadData];
}

- (void)setUpGroup0 {
    
    //阅读模式
    LMSettingItem *reading = [LMSettingItem itemWithTitle:@"阅读模式" subTitle:@"有图模式" image:nil];
    //字体大小
    LMSettingItem *font = [LMSettingItem itemWithTitle:@"字体大小"];
    _font = font;
    NSString *fontSizeStr = [LMFontSizeTool fontSize];
    if (fontSizeStr) {
        font.subTitle = fontSizeStr;
    }else {
        //设置字体小
        font.subTitle = @"小";
        [LMFontSizeTool saveFontSize:@"小"];
    }
    font.destVCClass = [LMFontSizeViewController class];
    //显示备注
    LMSwitchItem *display = [LMSwitchItem itemWithTitle:@"显示备注"];
    LMGroupItem *group = [[LMGroupItem alloc]init];
    group.items = @[reading,font,display];
    //添加到groups数组中
    [self.groups addObject:group];
}

- (void)setUpGroup1 {

    //图片质量
    LMArrowItem *image = [LMArrowItem itemWithTitle:@"图片质量"];
    LMGroupItem *group = [[LMGroupItem alloc]init];
    group.items = @[image];
    //添加到groups数组中
    [self.groups addObject:group];
}

- (void)setUpGroup2 {
    
    //声音
    LMSwitchItem *voice = [LMSwitchItem itemWithTitle:@"声音"];
    LMGroupItem *group = [[LMGroupItem alloc]init];
    group.items = @[voice];
    //添加到groups数组中
    [self.groups addObject:group];
}

- (void)setUpGroup3 {
    
    //多语言环境
    LMSettingItem *language = [LMSettingItem itemWithTitle:@"多语言环境" subTitle:@"跟随系统" image:nil];
    LMGroupItem *group = [[LMGroupItem alloc]init];
    group.items = @[language];
    //添加到groups数组中
    [self.groups addObject:group];
}

- (void)setUpGroup4 {
    
    //清除图片缓存
    LMArrowItem *cache = [LMArrowItem itemWithTitle:@"清除图片缓存" subTitle:@"0KB" image:nil];
    LMGroupItem *group = [[LMGroupItem alloc]init];
    group.items = @[cache];
    //添加到groups数组中
    [self.groups addObject:group];
}

- (void)setUpNavigation {
    self.navigationItem.title = @"通用设置";
}

@end
