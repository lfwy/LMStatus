//
//  LMNewFeatureCollectionViewCell.h
//  李明微博
//
//  Created by tarena on 16/1/12.
//  Copyright © 2016年 lim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMNewFeatureCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImage *image;

- (void)setIndexPath:(NSIndexPath *)indexPath andCount:(NSInteger)count;

@end
