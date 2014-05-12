//
//  JZHFrendPulisViewController.m
//  极致荟
//
//  Created by hetao on 14-5-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHFrendPulisViewController.h"
#import "JZHFrendePulisTableViewCell.h"
@interface JZHFrendPulisViewController ()

@end

@implementation JZHFrendPulisViewController

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
    self.navigationItem.title=@"好友验证";
    //设置左侧按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [leftButton addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 5)];
    [rightButton addTarget:self action:@selector(rightDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [rightButton setFrame:CGRectMake(0, 0, 50, 10)];
        [rightButton setTitle:@"清空" forState:UIControlStateNormal];
        [rightButton setTitleColor:TEXTBULE forState:UIControlStateNormal];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;

}

- (void)leftDrawerButtonPress:(UIButton *)but
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightDrawerButtonPress:(UIButton *)but
{

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





-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 111;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"adf";
    JZHFrendePulisTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"JZHFrendePulisTableViewCell" owner:self options:nil] objectAtIndex:0];
        
    }
    
    return cell;
}


@end
