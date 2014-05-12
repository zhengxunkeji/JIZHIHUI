//
//  JZHSelectListViewController.h
//  极致荟
//
//  Created by hetao on 14-5-9.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHSelectListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lable;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (retain,nonatomic)NSString *name;
@property (weak, nonatomic) IBOutlet UIView *topview;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIButton *but;
- (IBAction)pusLiset:(id)sender;
+ (JZHSelectListViewController *)shareName:(NSString *)name;
@end
