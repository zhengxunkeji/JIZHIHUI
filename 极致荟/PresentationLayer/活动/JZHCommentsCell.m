//
//  JZHCommentsCell.m
//  极致荟
//
//  Created by mac on 14-4-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHCommentsCell.h"

@implementation JZHCommentsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //加载nib
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"JZHCommentsCell" owner:self options:nil];
        if (arrayOfViews.count < 1) {
            return nil;
        }
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[JZHCommentsCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
