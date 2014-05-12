//
//  JZHMessageViewController.m
//  极致荟
//
//  Created by mac on 14-4-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHMessageViewController.h"
#import "JZHFrenListTableViewCell.h"
#import "JZHContactsViewController.h"
#import "JZHFrendPulisViewController.h"
#import "JZHDovViewController.h"
#import "JZHExpertViewController.h"
@interface JZHMessageViewController ()
{
NSMutableArray *arr;
}
@end

@implementation JZHMessageViewController

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
    arr=[[NSMutableArray alloc]initWithObjects:@"a",@"a",@"a", nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title=@"讯 息";
    //设置右侧导航按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [rightButton addTarget:self action:@selector(rightDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"friends_camera.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;

}
- (void)rightDrawerButtonPress:(UIButton *)sender
{
    
}
- (IBAction)pusExce:(id)sender {
    [self.navigationController pushViewController:[[JZHExpertViewController alloc]init] animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pusDov:(id)sender {
    [self.navigationController pushViewController:[[JZHDovViewController alloc]init] animated:YES];
    
}
#pragma mark ---tableview代理---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"adf";
    JZHFrenListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"JZHFrenListTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    [cell.headImage.layer setCornerRadius:6];
    [cell.headImage.layer setMasksToBounds:YES];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    [self.navigationController pushViewController:[JZHPersonaldetailsViewController shareName:@"Jone"] animated:YES];
//    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   
     [arr removeObjectAtIndex:indexPath.row];
    
   
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation: UITableViewRowAnimationNone];
}

- (IBAction)pusFrend:(id)sender {
    [self.navigationController pushViewController:[[JZHFrendPulisViewController alloc]init] animated:YES];
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete;
}
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath
{
    return @"删除";
}
- (IBAction)pusContacList:(id)sender {
    
    [self.navigationController pushViewController:[[JZHContactsViewController alloc]init] animated:YES];
}
@end
