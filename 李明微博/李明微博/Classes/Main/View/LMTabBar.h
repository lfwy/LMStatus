//
//  LMTabBar.h
//  李明微博
//
//  Created by tarena on 16/1/7.
//  Copyright © 2016年 lim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LMTabBar;

@protocol LMTabBarDelegate <NSObject>

@optional
/**
 *  tabBar切换控制器
 *
 *  @param tabBar 自定义的tabBar
 *  @param index  点击tabBarButton的索引
 */
- (void)tabBar:(LMTabBar *)tabBar didClickButton:(NSInteger)index;
/**
 *  点击加号按钮时调用
 *
 *  @param tabBar 自定义tabBar
 */
- (void)tabBarDidClickPlusButton:(LMTabBar *)tabBar;

@end

@interface LMTabBar : UIView
// items:保存每一个按钮对应tabBarItem模型
@property(nonatomic,strong)NSArray *items;

@property(nonatomic,strong)id<LMTabBarDelegate> delegate;

@end
