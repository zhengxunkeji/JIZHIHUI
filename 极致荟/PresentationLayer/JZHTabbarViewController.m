//
//  GXViewController.m
//  CustomeTabbarDemo
//
//  Created by mac on 14-4-22.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHTabbarViewController.h"
#import "JZHCustomButton.h"

@interface JZHTabbarViewController ()
{
    UIImageView *_tabBarView; //自定义的覆盖原先的tarbar的控件
    JZHCustomButton *_previousBtn; //记录前一次选中的按钮
    CGRect _tabbarFrameWhenShow; //记录当前tabbar的frame
    UILabel *lab;
    
}
@end

@implementation JZHTabbarViewController

static JZHTabbarViewController *singleInstance;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

+ (JZHTabbarViewController *)shareInstance
{
    if (singleInstance == nil) {
        singleInstance = [[JZHTabbarViewController alloc] init];
    }
    
    return singleInstance;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
	// Do any additional setup after loading the view.
    self.tabBar.hidden = YES; //隐藏原先的tabBar
    CGFloat tabBarViewY = self.view.frame.size.height - 49;
    _tabBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, tabBarViewY, 320, 49)];
    _tabBarView.userInteractionEnabled = YES; //这一步一定要设置为YES，否则不能和用户交互
    _tabBarView.image = [UIImage imageNamed:@"system_tabbar_bg.png"];
    [self.view addSubview:_tabBarView];
    _tabbarFrameWhenShow = _tabBarView.frame;
    // 下面的方法是调用自定义的生成按钮的方法
    [self creatButtonWithNormalName:@"tab0.png"andSelectName:@"tab00.png"andTitle:@"专题"andIndex:0];
    [self creatButtonWithNormalName:@"tab1.png"andSelectName:@"tab11.png"andTitle:@"活动"andIndex:1];
    [self creatButtonWithNormalName:@"tab2.png"andSelectName:@"tab22.png"andTitle:@"朋友圈"andIndex:2];
    [self creatButtonWithNormalName:@"tab3.png"andSelectName:@"tab33.png"andTitle:@"消息"andIndex:3];
    [self creatButtonWithNormalName:@"tab4.png"andSelectName:@"tab44.png"andTitle:@"我"andIndex:4];
    JZHCustomButton *btn = _tabBarView.subviews[0];
    [self changeViewController:btn]; //自定义的控件中的按钮被点击了调用的方法，默认进入界面就选中第一个按钮
    lab=[[UILabel alloc]initWithFrame:CGRectMake(20, 48, 24, 1)];
    [lab setBackgroundColor:[UIColor whiteColor]];
    [_tabBarView addSubview:lab];

}

#pragma mark 创建一个按钮
 - (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index
 {
    /*
            GXCustomButton是自定义的一个继承自UIButton的类，自定义该类的目的是因为系统自带的Button可以设置image和title属性，但是默认的image是在title的左边，若想想上面图片中那样，将image放在title的上面，就需要自定义Button，设置一些东西。（具体GXCustomButton设置了什么，放在下面讲）
           */
    JZHCustomButton *button = [JZHCustomButton buttonWithType:UIButtonTypeCustom];
    button.tag = index;

    CGFloat buttonW = _tabBarView.frame.size.width / 5;
    CGFloat buttonH = _tabBarView.frame.size.height;
    button.frame = CGRectMake(64 *index, 0, buttonW, buttonH);

    [button setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selected] forState:UIControlStateDisabled];
//    [button setTitle:title forState:UIControlStateNormal];

    [button addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];

    button.imageView.contentMode = UIViewContentModeCenter; // 让图片在按钮内居中
//    button.titleLabel.textAlignment = NSTextAlignmentCenter; // 让标题在按钮内居中
//    button.font = [UIFont systemFontOfSize:12]; // 设置标题的字体大小
    
    [_tabBarView addSubview:button];
}

#pragma mark 按钮被点击时调用
- (void)changeViewController:(JZHCustomButton *)sender
{
    self.selectedIndex = sender.tag; //切换不同控制器的界面
    sender.enabled = NO;
    
    [UIView animateWithDuration:0.1 animations:^{
        [lab setFrame:CGRectMake((sender.tag+1)*64-44, 48, 24, 1)];
    }];
    if (_previousBtn != sender) {
    
            _previousBtn.enabled = YES;
     
    }
      _previousBtn = sender;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -显示隐藏tabbar
- (void)showTabBar2{
    [UIView animateWithDuration:.3 animations:^(){
        _tabBarView.frame = _tabbarFrameWhenShow;
    }];
}

- (void)hideTabBar2{
    [UIView animateWithDuration:.3 animations:^(){
        _tabBarView.frame = CGRectMake(_tabbarFrameWhenShow.origin.x, _tabbarFrameWhenShow.origin.y+49, _tabbarFrameWhenShow.size.width, _tabbarFrameWhenShow.size.height);
    }];
}

+ (void)showTabBar{
    [self showTabBar];
}

+ (void)hideTabBar{
    [self hideTabBar];
}

@end
