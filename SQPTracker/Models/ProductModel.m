//
//  ProductModel.m
//  SQPTracker
//
//  Created by MAbed on 3/2/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"product_id",
                                                       @"label":@"product_label",
                                                       @"images":@"product_images",
                                                       @"offer_price":@"product_offer_price",
                                                       @"currency":@"product_currency"
                                                       }];
}
-(NSURL*)getImageForProductsDashboard
{
    NSArray* dic=[_product_images valueForKey:@"L"];
    return [NSURL URLWithString:[dic lastObject]];
}
-(NSURL*)getImageForProductsDetails
{
    NSArray* dic=[_product_images valueForKey:@"XL"];
    return [NSURL URLWithString:[dic lastObject]];
}
-(NSString*)getPriceWithCurrency
{
    return [NSString stringWithFormat:@"%ld %@",(long)_product_offer_price,_product_currency];
}
@end
