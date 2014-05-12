//
//  JZHFriendsCircleViewController.m
//  极致荟
//
//  Created by mac on 14-4-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHFriendsCircleViewController.h"
#import "JZHPengyouCellTableViewCell.h"
#import "JZHPengYouContCell.h"
#import "JZHPersonaldetailsViewController.h"
#import "JZHAGViewController.h"
#import "JZHCEView.h"
@interface JZHFriendsCircleViewController ()
{
    JZHCEView *ceview;
}

@property (weak, nonatomic) IBOutlet UIButton *myHaedImage;
@property (weak, nonatomic) IBOutlet UIPageControl *page;


@end

@implementation JZHFriendsCircleViewController
UIButton *leftButton;
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

    [leftButton setSelected:NO];
    [UIView animateWithDuration:0.0 animations:^{
        [_showview setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [ceview setFrame:CGRectMake(-230, 20, ceview.frame.size.width, ceview.frame.size.height)];
        [self.navigationController.navigationBar setFrame:CGRectMake(0, 20, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
    }];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    // Do any additional setup after loading the view from its nib.
    [_ag setContentOffset:CGPointMake(0, 0) animated:NO];
    [self setNavigation];
    [_myHaedImage.layer setBorderWidth:2];
    [_myHaedImage.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [_myHaedImage.layer setCornerRadius:8];
    [_myHaedImage.layer setMasksToBounds:YES];
    [_page setNumberOfPages:5];
    [self setagscroll];
    self.automaticallyAdjustsScrollViewInsets = NO;
    ceview=[[[NSBundle mainBundle]loadNibNamed:@"JZHCEView" owner:self options:nil] objectAtIndex:0];
    ceview.cont=self;
    [ceview setFrame:CGRectMake(-230, 20, ceview.frame.size.width, ceview.frame.size.height)];
        //[[[UIApplication sharedApplication] windows][0] addSubview:ceview];
    [self.view addSubview:ceview];

    UISwipeGestureRecognizer *swipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperecogn:)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [swipe setDelegate:self];
    //[_showview addGestureRecognizer:swipe];
      
}

//导航条设置
-(void)setNavigation
{
    //设置导航视图title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.text = @"朋友圈";
    self.navigationItem.titleView= titleLabel;
    
    //设置右侧导航按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [rightButton addTarget:self action:@selector(rightDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"friends_camera.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    //设置左侧按钮
    leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [leftButton addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"leftbar_item_bg.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)leftDrawerButtonPress:(UIButton *)sender{
    if(!sender.selected)
    {
        [UIView animateWithDuration:0.5 animations:^{
            [_showview setFrame:CGRectMake(230, 0, self.view.frame.size.width, self.view.frame.size.height)];
            [ceview setFrame:CGRectMake(0, 20, ceview.frame.size.width, ceview.frame.size.height)];
            [self.navigationController.navigationBar setFrame:CGRectMake(230, 20, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
        }];
        sender.selected=YES;

    }else
    {
        [UIView animateWithDuration:0.5 animations:^{
            [_showview setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            [ceview setFrame:CGRectMake(-230, 20, ceview.frame.size.width, ceview.frame.size.height)];
            [self.navigationController.navigationBar setFrame:CGRectMake(0, 20, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
        }];
        sender.selected=NO;

    }
    }

- (void)swiperecogn:(UISwipeGestureRecognizer *)sw
{
    NSLog(@"%@",sw);
}
- (void)rightDrawerButtonPress:(UIButton *)sender{
     [self.navigationController pushViewController:[JZHPersonaldetailsViewController shareName:@"我的相册"] animated:YES];
}
- (IBAction)pusAg:(id)sender {
    [self.navigationController pushViewController:[[JZHAGViewController alloc]init] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clikepus:(id)sender {
    [self.navigationController pushViewController:[JZHPersonaldetailsViewController shareName:@"我的相册"] animated:YES];
}

- (void)setagscroll
{
    [_ag setContentSize:CGSizeMake(320*5, 0)];
    for(int i=0;i<4;i++)
    {
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(i*320, 0, 320, 170)];
        [imageview setImage:[UIImage imageNamed:@"朋友圈大图片"]];
        [_ag addSubview:imageview];
    }
   
}
#pragma mark-------TableView代理----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        return 86;
    }else
    {
        return 200;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *pengyoucell=@"PengyouCell";
   
    if(indexPath.row==0)
    {
        JZHPengyouCellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:pengyoucell];
        if(!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"JZHPengyouCellTableViewCell" owner:self options:nil] objectAtIndex:0];
            [cell setHaedImageList];
            cell.viewcontroller=self;
        }
        
        return cell;
    }else
    {
        JZHPengYouContCell *cell=[tableView dequeueReusableCellWithIdentifier:pengyoucell];
        if(!cell)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"JZHPengYouContCell" owner:self options:nil] objectAtIndex:0];
        }
        [cell.headImage.layer setCornerRadius:6.0];
        [cell.headImage.layer setMasksToBounds:YES];
        return cell;
    }
}

#pragma mark----scorllview delete-----
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
 
    CGFloat x=scrollView.contentOffset.x/320;
    if(fmod (x,1 )==0)
    {
            [_page setCurrentPage:x];
    }

}



@end
