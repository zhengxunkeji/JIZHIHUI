//
//  JZHLoginViewController.m
//  极致荟
//
//  Created by mac on 14-4-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHLoginViewController.h"
#import "JZHTabbarViewController.h"
#import "JZHTopicViewController.h"
#import "JZHActivityViewController.h"
#import "JZHMessageViewController.h"
#import "JZHFriendsCircleViewController.h"
#import "JZHMySelfViewController.h"

#import "MMDrawerController.h"
#import "JZHActivityViewController.h"
#import "MMExampleLeftSideDrawerViewController.h"
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "MMNavigationController.h"

#pragma mark -
#pragma mark Private Interface
@interface JZHLoginViewController ()
{
    NSMutableArray* _permissions;
}
@property (nonatomic,strong) MMDrawerController * drawerController;
@end


#pragma mark -
#pragma mark Implementation
@implementation JZHLoginViewController

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
    //导航设置
    [self setNavigation];
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
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark ---登录----
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

- (IBAction)LoginAction:(UIButton *)sender {
    /**
     *1.登录失败，进行提示
     *2.登录成功进入主页
     */
    
    //创建tabbar
    //JZHTabbarViewController *tabVC = [[JZHTabbarViewController alloc] init];
    //UITabBarController *tabVC = [[UITabBarController alloc] init];
    JZHTabbarViewController *tabVC = [JZHTabbarViewController shareInstance];
    //创建controllers
    JZHTopicViewController *topicVC = [[JZHTopicViewController alloc] init];
    //JZHActivityViewController *activityVC = [[JZHActivityViewController alloc] init];
    JZHFriendsCircleViewController *friendsVC = [[JZHFriendsCircleViewController alloc] init];
    JZHMessageViewController *messageVC = [[JZHMessageViewController alloc] init];
    JZHMySelfViewController *myselfVC = [[JZHMySelfViewController alloc] init];
    
    UINavigationController *topicNav = [[UINavigationController alloc] initWithRootViewController:topicVC];
    //UINavigationController *activityNav = [[UINavigationController alloc] initWithRootViewController:activityVC];
    UINavigationController *friendsNav = [[UINavigationController alloc] initWithRootViewController:friendsVC];
    UINavigationController *messageNav = [[UINavigationController alloc] initWithRootViewController:messageVC];
    UINavigationController *myselfNav = [[UINavigationController alloc] initWithRootViewController:myselfVC];
    
    
    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    UIViewController * leftSideDrawerViewController = [[MMExampleLeftSideDrawerViewController alloc] init];
    
    UIViewController * centerViewController = [[JZHActivityViewController alloc] init];
    
    UINavigationController * navigationController = [[MMNavigationController alloc] initWithRootViewController:centerViewController];
    [navigationController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
    if(OSVersionIsAtLeastiOS7>=7.0){
        UINavigationController * leftSideNavController = [[MMNavigationController alloc] initWithRootViewController:leftSideDrawerViewController];
		[leftSideNavController setRestorationIdentifier:@"MMExampleLeftNavigationControllerRestorationKey"];
        self.drawerController = [[MMDrawerController alloc]
                                 initWithCenterViewController:navigationController
                                 leftDrawerViewController:leftSideNavController
                                 rightDrawerViewController:nil];
        [self.drawerController setShowsShadow:NO];
    }
    else{
        self.drawerController = [[MMDrawerController alloc]
                                 initWithCenterViewController:navigationController
                                 leftDrawerViewController:leftSideDrawerViewController
                                 rightDrawerViewController:nil];
    }
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumLeftDrawerWidth:200.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(OSVersionIsAtLeastiOS7>=7.0){
        UIColor * tintColor = [UIColor colorWithRed:29.0/255.0
                                              green:173.0/255.0
                                               blue:234.0/255.0
                                              alpha:1.0];
        [window setTintColor:tintColor];
    }
//    [window setRootViewController:self.drawerController];
    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    
    
    NSArray *vcArrays = [NSArray arrayWithObjects:topicNav,self.drawerController,friendsNav,messageNav,myselfNav, nil];
    
    tabVC.viewControllers = vcArrays;
    
    [[UIApplication sharedApplication] keyWindow].rootViewController = tabVC;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
#pragma mark --QQ登录--
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
- (IBAction)QQLoginAction:(UIButton *)sender {

}

@end
