//
//  JZHExpertTableViewCell.m
//  极致荟
//
//  Created by hetao on 14-5-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHExpertTableViewCell.h"

@implementation JZHExpertTableViewCell

- (void)awakeFromNib
{
    [self.image.layer setCornerRadius:25];
    
    [self.image.layer setMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
