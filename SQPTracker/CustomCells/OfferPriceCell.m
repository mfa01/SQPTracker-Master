//
//  OfferPriceCell.m
//  SQPTracker
//
//  Created by MAbed on 3/3/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import "OfferPriceCell.h"

@implementation OfferPriceCell
-(void)setUpWithItem:(ProductOfferModel*)offer
{
    _lblPrice.text=[offer getPriceWithCurrency];
    _lblDate.text=[offer getTimeAgo];
}
@end
