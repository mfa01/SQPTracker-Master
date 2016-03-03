//
//  ProductOfferModel.h
//  SQPTracker
//
//  Created by MAbed on 3/3/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@interface ProductOfferModel : JSONModel
@property (nonatomic, assign) NSInteger offer_price;
@property (nonatomic, strong) NSString *offer_currency;
@property (nonatomic, strong) NSString *offer_date_inserted;
-(NSString*)getPriceWithCurrency;
-(NSString*)getTimeAgo;
@end
