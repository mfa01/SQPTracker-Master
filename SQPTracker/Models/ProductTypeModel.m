//
//  ProductTypeModel.m
//  SQPTracker
//
//  Created by MAbed on 3/1/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import "ProductTypeModel.h"

@implementation ProductTypeModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"type_id",
                                                       @"label_plural":@"type_label_plural",
                                                       @"label_singular":@"type_label_singular",
                                                       @"link":@"type_link"
                                                       }];
}
@end
