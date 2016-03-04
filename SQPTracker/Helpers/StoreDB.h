//
//  StoreDB.h
//  SQPTracker
//
//  Created by MAbed on 3/2/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EGODatabase/EGODatabase.h>
#import "ProductModel.h"

@interface StoreDB : NSObject
+(NSMutableArray*)getUserChoices;
+(void)saveUserChoices:(NSMutableArray*)selectedProductsIDs;

+(void)addToFavorites:(ProductModel*)item;
+(NSMutableArray*)getUserFavorites;
+(void)removeFromFavorites:(ProductModel*)item;
+(ProductModel*)getItemFromFavoritesWithID:(NSString*)itemID;
@end
