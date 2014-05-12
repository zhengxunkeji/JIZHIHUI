//
//  JZHTopicTemplateListVC.m
//  极致荟
//
//  Created by mac on 14-4-9.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHTopicTemplateListVC.h"
#import "JZHTopicTemplateDetailViewController.h"

@interface JZHTopicTemplateListVC ()

@end

@implementation JZHTopicTemplateListVC
@synthesize tableView;
@synthesize columnView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigation];
    
    if (IOS7_OR_LATER) {
        for (UIView *view in [self.view subviews]) {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y+64, view.frame.size.width, view.frame.size.height);
        }
        CGRect tableRect = self.tableView.frame;
        tableRect = CGRectMake(tableRect.origin.x, tableRect.origin.y, tableRect.size.width, self.view.frame.size.height-64-49);
        self.tableView.frame= tableRect;
        [self.tableView layoutSubviews];
    }
    
    
    //
    CALayer *layer = [self.tableView layer];
    [layer setCornerRadius:15.0f];
    
    
    NSMutableArray *colorArray = [[NSMutableArray alloc] init];
    NSInteger step = 5;
    for (NSInteger i = 0; i < 255; i += step) {
        CGFloat f = (float)i/255.0f;
        UIColor *clr = [UIColor colorWithRed:f green:f blue:f alpha:1.0f];
        [colorArray addObject:clr];
    }
    colors = colorArray;
    // [self.tableView refreshData];
    [self.tableView performSelector:@selector(refreshData) withObject:nil afterDelay:0.3f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---导航----
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//导航条设置
-(void)setNavigation
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title"] forBarMetrics:UIBarMetricsDefault];
    //设置左按钮
    self.navigationController.navigationBar.tintColor=[UIColor orangeColor];
    UIButton *backBut=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 54, 32)];
    [backBut setBackgroundImage:[UIImage imageNamed:@"lab_btn_bac_1k@2x"] forState:UIControlStateNormal];
    [backBut setImage:[UIImage imageNamed:@"lab_btn_bac_1k@2x"] forState:UIControlStateHighlighted];
    [backBut setTitle:@"返回" forState:UIControlStateNormal];
    [backBut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [backBut.titleLabel setFont:[UIFont systemFontOfSize:14]];
    UIBarButtonItem *backBarButton=[[UIBarButtonItem alloc]initWithCustomView:backBut];
    [self.navigationItem setLeftBarButtonItem:backBarButton];
    //设置导航视图title
    //self.navigationItem.titleView=[DealTitle dealTitle:@"登陆"];
}
//返回
-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark HorizontalTableViewDelegate methods
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

- (NSInteger)numberOfColumnsForTableView:(HorizontalTableView *)tableView {
    return [colors count];
}

- (UIView *)tableView:(HorizontalTableView *)aTableView viewForIndex:(NSInteger)index {
    
    UIView *vw = [aTableView dequeueColumnView];
    if (!vw) {
        NSLog(@"Constructing new view");
        
        self.columnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, aTableView.bounds.size.width, aTableView.bounds.size.height)];
        
        UILabel *labelOne = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, aTableView.bounds.size.height/2)];
        [self.columnView addSubview:labelOne];
        labelOne.backgroundColor = [UIColor redColor];
        
        labelOne = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 160, aTableView.bounds.size.height/2)];
        [self.columnView addSubview:labelOne];
        labelOne.backgroundColor = [UIColor blueColor];
        
        labelOne = [[UILabel alloc] initWithFrame:CGRectMake(0, aTableView.bounds.size.height/2, 160, aTableView.bounds.size.height/2)];
        [self.columnView addSubview:labelOne];
        labelOne.backgroundColor = [UIColor cyanColor];
        
        labelOne = [[UILabel alloc] initWithFrame:CGRectMake(160, aTableView.bounds.size.height/2, 160, aTableView.bounds.size.height/2)];
        [self.columnView addSubview:labelOne];
        labelOne.backgroundColor = [UIColor yellowColor];
        
        vw = self.columnView;
        self.columnView = nil;
        
    }
    [vw setBackgroundColor:[colors objectAtIndex:index]];
    
    
    UILabel *lbl = (UILabel *)[vw viewWithTag:1234];
    lbl.text = [NSString stringWithFormat:@"%d", index];
    
	return vw;
}

- (CGFloat)columnWidthForTableView:(HorizontalTableView *)tableView {
    return 320.0f;
}

- (void)tableView:(HorizontalTableView *)tableView didSelectColumn:(int)column withItem:(int)item{
    NSLog(@"currentPageIndex:%d:%d",column,item);
    JZHTopicTemplateDetailViewController *templateListDetail = [[JZHTopicTemplateDetailViewController alloc] init];
    [self.navigationController pushViewController:templateListDetail animated:YES];
}

- (void)tableView:(HorizontalTableView *)tableView didScrolledToColumn:(int)column{
    NSLog(@"tableView:(HorizontalTableView *)tableView didScrolledToColumn:(int)column{:%d",column);
}

@end
