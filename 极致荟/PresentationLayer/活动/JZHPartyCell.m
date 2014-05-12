//
//  JZHPartyCell.m
//  极致荟
//
//  Created by mac on 14-4-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHPartyCell.h"

@implementation JZHPartyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //加载nib
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"JZHPartyCell" owner:self options:nil];
        if (arrayOfViews.count < 1) {
            return nil;
        }
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[JZHPartyCell class]]) {
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
