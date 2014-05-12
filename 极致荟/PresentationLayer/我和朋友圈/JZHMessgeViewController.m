//
//  JZHMessgeViewController.m
//  极致荟
//
//  Created by hetao on 14-5-7.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHMessgeViewController.h"
#import "JZHMessgeTableViewCell.h"
#import "JZHPersonaldetailsViewController.h"
@interface JZHMessgeViewController ()

@end

@implementation JZHMessgeViewController

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
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftButton addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.text =@"消息";
    self.navigationItem.titleView= titleLabel;
    self.automaticallyAdjustsScrollViewInsets=NO;
}

- (void)leftDrawerButtonPress:(UIButton *)but
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-------TableView代理----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *pengyoucell=@"PengyouCell";
    
    JZHMessgeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:pengyoucell];
    
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"JZHMessgeTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
   
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[JZHPersonaldetailsViewController shareName:@"Jack"] animated:YES];
}


@end
