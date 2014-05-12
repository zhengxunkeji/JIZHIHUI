//
//  JZH ContactsViewController.m
//  极致荟
//
//  Created by hetao on 14-5-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JZHContactsViewController.h"
#import "pinyin.h"
@interface JZHContactsViewController ()
{
    NSArray *name;
    NSMutableDictionary *pinyin;
    NSMutableArray *namepinyin;

}
@end

@implementation JZHContactsViewController

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
    [self jiequpinyin];
    self.navigationItem.title=@"通讯录";
}

- (void)jiequpinyin
{
    namepinyin=[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    NSString *hanyu = @"测试";
    for (int i = 0; i < [hanyu length]; i++)
    {
        printf("%c", pinyinFirstLetter([hanyu characterAtIndex:i]));
    }
    name=[[NSArray alloc] initWithObjects:@"崔姐",@"阿道夫",@"恶风",@"菲菲",@"胡个个",@"欧赔",@"没回家的",@"妻儿",@"水电费",@"影",@"深入到",@"地方", nil];
    pinyin=[[NSMutableDictionary alloc]init];
    for(NSString *xin in name )
    {
        char c=pinyinFirstLetter([xin characterAtIndex:0]);
        NSLog(@"%d",c);
        NSString *str=[NSString stringWithFormat:@"%c",c] ;
        if(![pinyin objectForKey:str])
//            if(namepinyin.count!=0 && namepinyin[0])
        {   [namepinyin addObject:str];
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            [arr addObject:xin];
            [pinyin setObject:arr forKey:str];
        }else
        {
            NSMutableArray *arr2=[pinyin objectForKey:str];
            [arr2 addObject:xin];
            [pinyin setObject:arr2 forKey:str];
        }
        
    }
    [self paixu];

}


///字母排序
- (void)paixu
{
    for(int i=0;i<namepinyin.count-1;i++)
    {
        
        for(int j=0;j<namepinyin.count-i-1;j++)
        {
            NSString* c1=namepinyin[j] ;
            NSString* c2=namepinyin[j+1] ;
            if([c2 characterAtIndex:0] <[c1 characterAtIndex:0])
            {

                [namepinyin exchangeObjectAtIndex:j withObjectAtIndex:j+1];
        
              
            }
        }
        
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ---tableview代理---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [(NSMutableArray *)[pinyin objectForKey:namepinyin[section]] count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return namepinyin.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return namepinyin[section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"adf";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell=[self addViewCell:cell indexpath:indexPath];
    }
   
    return cell;
}

///向Cell添加控件

- (UITableViewCell *)addViewCell:(UITableViewCell *)cell indexpath:(NSIndexPath *)index
{
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(14, 10, 40, 40)];
    [image.layer setCornerRadius:6 ];
    [image.layer setMasksToBounds:YES];
    [image setImage:[UIImage imageNamed:@"详细资料照片"]];
    [cell.contentView addSubview:image];
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(70, 16, 200, 21)];
    [lable setText:[(NSMutableArray *)[pinyin objectForKey:namepinyin[index.section]] objectAtIndex:index.row]];
    [lable setFont:[UIFont systemFontOfSize:14]];
    [cell.contentView addSubview:lable];
    return cell;
}
@end
