//
//  OfferPriceCell.h
//  SQPTracker
//
//  Created by MAbed on 3/3/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOfferModel.h"
@interface OfferPriceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
-(void)setUpWithItem:(ProductOfferModel*)offer;
@end
