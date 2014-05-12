//
//  JZHRegisterViewController.m
//  极致荟
//
//  Created by mac on 14-4-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHRegisterViewController.h"

@interface JZHRegisterViewController ()
{
    //验证码
    UITextField *txtIdentifier;
    UIButton *btnIdentifier;
}
@end

@implementation JZHRegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    [self setNavigation];
    
    //创建手机号注册界面
    [self createRegisterViewByPhone];
    
    //键盘
    [self addKeyBoardNotification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---导航----
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//导航条设置
-(void)setNavigation
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title"] forBarMetrics:UIBarMetricsDefault];
    //设置左按钮
    self.navigationController.navigationBar.tintColor=[UIColor orangeColor];
    UIButton *backBut=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 54, 32)];
    [backBut setBackgroundImage:[UIImage imageNamed:@"lab_btn_bac_1k@2x"] forState:UIControlStateNormal];
    [backBut setImage:[UIImage imageNamed:@"lab_btn_bac_1k@2x"] forState:UIControlStateHighlighted];
    [backBut setTitle:@"返回" forState:UIControlStateNormal];
    [backBut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [backBut.titleLabel setFont:[UIFont systemFontOfSize:14]];
    UIBarButtonItem *backBarButton=[[UIBarButtonItem alloc]initWithCustomView:backBut];
    [self.navigationItem setLeftBarButtonItem:backBarButton];
    //设置导航视图title
    //self.navigationItem.titleView=[DealTitle dealTitle:@"登陆"];
}
//返回
-(void)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark --界面逻辑
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//创建手机注册界面
- (void)createRegisterViewByPhone{
    if (txtIdentifier == nil) {
        txtIdentifier = [[UITextField alloc] init];
        txtIdentifier.background = [UIImage imageNamed:@"login_txt_bg.png"];
        [txtIdentifier setFrame:CGRectMake(self.txtConfirmPassword.frame.origin.x, self.txtConfirmPassword.frame.origin.y+self.txtConfirmPassword.frame.size.height+14, 127, 0)];
        txtIdentifier.delegate = self;
        [self.view addSubview:txtIdentifier];
        
    }
    
    
    
    
    if (btnIdentifier.superview == nil) {
        btnIdentifier = [[UIButton alloc] init];
        btnIdentifier.backgroundColor = [UIColor redColor];
        [btnIdentifier setFrame:CGRectMake(txtIdentifier.frame.origin.x+127, txtIdentifier.frame.origin.y, 124, 0)];
        [btnIdentifier setTitle:@"点击获取验证码" forState:UIControlStateNormal];
        btnIdentifier.titleLabel.font = [UIFont systemFontOfSize:14];
        [btnIdentifier setBackgroundColor:[UIColor blackColor]];
        btnIdentifier.alpha = 0;
        [self.view addSubview:btnIdentifier];
    }
}

//切换注册方式
- (IBAction)regByPhone:(UIButton *)sender {
    self.txtPhoneOrName.placeholder = @"输入手机号";
    self.txtPassword.placeholder = @"输入密码";
    self.txtConfirmPassword.placeholder = @"确认密码";
    
    [self.btnPhoneReg setBackgroundImage:[UIImage imageNamed:@"login_btn_bg"] forState:UIControlStateNormal];
    [self.btnNameReg setBackgroundImage:[UIImage imageNamed:@"login_txt_bg"] forState:UIControlStateNormal];
    
    if (!isPhone) {//切换手机号界面
        [UIView animateWithDuration:0.2 animations:^(){
            txtIdentifier.frame = CGRectMake(self.txtConfirmPassword.frame.origin.x, self.txtConfirmPassword.frame.origin.y+self.txtConfirmPassword.frame.size.height+14, 127, 34);
            
            btnIdentifier.frame = CGRectMake(txtIdentifier.frame.origin.x+127, txtIdentifier.frame.origin.y, 124, 34);
            btnIdentifier.alpha = 1;
            self.btnAccount.frame = CGRectMake(self.btnAccount.frame.origin.x, self.btnAccount.frame.origin.y + 48, self.btnAccount.frame.size.width, self.btnAccount.frame.size.height);
        }];
    }
    
    isPhone = YES;
}

- (IBAction)regByName:(UIButton *)sender {
    self.txtPhoneOrName.placeholder = @"输入用户名";
    self.txtPassword.placeholder = @"输入密码";
    self.txtConfirmPassword.placeholder = @"确认密码";
    
    
    [self.btnPhoneReg setBackgroundImage:[UIImage imageNamed:@"login_txt_bg"] forState:UIControlStateNormal];
    [self.btnNameReg setBackgroundImage:[UIImage imageNamed:@"login_btn_bg"] forState:UIControlStateNormal];
    
    if (isPhone) {//切换用户名界面
        [UIView animateWithDuration:0.2 animations:^(){
            txtIdentifier.frame = CGRectMake(self.txtConfirmPassword.frame.origin.x, self.txtConfirmPassword.frame.origin.y+self.txtConfirmPassword.frame.size.height+14, 127, 0);
            
            btnIdentifier.frame = CGRectMake(txtIdentifier.frame.origin.x+127, txtIdentifier.frame.origin.y, 124, 0);
            btnIdentifier.alpha = 0;
            
            self.btnAccount.frame = CGRectMake(self.btnAccount.frame.origin.x, self.btnAccount.frame.origin.y - 48, self.btnAccount.frame.size.width, self.btnAccount.frame.size.height);
        }];
    }
    
    isPhone = NO;
}
//注册账号
- (IBAction)regAccount:(UIButton *)sender {
}

//消除键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark --键盘事件
- (void)addKeyBoardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (version >= 5.0) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
    }
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    // Get the origin of the keyboard when it's displayed.
//    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
//    CGRect keyboardRect = [aValue CGRectValue];

    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSTimeInterval animationDuration;
    
    [animationDurationValue getValue:&animationDuration];
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    self.view.frame = CGRectMake(0.0f, -100, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}





- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary* userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSTimeInterval animationDuration;
    
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    self.view.frame = CGRectMake(0.0f, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
    
}

@end
