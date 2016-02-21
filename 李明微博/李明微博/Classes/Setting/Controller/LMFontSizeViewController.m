//
//  LMFontSizeViewController.m
//  李明微博
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMFontSizeViewController.h"
#import "LMBaseSetting.h"
#import "LMFontSizeTool.h"

#define LMFontSizeNote @"fontSizeNote"

@interface LMFontSizeViewController ()

@property (nonatomic, weak) LMCheckItem *selCheckItem;

@end

@implementation LMFontSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加group
    [self setUpGroup];
    
}

- (void)setUpGroup {
    
    __weak typeof(self) weakSelf = self;
    
    LMCheckItem *bigItem = [LMCheckItem itemWithTitle:@"大"];
    bigItem.option = ^(LMCheckItem *item){
        [weakSelf selItem:item];
    };
    LMCheckItem *middleItem = [LMCheckItem itemWithTitle:@"中"];
    middleItem.option = ^(LMCheckItem *item){
        [weakSelf selItem:item];
    };
    LMCheckItem *smallItem = [LMCheckItem itemWithTitle:@"小"];
    smallItem.option = ^(LMCheckItem *item){
        [weakSelf selItem:item];
    };
    LMGroupItem *group = [[LMGroupItem alloc]init];
    group.items = @[bigItem,middleItem,smallItem];
    [self.groups addObject:group];
    //默认选中当前字体
    [self selfItemWithTitle:[LMFontSizeTool fontSize]];

}
//根据字体默认选中item
- (void)selfItemWithTitle:(NSString *)fontSize {
    for (LMGroupItem *group in self.groups) {
        for (LMCheckItem *item in group.items) {
            if ([fontSize isEqualToString:item.title]) {
                [self selItem:item];
            }
        }
    }
}

- (void)selItem:(LMCheckItem *)item {

    _selCheckItem.check = NO;
    item.check = YES;
    _selCheckItem = item;
    
    [self.tableView reloadData];
    //保存当前选中的字体
    [LMFontSizeTool saveFontSize:item.title];
    //发送通知，修改commonSetting的字体模型
    [[NSNotificationCenter defaultCenter] postNotificationName:LMFontSizeNote object:nil];
}



@end
