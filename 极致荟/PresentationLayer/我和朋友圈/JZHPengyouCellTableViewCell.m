//
//  JZHPengyouCellTableViewCell.m
//  极致荟
//
//  Created by hetao on 14-5-7.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHPengyouCellTableViewCell.h"
#import "JZHAttentionViewController.h"
#import "JZHPersonaldetailsViewController.h"
@implementation JZHPengyouCellTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}
- (IBAction)pus:(id)sender {
    [self.viewcontroller.navigationController pushViewController:[[JZHAttentionViewController alloc]init] animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setHaedImageList
{
    for(int i=0;i<4;i++)
    {
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pusview:)];
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(i*40+14+i*25, 0, 45, 45)];
        [imageview addGestureRecognizer:tap];
        [imageview setUserInteractionEnabled:YES];
        [imageview setImage:[UIImage imageNamed:@"activity_small_image"]];
        [imageview.layer setCornerRadius:8];
        [imageview.layer setMasksToBounds:YES];
        [_scrollview addSubview:imageview];
    }
}
- (void)pusview:(UITapGestureRecognizer *)tap
{
    [self.viewcontroller.navigationController pushViewController:[JZHPersonaldetailsViewController shareName:@"Jone"] animated:YES];
    
}
@end
