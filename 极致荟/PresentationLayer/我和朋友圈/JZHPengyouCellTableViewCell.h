//
//  JZHPengyouCellTableViewCell.h
//  极致荟
//
//  Created by hetao on 14-5-7.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHPengyouCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

 @property(assign,nonatomic) UIViewController *viewcontroller;
- (void)setHaedImageList;
@end
