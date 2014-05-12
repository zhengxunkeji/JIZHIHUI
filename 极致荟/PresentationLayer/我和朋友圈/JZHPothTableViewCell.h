//
//  JZHPothTableViewCell.h
//  极致荟
//
//  Created by hetao on 14-5-7.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHImageViewer.h"
@interface JZHPothTableViewCell : UITableViewCell<XHImageViewerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *image;

- (void)addtapImage;
@property (weak, nonatomic) IBOutlet UITextView *conten;
@property (weak, nonatomic) IBOutlet UIButton *poth;
@property (assign,nonatomic) UIViewController *viewcontroller;
@end
