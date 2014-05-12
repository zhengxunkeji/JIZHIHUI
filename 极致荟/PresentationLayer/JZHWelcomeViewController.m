//
//  JZHHomeViewController.m
//  极致荟
//
//  Created by mac on 14-4-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHWelcomeViewController.h"
#import "JZHCycleScrollView.h"
#import "JZHLoginViewController.h"
#import "JZHRegisterViewController.h"

@interface JZHWelcomeViewController ()
@end

@implementation JZHWelcomeViewController

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
    //scrollview
//    JZHCycleScrollView *cyleView = [[JZHCycleScrollView alloc] initWithFrame:CGRectMake(0, 20, 320, 400)];
    JZHCycleScrollView *cyleView = [[JZHCycleScrollView alloc] initWithFrame:self.view.frame];
    cyleView.delegate = self;
    cyleView.datasource = self;
    [self.view addSubview:cyleView];
    
    [self.view bringSubviewToFront:self.regButton];
    [self.view bringSubviewToFront:self.loginButton];
    
    if (IOS7_OR_LATER) {
//        for (UIView *view in self.view.subviews) {
//            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+20, view.frame.size.width, view.frame.size.height)];
//        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---JZHCycleScrollViewDelegate methods---
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
- (void)didClickPage:(JZHCycleScrollView *)csView atIndex:(NSInteger)index{
    
}

#pragma mark ---JZHCycleScrollViewDatasource methods---
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
- (NSInteger)numberOfPages:(JZHCycleScrollView*)scrollView{
    return 3;
}
- (UIView *)XLScrollView:(JZHCycleScrollView*)scrollView pageAtIndex:(NSInteger)index{
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
//    return imageView;
    
    if (index == 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        imageView.image = [UIImage imageNamed:@"qq.png"];
        return imageView;
    }else if (index == 1){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        imageView.image = [UIImage imageNamed:@"qq.png"];
        return imageView;
    }else if (index == 2){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        imageView.image = [UIImage imageNamed:@"qq.png"];
        return imageView;
    }
    return nil;
}

#pragma mark---登录注册---
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

- (IBAction)RegisterAction:(id)sender {
    JZHRegisterViewController *registerVC = [[JZHRegisterViewController alloc] init];
    [self presentViewController:registerVC animated:YES completion:nil];
}

- (IBAction)LoginAction:(UIButton *)sender {
    JZHLoginViewController *loginVC = [[JZHLoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}
@end
