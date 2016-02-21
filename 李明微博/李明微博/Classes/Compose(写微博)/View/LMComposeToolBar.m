//
//  LMComposeToolBar.m
//  李明微博
//
//  Created by tarena on 16/1/17.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMComposeToolBar.h"

@implementation LMComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //添加所有子控件
        [self setUpAllChildView];
    }
    return self;
}
#pragma mark - 添加所有子控件
- (void)setUpAllChildView {
    //相册
    [self setUpOneButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];
    //提及
    [self setUpOneButtonWithImage:[UIImage imageNamed:@"compose_mentionbutton_background"] highImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"] target:self action:@selector(btnClick:)];
    
    //话题
    [self setUpOneButtonWithImage:[UIImage imageNamed:@"compose_trendbutton_background"] highImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"] target:self action:@selector(btnClick:)];
    
    //表情
    [self setUpOneButtonWithImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] highImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] target:self action:@selector(btnClick:)];
    
    //键盘
    [self setUpOneButtonWithImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] highImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] target:self action:@selector(btnClick:)];
}

- (void)btnClick:(UIButton *)button {
    //点击工具条的时候
    if ([_delegate respondsToSelector:@selector(composeToolBar:DidClickButton:)]) {
        [_delegate composeToolBar:self DidClickButton:button.tag];
    }
}


- (void)setUpOneButtonWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action
{
    // btn

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.tag = self.subviews.count;
    [self addSubview:btn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.width / count;
    CGFloat h = self.height;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
    
}

@end
