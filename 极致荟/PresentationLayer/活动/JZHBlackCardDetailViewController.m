//
//  JZHBlackCardDetailViewController.m
//  极致荟
//
//  Created by mac on 14-4-30.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHBlackCardDetailViewController.h"
#import "JZHTabbarViewController.h"

@interface JZHBlackCardDetailViewController ()

@end

@implementation JZHBlackCardDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[JZHTabbarViewController shareInstance] showTabBar2];
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
//    self.navigationItem.titleView = _titleView;
//    [_popoverBg setImage:[[UIImage imageNamed:@"popover_background.png"]stretchableImageWithLeftCapWidth:10 topCapHeight:30]];
//    
//    [_popoverView setCenter:CGPointMake(160, 44+50+17)];
//    
//    
//    //设置右侧导航按钮
//    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
//    [rightButton setTitle:@"发活动" forState:UIControlStateNormal];
//    [rightButton setTitle:@"发活动" forState:UIControlStateHighlighted];
//    
//    [rightButton addTarget:self action:@selector(rightBarButtonPress:) forControlEvents:UIControlEventTouchUpInside];
//    
//    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
//    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    self.navigationItem.rightBarButtonItem = rightBarButton;
//    
//    //设置左侧按钮
//    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
//    [leftButton addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
//    [leftButton setImage:[UIImage imageNamed:@"leftbar_item_bg.png"] forState:UIControlStateNormal];
//    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.title = @"活动详情";

    //设置左侧按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [leftButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"leftbar_item_bg.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;

}

- (void)backAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
