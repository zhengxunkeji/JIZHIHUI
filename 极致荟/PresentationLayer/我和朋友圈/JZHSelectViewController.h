//
//  JZHSelectViewController.h
//  极致荟
//
//  Created by hetao on 14-5-9.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHSelectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
+ (JZHSelectViewController *)shareName:(NSString *)name;
@property (retain,nonatomic)NSString *name;
@end
