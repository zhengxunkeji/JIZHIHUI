//
//  JZHFrendePulisTableViewCell.m
//  极致荟
//
//  Created by hetao on 14-5-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHFrendePulisTableViewCell.h"

@implementation JZHFrendePulisTableViewCell

- (void)awakeFromNib
{
    [self.headImage.layer setCornerRadius:6.0];
    [self.headImage.layer setMasksToBounds:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
