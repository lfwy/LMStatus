//
//  LMComposeToolBar.h
//  李明微博
//
//  Created by tarena on 16/1/17.
//  Copyright © 2016年 lim. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LMComposeToolBar;
@protocol LMComposeToolBarDelegate <NSObject>
@optional
- (void)composeToolBar:(LMComposeToolBar *)toolBar DidClickButton:(NSInteger)index;

@end

@interface LMComposeToolBar : UIView

@property (nonatomic, weak) id<LMComposeToolBarDelegate> delegate;

@end
