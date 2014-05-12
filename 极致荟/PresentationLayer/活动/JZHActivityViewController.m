//
//  JZHActivityViewController.m
//  极致荟
//
//  Created by mac on 14-4-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHActivityViewController.h"
#import "JZHPartyCell.h"
#import "MJRefresh.h"
#import "JZHActivityViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "MMLogoView.h"
#import "MMCenterTableViewCell.h"
#import "MMExampleLeftSideDrawerViewController.h"
#import "MMNavigationController.h"
#import "SGActionView.h"
#import "JZHPublishActivityViewController.h"
#import "JZHCommentsViewViewController.h"
#import "JZHAuctionCell.h"
#import "JZHBlackCardCell.h"
#import "JZHBlackCardDetailViewController.h"
#import "JZHTabbarViewController.h"

typedef NS_ENUM(NSInteger, MMCenterViewControllerSection){
    MMCenterViewControllerSectionLeftViewState,
    MMCenterViewControllerSectionLeftDrawerAnimation,
};

#pragma mark -
#pragma mark Private Interface
@interface JZHActivityViewController ()
{
    NSMutableArray *tableArray;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    
    //切换活动主题
    UIImageView *_navbarSelectView;
    
    //current type
    NSInteger activityType; //0活动 1竞拍 3黑卡会
}


@end

#pragma mark -
#pragma mark Implementation
@implementation JZHActivityViewController

- (id)init
{
    self = [super init];
    if (self) {
        [self setRestorationIdentifier:@"MMExampleCenterControllerRestorationKey"];
    }
    return self;
}

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
    [super viewDidLoad];
    //1.注册重用 Cell
    //  1.1注册活动cell
    [self.activityTableView registerClass:[JZHPartyCell class] forCellReuseIdentifier:@"activityPartyCell"];
    //  1.2注册竞拍cell
    [self.activityTableView registerClass:[JZHAuctionCell class] forCellReuseIdentifier:@"auctionCell"];
    //  1.3注册黑卡会cell
    [self.activityTableView registerClass:[JZHBlackCardCell class] forCellReuseIdentifier:@"blackCardCell"];
    
    //2设置导航
    [self setNavigation];
    
    // 3.集成刷新控件
    // 3.1.下拉刷新
    [self addHeader];
    
    // 3.2.上拉加载更多
    [self addFooter];
    
    
    //设置
    UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
    UITapGestureRecognizer * twoFingerDoubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerDoubleTap:)];
    [twoFingerDoubleTap setNumberOfTapsRequired:2];
    [twoFingerDoubleTap setNumberOfTouchesRequired:2];
    [self.view addGestureRecognizer:twoFingerDoubleTap];

    
    if(OSVersionIsAtLeastiOS7>=7.0){
        UIColor * barColor = [UIColor
                              colorWithRed:247.0/255.0
                              green:249.0/255.0
                              blue:250.0/255.0
                              alpha:1.0];
        [self.navigationController.navigationBar setBarTintColor:barColor];
    }
    else {
        UIColor * barColor = [UIColor
                              colorWithRed:78.0/255.0
                              green:156.0/255.0
                              blue:206.0/255.0
                              alpha:1.0];
        [self.navigationController.navigationBar setTintColor:barColor];
    }
    
    
//    MMLogoView * logo = [[MMLogoView alloc] initWithFrame:CGRectMake(0, 0, 29, 31)];
//    [self.navigationItem setTitleView:logo];
//    [self.navigationController.view.layer setCornerRadius:10.0f];
    
    
    UIView *backView = [[UIView alloc] init];
    [backView setBackgroundColor:[UIColor colorWithRed:208.0/255.0
                                                 green:208.0/255.0
                                                  blue:208.0/255.0
                                                 alpha:1.0]];
    [self.activityTableView setBackgroundView:backView];
    
    
    //切换主题下拉筐
   // [self createTopicView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.activityTableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

#pragma mark ---导航----
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//导航条设置
-(void)setNavigation
{
    //设置导航视图title
//    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
//    [titleButton setFrame:CGRectMake(0, 0, 50, 44)];
//    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
//    //[titleButton addTarget:self action:@selector(dropDown:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [titleButton setTitle:@"聚会" forState:UIControlStateNormal];
//    UIImageView *downPointer = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pointer_donw.png"]];
//    downPointer.contentMode = UIViewContentModeScaleAspectFit;
//    [downPointer setFrame:CGRectMake(50, 0, 9, 44)];
//    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 59, 44)];
//    [titleView addSubview:titleButton];
//    [titleView addSubview:downPointer];
//    self.navigationItem.titleView= titleView;
    
    self.navigationItem.titleView = _titleView;
    [_popoverBg setImage:[[UIImage imageNamed:@"popover_background.png"]stretchableImageWithLeftCapWidth:10 topCapHeight:30]];
    
    [_popoverView setCenter:CGPointMake(160, 44+50+17)];
    
    
    //设置右侧导航按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [rightButton setTitle:@"发活动" forState:UIControlStateNormal];
    [rightButton setTitle:@"发活动" forState:UIControlStateHighlighted];
    
    [rightButton addTarget:self action:@selector(rightBarButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    //设置左侧按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [leftButton addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"leftbar_item_bg.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}
//返回
-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --集成刷新加载更多功能---
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
- (void)addFooter
{
    __unsafe_unretained JZHActivityViewController *vc = self;
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.activityTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 增加5条假数据
        for (int i = 0; i<5; i++) {
            int random = arc4random_uniform(1000000);
            [vc->tableArray addObject:[NSString stringWithFormat:@"随机数据---%d", random]];
        }
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [vc performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    _footer = footer;
}

- (void)addHeader
{
    __unsafe_unretained JZHActivityViewController *vc = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.activityTableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 进入刷新状态就会回调这个Block
        
        // 增加5条假数据
        for (int i = 0; i<5; i++) {
            int random = arc4random_uniform(1000000);
            [vc->tableArray insertObject:[NSString stringWithFormat:@"随机数据---%d", random] atIndex:0];
        }
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        [vc performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        // 刷新完毕就会回调这个Block
        NSLog(@"%@----刷新完毕", refreshView.class);
    };
    header.refreshStateChangeBlock = ^(MJRefreshBaseView *refreshView, MJRefreshState state) {
        // 控件的刷新状态切换了就会调用这个block
        switch (state) {
            case MJRefreshStateNormal:
                NSLog(@"%@----切换到：普通状态", refreshView.class);
                break;
                
            case MJRefreshStatePulling:
                NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
                break;
                
            case MJRefreshStateRefreshing:
                NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
                break;
            default:
                break;
        }
    };
    [header beginRefreshing];
    _header = header;
}

#pragma mark --UITableViewDataSource methods-
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
    //return [tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (activityType == 0) {
        JZHPartyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"activityPartyCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.partyDiscussButton addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (activityType == 1){
        JZHAuctionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"auctionCell" forIndexPath:indexPath];
        return cell;
    }else if (activityType == 2){
        JZHBlackCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"blackCardCell" forIndexPath:indexPath];
        return cell;
    }
    return nil;
}

#pragma mark --UITableViewDelegate methods-
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%d",activityType);
    if (activityType == 0) {
        
    }else if (activityType == 1){
        
    }else if (activityType == 2){
        JZHBlackCardDetailViewController *blackCardDetail = [[JZHBlackCardDetailViewController alloc] init];
        
        
        [[JZHTabbarViewController shareInstance] hideTabBar2];
        
        NSLog(@"tabbarClass:%@",[self.tabBarController class
                     ]);
       [self.navigationController pushViewController:blackCardDetail animated:YES];
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (activityType == 0) {
        return 358;
    }else if (activityType == 1){
        return 92;
    }else if (activityType == 2){
        return 107;
    }
    return 0;
}

#pragma mark --评论
- (void)commentAction:(UIView *)sender{
    JZHPartyCell *partyCell = nil;
    do {
        sender = [sender superview];
    } while (![[sender superview] isKindOfClass:[JZHPartyCell class]]);
    sender = [sender superview];
    partyCell = (JZHPartyCell *)sender;
    
    
    NSArray *visibleCells = [self.activityTableView  visibleCells];
    for (JZHPartyCell *tmpCell in visibleCells) {
        if (partyCell == tmpCell) {
            //1.取得模型值
            //...
            //2.进行跳转
            JZHCommentsViewViewController *commentsVC = [[JZHCommentsViewViewController alloc] init];
            [self.navigationController pushViewController:commentsVC animated:YES];
        }
    }
}


-(void)contentSizeDidChange:(NSString *)size{
    [self.activityTableView reloadData];
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)rightBarButtonPress:(id)sender{
    NSLog(@"发活动");
    [SGActionView showGridMenuWithItemTitles:@[ @"自定义", @"聚餐", @"约会", @"旅游",
                                           @"会议", @"运动", @"购物", @"K歌",@"看电影"]
                                 images:@[ [UIImage imageNamed:@"facebook"],
                                           [UIImage imageNamed:@"twitter"],
                                           [UIImage imageNamed:@"googleplus"],
                                           [UIImage imageNamed:@"linkedin"],
                                           [UIImage imageNamed:@"weibo"],
                                           [UIImage imageNamed:@"wechat"],
                                           [UIImage imageNamed:@"pocket"],
                                           [UIImage imageNamed:@"dropbox"],
                                           [UIImage imageNamed:@"dropbox"]]
    
                         selectedHandle:^(NSInteger index){
                             NSLog(@"llll%d",index);
                             JZHPublishActivityViewController *publishVC = [[JZHPublishActivityViewController alloc] init];
                             [self.navigationController pushViewController:publishVC animated:YES];
                            }];
}

-(void)doubleTap:(UITapGestureRecognizer*)gesture{
    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideLeft completion:nil];
}

-(void)twoFingerDoubleTap:(UITapGestureRecognizer*)gesture{
    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideRight completion:nil];
}

#pragma mark --切换其他－
- (void)createTopicView{
    if (!_navbarSelectView) {
        _navbarSelectView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"activity_select_bg.png"]];
        _navbarSelectView.frame = CGRectMake(0, 0, 125, 175);
        _navbarSelectView.center = CGPointMake(160, 49+64+40);
        
        
        UIButton *buttonJingPai = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonJingPai.frame = CGRectMake(0, 15, 125, 50);
        [buttonJingPai setTitle:@"竞拍" forState:UIControlStateNormal];
        [_navbarSelectView addSubview:buttonJingPai];
       // [buttonJingPai addTarget:self action:@selector(toOtherType:) forControlEvents:UIControlEventTouchUpInside];
        buttonJingPai.tag = 10000;
        buttonJingPai.backgroundColor = [UIColor redColor];
        
        
        UIButton *buttonJuhui = [[UIButton alloc] initWithFrame:CGRectMake(0, 15+50, 125, 50)];
        [buttonJuhui setTitle:@"聚会" forState:UIControlStateNormal];
        [_navbarSelectView addSubview:buttonJuhui];
       // [buttonJuhui addTarget:self action:@selector(toOtherType:) forControlEvents:UIControlEventTouchUpInside];
        buttonJuhui.tag = 10001;
        
        UIButton *buttonHeikaHui = [[UIButton alloc] initWithFrame:CGRectMake(0, 15+50+50, 125, 50)];
        [buttonHeikaHui setTitle:@"黑卡会" forState:UIControlStateNormal];
        [_navbarSelectView addSubview:buttonHeikaHui];
       // [buttonHeikaHui addTarget:self action:@selector(toOtherType:) forControlEvents:UIControlEventTouchUpInside];
        buttonHeikaHui.tag = 10002;
        
        
        //[self.view addSubview:_navbarSelectView];
        [self.navigationController.view addSubview:_navbarSelectView];
        [self.navigationController.view bringSubviewToFront:_navbarSelectView];
    }
    _navbarSelectView.alpha = 0;
}


- (IBAction)dropDown:(UIButton *)sender {
    //旋转三角尖
    if ([sender isSelected]) {
        [sender setSelected:NO];
        CABasicAnimation *spinAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        [spinAnimation setFromValue:[NSNumber numberWithFloat:-M_PI]];
        [spinAnimation setToValue:[NSNumber numberWithDouble:0]];
        [spinAnimation setDelegate:self];
        [spinAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [spinAnimation setDuration:0.5];
        [_titleArrow.layer addAnimation:spinAnimation forKey:@"spin"];
        [_titleArrow.layer setTransform:CATransform3DMakeRotation(0, 0, 0, 1)];
    }else{
        [sender setSelected:YES];
        CABasicAnimation *spinAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        [spinAnimation setFromValue:[NSNumber numberWithFloat:0]];
        [spinAnimation setToValue:[NSNumber numberWithDouble:-M_PI]];
        [spinAnimation setDelegate:self];
        [spinAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        [spinAnimation setDuration:0.3];
        [_titleArrow.layer addAnimation:spinAnimation forKey:@"spin"];
        [_titleArrow.layer setTransform:CATransform3DMakeRotation(-M_PI, 0, 0, 1)];
    }
    
    //弹出下拉菜单
    if (_popoverView.superview == self.navigationController.view) {
        CATransition *animation = [CATransition  animation];
        animation.delegate = self;
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromTop;
        [_popoverView setAlpha:0.0f];
        [_popoverView.layer addAnimation:animation forKey:@"DropDown"];
        [_popoverView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
        
        
        
    }else
    {
        CATransition *animation = [CATransition  animation];
        animation.delegate = self;
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromBottom;
        [_popoverView setAlpha:1.0f];
        [_popoverView.layer addAnimation:animation forKey:@"DropDown"];
        //[_timePicker performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
        
        
        
        
        [self.navigationController.view addSubview:_popoverView];
    }
}


#pragma mark --动画title view
- (void)titleViewAnimation{
        [_titleTapButton setSelected:NO];
        CABasicAnimation *spinAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        [spinAnimation setFromValue:[NSNumber numberWithFloat:-M_PI]];
        [spinAnimation setToValue:[NSNumber numberWithDouble:0]];
        [spinAnimation setDelegate:self];
        [spinAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [spinAnimation setDuration:0.5];
        [_titleArrow.layer addAnimation:spinAnimation forKey:@"spin"];
        [_titleArrow.layer setTransform:CATransform3DMakeRotation(0, 0, 0, 1)];
    
    
    
    //弹出下拉菜单
    if (_popoverView.superview == self.navigationController.view) {
        CATransition *animation = [CATransition  animation];
        animation.delegate = self;
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromTop;
        [_popoverView setAlpha:0.0f];
        [_popoverView.layer addAnimation:animation forKey:@"DropDown"];
        [_popoverView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
        
        
        
    }else
    {
        CATransition *animation = [CATransition  animation];
        animation.delegate = self;
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromBottom;
        [_popoverView setAlpha:1.0f];
        [_popoverView.layer addAnimation:animation forKey:@"DropDown"];
        //[_timePicker performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
        
        
        [self.navigationController.view addSubview:_popoverView];
    }
}
- (IBAction)jingPaiAction:(UIButton *)sender {
    NSLog(@"竞拍数据");
    
    [self  titleViewAnimation];
    activityType = 1;
    
    [_header beginRefreshing];
    [self.activityTableView reloadData];
}

- (IBAction)heikahuiAction:(UIButton *)sender {
    NSLog(@"黑卡会数据");
    [self  titleViewAnimation];
    activityType = 2;
    [_header beginRefreshing];
    [self.activityTableView reloadData];
}

- (IBAction)juhuiAction:(UIButton *)sender {
    NSLog(@"聚会数据");
    [self  titleViewAnimation];
    activityType = 0;
    [_header beginRefreshing];
    [self.activityTableView reloadData];
}
@end
