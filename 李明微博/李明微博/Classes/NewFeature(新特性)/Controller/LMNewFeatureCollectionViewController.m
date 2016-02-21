//
//  LMNewFeatureCollectionViewController.m
//  李明微博
//
//  Created by tarena on 16/1/12.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMNewFeatureCollectionViewController.h"
#import "LMNewFeatureCollectionViewCell.h"

@interface LMNewFeatureCollectionViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIPageControl *pageControl;

@end

@implementation LMNewFeatureCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
//重写init方法，使其调用initWithCollectionViewLayout方法
- (instancetype)init {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置cell的尺寸
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    //清空行距
    flowLayout.minimumLineSpacing = 0;
    //设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [super initWithCollectionViewLayout:flowLayout];
}
//使用UICollectionViewController
//1.必须初始化时设置布局
//2.必须collectionView要注册cell
//3.自定义cell
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.collectionView != self.view;
    //self.collectionView是self.view的子控件
    self.collectionView.backgroundColor = [UIColor redColor];
    //注册重用cell,默认创建该类型对象
    [self.collectionView registerClass:[LMNewFeatureCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //分页
    self.collectionView.pagingEnabled = YES;
    //没有弹性
    self.collectionView.bounces = NO;
    //隐藏滑动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //添加pageControl
    [self setUpPageControl];

}

//添加pageControl
- (void)setUpPageControl {
    UIPageControl *pageContol = [[UIPageControl alloc]init];
    pageContol.numberOfPages = 4;
    pageContol.pageIndicatorTintColor = [UIColor blackColor];
    pageContol.currentPageIndicatorTintColor = [UIColor redColor];
    pageContol.currentPage = 0;
    pageContol.center = CGPointMake(self.view.width / 2 , self.view.height/8*7);
    self.pageControl = pageContol;
    [self.view addSubview:pageContol];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / self.view.width + 0.5;
    _pageControl.currentPage = page;
}

#pragma mark <UICollectionViewDataSource>
//返回有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//返回第section组有多少cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
//返回cell长什么样
- (LMNewFeatureCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //dequeue 重用cell队列
    //1.从缓存池中取cell
    //2.看下当前是否有注册cell，如果注册了cell，就帮你创建cell
    //3.如果没有注册，报错
    LMNewFeatureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //给cell传值
    cell.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%ld",indexPath.row+1]];
    
    [cell setIndexPath:indexPath andCount:4];
    
    return cell;
}

@end
