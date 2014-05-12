//
//  JZHSelectListViewController.m
//  极致荟
//
//  Created by hetao on 14-5-9.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHSelectListViewController.h"
#import "JZHAttentionTableViewCell.h"
#import "JZHPersonaldetailsViewController.h"
#import "JZHSelectViewController.h"
@interface JZHSelectListViewController ()

@end

@implementation JZHSelectListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)pusLiset:(id)sender {
    [self.navigationController pushViewController:[JZHSelectViewController shareName:self.name] animated:YES];
}

+ (JZHSelectListViewController *)shareName:(NSString *)name
{
    JZHSelectListViewController *jz=[[JZHSelectListViewController alloc]init];
    jz.name=name;
    return jz;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.text = self.name;
    self.navigationItem.titleView= titleLabel;
    self.lable.text=self.name;
    UIImage *img=[UIImage imageNamed:self.name];
    if(img)
    {
        [self.image setImage:img];
    }else
    {
        _topview.hidden=YES;
        [_table setCenter:CGPointMake(_table.center.x, _table.center.y-55)];
    }
    
    //设置左侧按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [leftButton addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;

    
}

- (void)leftDrawerButtonPress:(UIButton*)but
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---tableview代理---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
       return 10;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"adf";
    JZHAttentionTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"JZHAttentionTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    cell.but.hidden=YES;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.navigationController pushViewController:[JZHPersonaldetailsViewController shareName:@"Jone"] animated:YES];
    
}

@end
