//
//  JZHPusMessgeViewController.h
//  极致荟
//
//  Created by hetao on 14-5-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHPusMessgeViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *imagescorll;
@property (weak, nonatomic) IBOutlet UIButton *addimagebut;
@property (retain,nonatomic) NSMutableArray *arr;;
+ (JZHPusMessgeViewController *)shareImage:(UIImage *)image;
@end
