//
//  User.m
//  SQPTracker
//
//  Created by MAbed on 3/3/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import "User.h"

@implementation User
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"customer_id":@"user_id",
                                                       @"access_token":@"user_access_token"
                                                       }];
}
@end
