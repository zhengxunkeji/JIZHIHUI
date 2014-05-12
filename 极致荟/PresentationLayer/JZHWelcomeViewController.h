//
//  JZHHomeViewController.h
//  极致荟
//
//  Created by mac on 14-4-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZHCycleScrollView.h"

@interface JZHWelcomeViewController : UIViewController<JZHCycleScrollViewDelegate,JZHCycleScrollViewDatasource>

//登录注册
- (IBAction)RegisterAction:(id)sender;
- (IBAction)LoginAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *regButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
