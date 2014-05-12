//
//  JZHCEView.m
//  极致荟
//
//  Created by hetao on 14-5-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHCEView.h"
#import "JZHCETableViewCell.h"
#import "JZHSelectListViewController.h"
@implementation JZHCEView
NSArray *arr;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!arr)
    {
        arr=[[NSArray alloc]initWithObjects:@"新鲜人脉",@"行业筛选",@"职业筛选", @"同城附近", @"地区筛选",  nil];
    }
    return arr.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"adf";
    JZHCETableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"JZHCETableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    if(indexPath.row<arr.count)
    {
    [cell.lable setText:arr[indexPath.row]];
    }else
    {
        cell.lable.hidden=YES;
        cell.image.hidden=YES;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
   
    [self.cont.navigationController pushViewController:[JZHSelectListViewController shareName:arr[indexPath.row]] animated:YES  ];
    
}
@end
