//
//  GXViewController.h
//  CustomeTabbarDemo
//
//  Created by mac on 14-4-22.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHTabbarViewController : UITabBarController

-(void)hideTabBar2;
-(void)showTabBar2;

+ (JZHTabbarViewController *)shareInstance;

+(void)hideTabBar;
+(void)showTabBar;

@end
