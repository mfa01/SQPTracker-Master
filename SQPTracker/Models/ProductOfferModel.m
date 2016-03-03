//
//  ProductOfferModel.m
//  SQPTracker
//
//  Created by MAbed on 3/3/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import "ProductOfferModel.h"
#import "NSDate+TimeAgo.h"
@implementation ProductOfferModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"price":@"offer_price",
                                                       @"currency":@"offer_currency",
                                                       @"date_inserted":@"offer_date_inserted"
                                                       }];
}
-(NSString*)getPriceWithCurrency
{
    return [NSString stringWithFormat:@"%ld %@",(long)_offer_price,_offer_currency];
}

-(NSString*)getTimeAgo
{
    NSDate*date=[self NSDateFromNSString:_offer_date_inserted];
    
//    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:100000000];
    NSString *ago = [date timeAgo];
    NSLog(@"Output is: \"%@\"", ago);
    return ago;
}
- (NSDate *)NSDateFromNSString:(NSString*)string {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter dateFromString:string];
}
@end
