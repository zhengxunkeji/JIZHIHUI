//
//  JZHPartyCell.h
//  极致荟
//
//  Created by mac on 14-4-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHPartyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *userSexAndAgeLabel;


@property (weak, nonatomic) IBOutlet UILabel *partyTitle;
@property (weak, nonatomic) IBOutlet UIButton *partyShareButton;
@property (weak, nonatomic) IBOutlet UIImageView *partyBigImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *partyImageScroller;
@property (weak, nonatomic) IBOutlet UILabel *partyPersonNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *partyDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *partyType;
@property (weak, nonatomic) IBOutlet UISwitch *partySignSwitch;
@property (weak, nonatomic) IBOutlet UIButton *partyDiscussButton;

@end
