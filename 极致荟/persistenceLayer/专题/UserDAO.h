//
//  UserDAO.h
//  极致荟
//
//  Created by mac on 14-4-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "UserDAODelegate.h"

#define HOST_PATH @"/service/mynotes/webservice.php"
#define HOST_NAME @"iosbook1.com"

@interface UserDAO : NSObject

@property (strong,nonatomic) User *user;
@property (weak,nonatomic) id<UserDAODelegate> delegate;

- (void)registerUser:(User *)user;
- (void)loginUser:(User *)user;
- (void)logoutUser:(User *)user;

@end
