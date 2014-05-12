//
//  JZHRegisterViewController.h
//  极致荟
//
//  Created by mac on 14-4-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHRegisterViewController : UIViewController<UITextFieldDelegate>
{
    //注册方式
    BOOL isPhone;
    
}

//注册方式  手机号  用户名
- (IBAction)regByPhone:(UIButton *)sender;
- (IBAction)regByName:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnPhoneReg;
@property (weak, nonatomic) IBOutlet UIButton *btnNameReg;

//注册信息
@property (weak, nonatomic) IBOutlet UITextField *txtPhoneOrName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnAccount;  

//注册账号
- (IBAction)regAccount:(UIButton *)sender;

@end
