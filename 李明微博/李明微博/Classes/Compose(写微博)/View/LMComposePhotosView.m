//
//  LMComposePhotosView.m
//  李明微博
//
//  Created by tarena on 16/1/17.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMComposePhotosView.h"

@implementation LMComposePhotosView

- (void)setSelectedImage:(UIImage *)selectedImage {
    _selectedImage = selectedImage;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    
    imageView.image = selectedImage;
    [self addSubview:imageView];
    
}
//每添加一个子控件时也会调用
//特殊如果在viewDidLoad添加子控件，就不会调用layoutSubViews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger cols = 3;
    CGFloat marign = 10;
    CGFloat wh = (self.width - (cols - 1) * marign) / cols;
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger col = 0;
    NSInteger row = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIImageView *imageView = self.subviews[i];
        
        col = i % cols;
        row = i / cols;
        x = col * (marign + wh);
        y = row * (marign + wh);
        imageView.frame = CGRectMake(x, y, wh, wh);
        
        
    }
    
}

@end
