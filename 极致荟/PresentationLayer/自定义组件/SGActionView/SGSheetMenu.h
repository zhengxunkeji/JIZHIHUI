//
//  SGSheetMenu.h
//  SGActionView
//
//  Created by Sagi on 13-9-6.
//  Copyright (c) 2013年 AzureLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGBaseMenu.h"

@interface SGSheetMenu : SGBaseMenu

- (id)initWithItemTitles:(NSArray *)itemTitles;

- (id)initWithItemTitles:(NSArray *)itemTitles subTitles:(NSArray *)subTitles;

@property (nonatomic, assign) NSUInteger selectedItemIndex;

- (void)triggerSelectedAction:(void(^)(NSInteger))actionHandle;

@end
