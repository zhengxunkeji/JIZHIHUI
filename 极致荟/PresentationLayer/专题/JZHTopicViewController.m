//
//  JZHTopicViewController.m
//  极致荟
//
//  Created by mac on 14-4-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHTopicViewController.h"
#import "JZHFirstLevelViewController.h"
#import "JZHTopicTemplateListVC.h"
#import "SBPageFlowView.h"


@interface JZHTopicViewController ()<SBPageFlowViewDelegate,SBPageFlowViewDataSource>{
    NSArray *_imageArray;
    
    NSInteger    _currentPage;
    
    SBPageFlowView  *_flowView;
}

@end

@implementation JZHTopicViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    
    [self setNavigation];
    
    //scrollview
    // Do any additional setup after loading the view, typically from a nib.
    _imageArray = [[NSArray alloc] initWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",nil];
    
    _currentPage = 0;
    
    _flowView = [[SBPageFlowView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height-20-44-49)];
    
    _flowView.delegate = self;
    _flowView.dataSource = self;
    _flowView.minimumPageAlpha = 0.6;
    _flowView.minimumPageScale = 0.76;
    _flowView.defaultImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpg"]];
    [self.view addSubview:_flowView];
    
    [_flowView reloadData];

    //
    if (IOS7_OR_LATER) {
        for (UIView *view in self.view.subviews) {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+66, view.frame.size.width, view.frame.size.height)];
        }
    }
    
    //
    
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
    //设置导航视图title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.text = @"专题";
    self.navigationItem.titleView= titleLabel;
    
    //设置右侧导航按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 44)];
    [rightButton setTitle:@"上海" forState:UIControlStateNormal];
    [rightButton setTitle:@"上海" forState:UIControlStateHighlighted];
    
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    UIImageView *rightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pointer_donw.png"]];
    rightImage.frame = CGRectMake(0, 0, 9, 5);
    UIBarButtonItem *rightBarImage = [[UIBarButtonItem alloc] initWithCustomView:rightImage];
    
    NSArray *rightBarArray = [NSArray arrayWithObjects:rightBarImage, rightBarButton,nil];
    self.navigationItem.rightBarButtonItems = rightBarArray;
}
//返回
-(void)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - PagedFlowView Datasource
//返回显示View的个数
- (NSInteger)numberOfPagesInFlowView:(SBPageFlowView *)flowView{
    return [_imageArray count];
}

- (CGSize)sizeForPageInFlowView:(SBPageFlowView *)flowView;{
    return CGSizeMake(230, 350);
}

//返回给某列使用的View
- (UIView *)flowView:(SBPageFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    UIImageView *imageView = (UIImageView *)[flowView dequeueReusableCell];
    if (!imageView) {
        imageView = [[UIImageView alloc] init];
        imageView.layer.masksToBounds = YES;
    }
    
    imageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:index]];
    return imageView;
}

#pragma mark - PagedFlowView Delegate
- (void)didReloadData:(UIView *)cell cellForPageAtIndex:(NSInteger)index
{
    UIImageView *imageView = (UIImageView *)cell;
    imageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:index]];
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(SBPageFlowView *)flowView {
    NSLog(@"Scrolled to page # %d", pageNumber);
    _currentPage = pageNumber;
}

- (void)didSelectItemAtIndex:(NSInteger)index inFlowView:(SBPageFlowView *)flowView
{
    NSLog(@"didSelectItemAtIndex: %d", index);
    
//    UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@""
//                                                     message:[NSString stringWithFormat:@"您当前选择的是第 %d 个图片",index]
//                                                    delegate:self
//                                           cancelButtonTitle:@"确定"
//                                           otherButtonTitles: nil];
//    [alert show];
    
    if (index == 0) {//礼品
        //进入一级菜单
        JZHFirstLevelViewController *giftFirstLevelVC = [[JZHFirstLevelViewController alloc] init];
        [self.navigationController pushViewController:giftFirstLevelVC animated:YES];
    }else{
        JZHTopicTemplateListVC *templateListVC = [[JZHTopicTemplateListVC alloc] init];
        [self.navigationController pushViewController:templateListVC animated:YES];
    }
    
}


@end
