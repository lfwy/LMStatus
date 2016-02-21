//
//  LMComposeView.m
//  李明微博
//
//  Created by tarena on 16/1/17.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMComposeView.h"

@interface LMComposeView ()

@property (nonatomic, weak) UILabel *label;

@end

@implementation LMComposeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (UILabel *)label {
    if (!_label) {
        UILabel *label = [[UILabel alloc]init];
        
        [self addSubview:label];
        _label = label;
    }
    return _label;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    
    self.label.text = placeHolder;

    [self.label sizeToFit];
}
//label字体设置与textView字体一致
- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.label.font = font;
    //label尺寸与文字一致
    [self.label sizeToFit];
}

- (void)setHidePlaceHolder:(BOOL)hidePlaceHolder {
    _hidePlaceHolder = hidePlaceHolder;
    //设置占位符隐藏
    _label.hidden = hidePlaceHolder;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.x = 5;
    self.label.y = 8;
}

@end
