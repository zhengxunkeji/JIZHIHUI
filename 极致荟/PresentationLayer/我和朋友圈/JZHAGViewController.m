//
//  JZHAGViewController.m
//  极致荟
//
//  Created by hetao on 14-5-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHAGViewController.h"
#import "JZHSelectViewController.h"
@interface JZHAGViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *agImage;
@property (strong, nonatomic) IBOutlet UIView *alview;

@end

@implementation JZHAGViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void)viewWillAppear:(BOOL)animated
{
[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:93/255.0 green:190/255.0 blue:56/255.0 alpha:1]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftButton addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"广告发布返回键"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [rightButton addTarget:self action:@selector(rightDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"电话"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;

    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.text =@"广告发布";
    self.navigationItem.titleView= titleLabel;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    _agImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addag:)];
    [_agImage addGestureRecognizer:tap];

}
- (void)leftDrawerButtonPress:(UIButton *)but
{
     [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightDrawerButtonPress:(UIButton *)but
{
    
}
- (IBAction)select1:(id)sender {
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:[JZHSelectViewController shareName:@"职业筛选"] animated:YES];
}
- (IBAction)select2:(id)sender {
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:[JZHSelectViewController shareName:@"行业筛选"] animated:YES];
}
- (IBAction)gouami:(id)sender {
    
    //[self.view addSubview:_alview];
    [[[UIApplication sharedApplication] windows][0] addSubview:_alview];
    
}
- (IBAction)end:(id)sender {
    [_alview removeFromSuperview];
}
- (IBAction)pusok:(id)sender {
    [_alview removeFromSuperview];
}
- (void)addag:(UITapGestureRecognizer*)tap
{
    UIActionSheet *actionshee=[[UIActionSheet alloc]initWithTitle:@"操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"照相" otherButtonTitles:@"相册", nil];
    [actionshee showInView:[UIApplication sharedApplication].keyWindow];
  
   
}

#pragma mark actionsheet 代理方法实现-------------
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)//找一张
    {
        
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"当前相册不可用" delegate:Nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
            return;
        }
        UIImagePickerController *imagecont=[[UIImagePickerController alloc]init];
        imagecont.delegate=self;
        
        [self presentViewController:imagecont animated:YES completion:^{}];
        
    }else if (buttonIndex==0)//照一张
    {
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"当前相机不可用" delegate:Nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
            
            return;
        }
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePickerController setDelegate:self];
        [imagePickerController setAllowsEditing:YES];
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
        
    }
    
}

#pragma mark 相册 代理方法实现-------------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img;
    NSLog(@"%@",info);
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        img=[info objectForKey:UIImagePickerControllerEditedImage];
    }else {
        img=[info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        _agImage.image=img;
    }];
    
    
}

- (IBAction)butYesNo:(UIButton *)sender {
   sender.selected= sender.selected?NO:YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
