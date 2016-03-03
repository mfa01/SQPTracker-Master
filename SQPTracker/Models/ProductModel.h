//
//  ProductModel.h
//  SQPTracker
//
//  Created by MAbed on 3/2/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@interface ProductModel : JSONModel
@property (nonatomic, strong) NSString *product_id;
@property (nonatomic, strong) NSString *product_label;
@property (nonatomic, strong) NSDictionary *product_images;
@property (nonatomic, assign) NSInteger product_offer_price;
@property (nonatomic, strong) NSString *product_currency;

-(NSURL*)getImageForProductsDashboard;
-(NSString*)getPriceWithCurrency;
-(NSURL*)getImageForProductsDetails;
@end
