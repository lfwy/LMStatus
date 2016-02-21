//
//  LMNewFeatureCollectionViewCell.m
//  李明微博
//
//  Created by tarena on 16/1/12.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMNewFeatureCollectionViewCell.h"
#import "LMTabBarController.h"

@interface LMNewFeatureCollectionViewCell ()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *shareButton;
@property (nonatomic,strong) UIButton *startButton;

@end

@implementation LMNewFeatureCollectionViewCell

- (UIButton *)shareButton {
    if (!_shareButton) {
        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
        [shareButton setImage:[UIImage imageWithOriginalName:@"new_feature_share_false"] forState:UIControlStateNormal];
        [shareButton setImage:[UIImage imageWithOriginalName:@"new_feature_share_true"] forState:UIControlStateSelected];
        [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [shareButton sizeToFit];
        [self.contentView addSubview:shareButton];
        _shareButton = shareButton;
    }
    return _shareButton;
}

- (UIButton *)startButton {
    if (!_startButton) {
        UIButton *startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
        [startButton setBackgroundImage:[UIImage imageWithOriginalName:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [startButton setBackgroundImage:[UIImage imageWithOriginalName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [startButton sizeToFit];
        [startButton addTarget:self action:@selector(startApp) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:startButton];
        _startButton = startButton;
    }
    return _startButton;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imageV = [[UIImageView alloc]init];
        _imageView = imageV;
        //注意：一定要加到contentView上
        [self.contentView addSubview:imageV];
    }
    return _imageView;
}
//布局子控件的frame
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    
    self.startButton.center = CGPointMake(self.width * 0.5, self.height * 0.8);
    
    self.shareButton.center = CGPointMake(self.width * 0.5, self.height * 0.7);
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}


- (void)setIndexPath:(NSIndexPath *)indexPath andCount:(NSInteger)count {
    if (indexPath.row == count-1) {
        self.startButton.hidden = NO;
        self.shareButton.hidden = NO;
    }else {
        self.startButton.hidden = YES;
        self.shareButton.hidden = YES;
    }
}

- (void)startApp {
    LMTabBarController *tabBarVC = [[LMTabBarController alloc]init];
    LMKeyWindow.rootViewController = tabBarVC;
}

@end
