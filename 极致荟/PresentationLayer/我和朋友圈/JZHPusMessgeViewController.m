//
//  JZHPusMessgeViewController.m
//  极致荟
//
//  Created by hetao on 14-5-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHPusMessgeViewController.h"

@interface JZHPusMessgeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

    

@end

@implementation JZHPusMessgeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
+ (JZHPusMessgeViewController *)shareImage:(UIImage *)image
{
    JZHPusMessgeViewController *pus=[[JZHPusMessgeViewController alloc]init];
    pus.arr=[[NSMutableArray alloc]initWithObjects:image, nil];
    return pus;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadScorllViewData];
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftButton addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setFrame:CGRectMake(0, 0, 50, 10)];
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithRed:28/255.0 green:120/255.0 blue:210/255.0 alpha:1] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 5)];
    [rightButton addTarget:self action:@selector(rightDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setFrame:CGRectMake(0, 0, 50, 10)];
    [rightButton setTitle:@"发送" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithRed:28/255.0 green:120/255.0 blue:210/255.0 alpha:1] forState:UIControlStateNormal];

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
///改变Scorllview布局
- (void)loadScorllViewData
{
    int i;
    for( i=0;i<_arr.count;i++)
    {
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(i*65+(i+1)*20, 0, 65, 65)];
        [imageview setImage:[_arr objectAtIndex:i]];
        [_imagescorll addSubview:imageview];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_addimagebut setFrame:CGRectMake(65*i+(i+1)*20, 0, 65, 65)];
    });

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addimage:(id)sender {
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
   
    [_arr addObject:img];
  
    
    [self loadScorllViewData];
   
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


#pragma mark ---textview代理---
- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"%@",textView.text);
    if(textView.text.length>0)
    {
        _label.hidden=YES;
    }else
    {
        _label.hidden=NO;
    }
    
}

@end
