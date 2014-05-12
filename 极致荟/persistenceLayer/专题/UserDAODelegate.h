//
//  UserDAODelegate.h
//  极致荟
//
//  Created by mac on 14-4-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@protocol UserDAODelegate <NSObject>

- (void)registerFinished;
- (void)registerFailed:(NSError *)error;

- (void)loginFinished:(User*)user;
- (void)loginFailed:(NSError *)error;

@end
