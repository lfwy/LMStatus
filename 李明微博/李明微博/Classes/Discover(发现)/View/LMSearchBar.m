//
//  LMSearchBar.m
//  李明微博
//
//  Created by tarena on 16/1/9.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMSearchBar.h"
#import "UIView+Frame.h"

@implementation LMSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:13];
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        //设置搜索框左边的搜索图片
        //以图片尺寸初始化imageView
        UIImageView *searchImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        searchImageView.contentMode = UIViewContentModeCenter;
        searchImageView.width += 10;
        self.leftView = searchImageView;
        // 一定要设置，想要显示搜索框左边的视图，一定要设置左边视图的模式
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}



@end
