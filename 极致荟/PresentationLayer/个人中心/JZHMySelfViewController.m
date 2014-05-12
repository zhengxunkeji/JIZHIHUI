//
//  JZHMySelfViewController.m
//  极致荟
//
//  Created by mac on 14-4-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHMySelfViewController.h"
#import "JZHMyPorfileTableViewCell.h"
@interface JZHMySelfViewController ()
{
    NSArray *arr;
}
@end

@implementation JZHMySelfViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    arr=[[NSArray alloc]initWithObjects:@"我的相册", @"我的收藏",@"会员中心",@"我的广告",@"我的账单",@"我的活动",@"我的评论",@"我的竞拍",nil];
    self.navigationItem.title=@"我";
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [rightButton addTarget:self action:@selector(rightDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"个人信息二维码"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightDrawerButtonPress:(UIButton *)but
{
    
}
#pragma mark ---tableview代理---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return arr.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int i= [[NSNumber numberWithInteger:indexPath.row] intValue]+1;
    static NSString *str=@"adf";
    JZHMyPorfileTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"JZHMyPorfileTableViewCell" owner:self options:nil] objectAtIndex:0];
        [cell.image setImage:[UIImage imageNamed:[NSString stringWithFormat:@"我%d",i]]];
        [cell.lable setText:arr[indexPath.row]];
    }
    
    return cell;
}


@end
