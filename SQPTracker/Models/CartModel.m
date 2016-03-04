//
//  CartModel.m
//  SQPTracker
//
//  Created by MAbed on 3/4/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import "CartModel.h"

@implementation CartModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"cart_id",
                                                       @"overall_quantity":@"cart_overall_quantity",
                                                       @"products":@"cart_products",
                                                       @"update_message":@"cart_update_message"
                                                       }];
}
@end
