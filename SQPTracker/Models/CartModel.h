//
//  CartModel.h
//  SQPTracker
//
//  Created by MAbed on 3/4/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"
@interface CartModel : JSONModel
@property (nonatomic, strong) NSString *cart_id;
@property (nonatomic, assign) NSInteger cart_overall_quantity;
@property (nonatomic, strong) NSDictionary *cart_products;
@property (nonatomic, strong) NSString *cart_update_message;
@end
