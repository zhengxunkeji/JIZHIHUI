//
//  JZHExpertViewController.m
//  极致荟
//
//  Created by hetao on 14-5-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHExpertViewController.h"
#import "JZHExpertTableViewCell.h"
@interface JZHExpertViewController ()

@end

@implementation JZHExpertViewController

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
    self.navigationItem.title=@"专家问答";
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [leftButton addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;

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
#pragma mark ---tableview代理---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 10;
    
}





-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"adf";
    JZHExpertTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"JZHExpertTableViewCell" owner:self options:nil] objectAtIndex:0];
        
    }
    
    return cell;
}


@end
