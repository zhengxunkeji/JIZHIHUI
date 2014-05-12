//
//  JZHActivityViewController.h
//  极致荟
//
//  Created by mac on 14-4-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMExampleViewController.h"


@interface JZHActivityViewController : MMExampleViewController<UITableViewDataSource,UITableViewDelegate>
{
}
@property (weak, nonatomic) IBOutlet UITableView *activityTableView;


//导航
@property (strong, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIImageView *titleArrow;
@property (strong, nonatomic) IBOutlet UIView *popoverView;
@property (weak, nonatomic) IBOutlet UIImageView *popoverBg;
- (IBAction)dropDown:(UIButton *)sender;
//接收tap事件的button
@property (weak, nonatomic) IBOutlet UIButton *titleTapButton;

- (IBAction)jingPaiAction:(UIButton *)sender;
- (IBAction)heikahuiAction:(UIButton *)sender;
- (IBAction)juhuiAction:(UIButton *)sender;


@end
