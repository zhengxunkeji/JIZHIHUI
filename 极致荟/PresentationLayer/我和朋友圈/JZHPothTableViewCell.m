//
//  JZHPothTableViewCell.m
//  极致荟
//
//  Created by hetao on 14-5-7.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHPothTableViewCell.h"
#import "JZHPusMessgeViewController.h"

@implementation JZHPothTableViewCell
 NSMutableArray *array;
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addtapImage
{
    array=[[NSMutableArray alloc]init];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clike:)];
    _image.userInteractionEnabled=YES;
    [_image addGestureRecognizer:tap];
    [array addObject:_image];
}
-(void)clike:(UITapGestureRecognizer *)tap
{
    XHImageViewer *imageViewer = [[XHImageViewer alloc] init];
    imageViewer.delegate = self;
    [imageViewer showWithImageViews:array selectedView:(UIImageView *)tap.view];
}
- (void)imageViewer:(XHImageViewer *)imageViewer willDismissWithSelectedView:(UIImageView *)selectedView {
    NSInteger index = [array indexOfObject:selectedView];
}
- (IBAction)openCamer:(id)sender {
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
        
        [self.viewcontroller presentViewController:imagecont animated:YES completion:^{}];
        
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
        [self.viewcontroller presentViewController:imagePickerController animated:YES completion:^{}];
        
        
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
    [self.viewcontroller dismissViewControllerAnimated:NO completion:^{
    }];
    [self.viewcontroller.navigationController pushViewController:[JZHPusMessgeViewController shareImage:img] animated:YES];
    
    
}

@end
