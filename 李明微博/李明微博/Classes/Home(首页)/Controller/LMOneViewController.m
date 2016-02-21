//
//  LMOneViewController.m
//  李明微博
//
//  Created by tarena on 16/1/9.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMOneViewController.h"
#import "UIBarButtonItem+Item.h"
#import "LMTwoViewController.h"

@interface LMOneViewController ()

@end

@implementation LMOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)jumpToTwo:(UIButton *)sender {
    LMTwoViewController *twoViewController = [[LMTwoViewController alloc]init];
    [self.navigationController pushViewController:twoViewController animated:YES];
}

@end
