//
//  JZHPersonaldetailsViewController.m
//  极致荟
//
//  Created by hetao on 14-5-7.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHPersonaldetailsViewController.h"
#import "JZHPothTableViewCell.h"
#import "JZHMessgeViewController.h"
@interface JZHPersonaldetailsViewController ()

@end

@implementation JZHPersonaldetailsViewController
NSString *str;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

+ (JZHPersonaldetailsViewController *)shareName:(NSString *)namel
{
    JZHPersonaldetailsViewController *viewcontroller=[[JZHPersonaldetailsViewController alloc]init];
    //设置导航视图title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.text = namel;
    viewcontroller.navigationItem.titleView= titleLabel;
    str=namel;
    return viewcontroller;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置左侧按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftButton addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    [self.headImage.layer setBorderWidth:2];
    [self.headImage.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.headImage.layer setCornerRadius:8];
    [self.headImage.layer setMasksToBounds:YES];
    self.automaticallyAdjustsScrollViewInsets=NO;
    //设置右侧导航按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 5)];
    [rightButton addTarget:self action:@selector(rightDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
   
    

    if([str isEqualToString:@"我的相册"])
    {
        [rightButton setImage:[UIImage imageNamed:@"详细资料圈圈"] forState:UIControlStateNormal];
    }else
    {
        [rightButton setFrame:CGRectMake(0, 0, 50, 10)];
        [rightButton setTitle:@"关注" forState:UIControlStateNormal];
        [rightButton setTitleColor:TEXTBULE forState:UIControlStateNormal];
    }
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)rightDrawerButtonPress:(UIButton *)but
{
    [self.navigationController pushViewController:[[JZHMessgeViewController alloc]init] animated:YES];
}
#pragma mark-------TableView代理----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *pengyoucell=@"PengyouCell";
    
    JZHPothTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:pengyoucell];
   
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"JZHPothTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    if([str isEqualToString:@"我的相册"] && indexPath.row==0)
    {
        cell.poth.hidden=NO;
        cell.image.hidden=YES;
        cell.conten.hidden=YES;
    }else
    {
        [cell addtapImage];
    }
    cell.viewcontroller=self;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftDrawerButtonPress:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
