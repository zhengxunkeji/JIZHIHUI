//
//  JZHGiftViewController.h
//  极致荟
//
//  Created by mac on 14-4-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorizontalTableView.h"

@interface JZHFirstLevelViewController : UIViewController<HorizontalTableViewDelegate>
{
    NSArray *colors;
}
@property (nonatomic, retain) IBOutlet HorizontalTableView *tableView;
@property (nonatomic, retain) UIView *columnView;
@end
