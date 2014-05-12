//
//  JZHCommentsViewViewController.m
//  极致荟
//
//  Created by mac on 14-4-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHCommentsViewViewController.h"
#import "JZHCommentsCell.h"

@interface JZHCommentsViewViewController ()
@property (weak, nonatomic) IBOutlet UITableView *commensTableView;

@end

@implementation JZHCommentsViewViewController

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
    //1.注册重用Cell
    [self.commensTableView registerClass:[JZHCommentsCell class] forCellReuseIdentifier:@"commentsCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JZHCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentsCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
