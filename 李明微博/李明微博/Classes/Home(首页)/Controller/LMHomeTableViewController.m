//
//  LMHomeTableViewController.m
//  李明微博
//
//  Created by tarena on 16/1/9.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMHomeTableViewController.h"
#import "UIBarButtonItem+Item.h"
#import "LMOneViewController.h"
#import "AFNetworking.h"
#import "LMAccountTool.h"
#import "LMStatus.h"
#import "LMUser.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "LMHttpTool.h"
#import "LMStatusTool.h"
#import "LMUserTool.h"
#import "LMAccount.h"
#import "LMStatusCell.h"
#import "LMStatusFrame.h"

@interface LMHomeTableViewController ()
/**
 *  ViewModel:LMStatusFrame
 */
@property (nonatomic,strong) NSMutableArray *statusFrames;

@end

@implementation LMHomeTableViewController

- (NSMutableArray *)statusFrames {
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置导航条内容
    [self setUpNavigarionBar];
    
    //请求最新的微博数据 可以直接自动下拉刷新
    //[self loadNewStatus];
    //下拉刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    //自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
    //上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    
    //一开始展示之前的微博名称，然后再发送用户信息请求，直接赋值
    self.navigationItem.title = [LMAccountTool account].name;
    
    //请求用户昵称
    [LMUserTool userInfoWithSuccess:^(LMUser *user) {
        //请求成功
        //设置导航条的
        self.navigationItem.title = user.name;
        
        //获取用户模型
        LMAccount *account = [LMAccountTool account];
        account.name = user.name;
        
        //保存用户的名称
        [LMAccountTool saveAccount:account];
        
    } failure:^(NSError *error) {
        //请求失败
    }];
    
}
//{:json字典 [:json数组

#pragma mark - 展示最新的微博数据
- (void)loadNewStatus {
    
    NSString *sinceId = nil;
    if (self.statusFrames.count) {//有微博数据才需要下拉刷新
        LMStatusFrame *firstStatusFrame = self.statusFrames[0] ;
        sinceId = firstStatusFrame.status.idstr;
    }
    //请求更新的微博数据 由业务类LMStatusTool完成
    [LMStatusTool newStatusWithSinceId:sinceId success:^(NSArray *statues) {
        //请求成功的Block
        
        //展示最新的微博数
        [self showNewStatus:statues.count];
        
        //结束下拉刷新
        [self.tableView headerEndRefreshing];
        
        //把模型转换成视图模型 LMStatus -> LMStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (LMStatus *status in statues) {
            LMStatusFrame *statusFrame = [LMStatusFrame new];
            statusFrame.status = status;
            [statusFrames addObject:statusFrame];
        }
        //将请求到的数据插入到数组下标 0至请求数据长度 之间
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statues.count)];
        //把最新的微博数插入到最前面
        [self.statusFrames insertObjects:statusFrames atIndexes:indexSet];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 展示最新的微博数
- (void)showNewStatus:(NSUInteger)count {
    if (count == 0) return;
    CGFloat h = 35;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame)-h;
    CGFloat x = 0;
    CGFloat w = self.view.width;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.text = [NSString stringWithFormat:@"获得%lu条新微博",(unsigned long)count];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    //插入导航控制器下导航条下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    //动画往下面平移
    [UIView animateWithDuration:0.25 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        //还原往上面平移
        [UIView animateWithDuration:0.25 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

#pragma mark - 展示更多的微博
- (void)loadMoreStatus {
    static NSString *maxId = nil;
    if (self.statusFrames.count) {//有微博数据才需要上拉刷新
        LMStatusFrame *lastStatusFrame = [self.statusFrames lastObject];
        maxId = [NSString stringWithFormat:@"%lld",[lastStatusFrame.status.idstr longLongValue] - 1];
    }
    //请求更多的微博数据 由业务类LMStatusTool完成
    [LMStatusTool moreStatusWithMaxId:maxId success:^(NSArray *statuses) {
        //请求成功
        //结束上拉刷新
        [self.tableView footerEndRefreshing];
        //把模型转为视图模型
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (LMStatus *status in statuses) {
            LMStatusFrame *statusFrame = [LMStatusFrame new];
            statusFrame.status = status;
            [statusFrames addObject:statusFrame];
        }
        //把最新的微博数插入到最后面
        [self.statusFrames addObjectsFromArray:statusFrames];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

- (void)setUpNavigarionBar {
    //设置左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendSearch) forControlEvents:UIControlEventTouchUpInside];
    //设置右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
}

- (void)friendSearch {
}

- (void)pop {
    //跳转到另外一个控制器
    LMOneViewController *oneViewController = [[LMOneViewController alloc]init];
    //当push时就会隐藏底部条
    //前提条件：只能隐藏系统自带的tabBar
    oneViewController.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:oneViewController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //创建cell
    LMStatusCell *cell = [LMStatusCell cellWithTableView:self.tableView];
    
    //获取statusFrame模型
    LMStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    
    //给cell传递模型
    cell.statusFrame = statusFrame;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取statusFrame模型
    LMStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}

#pragma mark - 刷新最新的微博
- (void)refresh {
    //自动下拉刷新
    [self.tableView headerBeginRefreshing];
}

@end
