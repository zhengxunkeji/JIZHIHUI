//
//  JZHPublishActivityViewController.m
//  极致荟
//
//  Created by mac on 14-4-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHPublishActivityViewController.h"

@interface JZHPublishActivityViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *conentScroller;

@end

@implementation JZHPublishActivityViewController

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
    // Do any additional setup after loading the view from its nib.
    self.conentScroller.contentSize = CGSizeMake(320, 640);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
