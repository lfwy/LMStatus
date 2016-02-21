//
//  LMTabBar.m
//  李明微博
//
//  Created by tarena on 16/1/7.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMTabBar.h"
#import "LMTabBarButton.h"

@interface LMTabBar ()

@property(nonatomic,weak)UIButton *plusButton;
@property(nonatomic,strong)NSMutableArray *buttons;
@property(nonatomic,weak)UIButton *selectedButton;

@end

@implementation LMTabBar

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)setItems:(NSArray *)items {
    _items  = items;
    //遍历数组，取出tabBarButtonItem
    for (UITabBarItem *item in _items) {
        LMTabBarButton *button = [LMTabBarButton buttonWithType:UIButtonTypeCustom];
        button.item = item;
        
        button.tag = self.buttons.count;
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchDown];
        if (button.tag == 0) { // 默认选中第0个
            [self clickButton:button];
        }
        [self addSubview:button];
        // 把按钮添加到按钮数组
        [self.buttons addObject:button];
    }
}
//点击tabBarButton响应
- (void)clickButton:(UIButton *)button {
    //当前选中按钮设为未选中状态
    _selectedButton.selected = NO;
    //点击按钮设为选中状态
    button.selected = YES;
    //将点击按钮赋值给当前选中按钮
    _selectedButton = button;
    
    // 通知tabBarVc切换控制器，
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
    }
}

- (UIButton *)plusButton {
    if (!_plusButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        //默认按钮的尺寸和背景图片一样大
        //sizeToFit默认会根据按钮的背景图片或者image和文字计算出按钮的最佳尺寸
        [button sizeToFit];
        
        //监听按钮点击
        [button addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        _plusButton = button;
        
        [self addSubview:_plusButton];
    }
    return _plusButton;
}

- (void)plusClick {
    if ([_delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [_delegate tabBarDidClickPlusButton:self];
    }
}

//self.items UITabBarItem模型，有多少个子控制器就有多少个UITabBarItem模型

//调整子控件的位置
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w / (self.items.count+1);
    CGFloat btnH = h;
    
    int i = 0;
    //调整系统自带的tabBar上的按钮位置
    for (UIView *tabBarButton in self.subviews) {
        if (i == 2) {
            i++;
        }
        btnX = i * btnW;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i++;
    }
    
    //设置添加按钮的位置
    self.plusButton.center = CGPointMake(0.5 * w, 0.5 * h);

}


@end
