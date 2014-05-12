//
//  JZHFriendsCircleViewController.h
//  极致荟
//
//  Created by mac on 14-4-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHFriendsCircleViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *ag;
@property (weak, nonatomic) IBOutlet UIView *showview;
@end
