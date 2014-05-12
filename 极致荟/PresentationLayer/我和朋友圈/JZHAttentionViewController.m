//
//  JZHAttentionViewController.m
//  极致荟
//
//  Created by hetao on 14-5-7.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHAttentionViewController.h"
#import "JZHAttentionTableViewCell.h"
#import "JZHConcernedResourceViewController.h"
#import "JZHPersonaldetailsViewController.h"
@interface JZHAttentionViewController ()

@end

@implementation JZHAttentionViewController

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
    // Do any additional setup after loading the view from its nib.
    [self setNavigation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//导航条设置
-(void)setNavigation
{
    //设置导航视图title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.text = @"推荐关注";
    self.navigationItem.titleView= titleLabel;
    
   
    //设置左侧按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftButton addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)leftDrawerButtonPress:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    
        JZHAttentionTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:pengyoucell];
        if(!cell)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"JZHAttentionTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        [cell.headImage.layer setCornerRadius:6.0];
        [cell.headImage.layer setMasksToBounds:YES];
        return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[JZHPersonaldetailsViewController shareName:@"Alin"] animated:YES];
}
- (IBAction)pus:(id)sender {
    [self.navigationController pushViewController:[[JZHConcernedResourceViewController alloc]init] animated:YES];
}


@end
