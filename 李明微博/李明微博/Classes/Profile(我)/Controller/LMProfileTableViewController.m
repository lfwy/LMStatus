//
//  LMProfileTableViewController.m
//  李明微博
//
//  Created by tarena on 16/1/9.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMProfileTableViewController.h"
#import "LMBaseSetting.h"
#import "LMProfileCell.h"
#import "LMSettingViewController.h"

@interface LMProfileTableViewController ()

@end

@implementation LMProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setUpNavigation];
    
    //添加group0
    [self setUpGroup0];
    //添加group0
    [self setUpGroup1];
    //添加group0
    [self setUpGroup2];
    //添加group0
    [self setUpGroup3];
    
}

- (void)setUpGroup0 {
    
    //新的好友
    LMArrowItem *friend = [LMArrowItem itemWithTitle:@"新的好友" image:[UIImage imageNamed:@"new_friend"]];
    LMGroupItem *group = [[LMGroupItem alloc]init];
    group.items = @[friend];
    //添加到groups数组中
    [self.groups addObject:group];
}

- (void)setUpGroup1 {
    
    //我的相册
    LMArrowItem *album = [LMArrowItem itemWithTitle:@"我的相册" subTitle:@"(12)" image:[UIImage imageNamed:@"album"]];
    //我的收藏
    LMArrowItem *collect = [LMArrowItem itemWithTitle:@"我的收藏" subTitle:@"(1)" image:[UIImage imageNamed:@"collect"]];
    //赞
    LMArrowItem *like = [LMArrowItem itemWithTitle:@"赞" subTitle:@"(3)" image:[UIImage imageNamed:@"like"]];
    LMGroupItem *group = [[LMGroupItem alloc]init];
    group.items = @[album,collect,like];
    //添加到groups数组中
    [self.groups addObject:group];
}

- (void)setUpGroup2 {
    
    //微博支付
    LMArrowItem *pay = [LMArrowItem itemWithTitle:@"微博支付" image:[UIImage imageNamed:@"pay"]];
    //个性化
    LMArrowItem *vip = [LMArrowItem itemWithTitle:@"个性化" subTitle:@"微博来源、皮肤、封面图" image:[UIImage imageNamed:@"vip"]];
    LMGroupItem *group = [[LMGroupItem alloc]init];
    group.items = @[pay,vip];
    //添加到groups数组中
    [self.groups addObject:group];
}

- (void)setUpGroup3 {
    
    //我的二维码
    LMArrowItem *card = [LMArrowItem itemWithTitle:@"我的二维码" image:[UIImage imageNamed:@"card"]];
    //个性化
    LMArrowItem *draft = [LMArrowItem itemWithTitle:@"个性化" image:[UIImage imageNamed:@"draft"]];
    LMGroupItem *group = [[LMGroupItem alloc]init];
    group.items = @[card,draft];
    //添加到groups数组中
    [self.groups addObject:group];
}

- (void)setting {
    LMSettingViewController *settingVC = [[LMSettingViewController alloc]init];
    
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)setUpNavigation {
    UIBarButtonItem *settting = [[UIBarButtonItem alloc] initWithTitle:@"设置"  style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItem = settting;
}

//返回每一行长什么样
//重写父类的方法 修改subTitle的位置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1.创建cell
    LMProfileCell *cell = [LMProfileCell cellWithTableView:self.tableView];
    //2.给cell传递模型
    LMGroupItem *group = self.groups[indexPath.section];
    LMSettingItem *item = group.items[indexPath.row];
    cell.item = item;
    
    return cell;
}

@end
