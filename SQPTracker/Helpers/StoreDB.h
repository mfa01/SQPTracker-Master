//
//  StoreDB.h
//  SQPTracker
//
//  Created by MAbed on 3/2/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EGODatabase/EGODatabase.h>

@interface StoreDB : NSObject
+(NSMutableArray*)getUserChoices;
+(void)saveUserChoices:(NSMutableArray*)selectedProductsIDs;

+(void)saveUserFavorites:(NSMutableArray*)selectedProductsIDs;
+(NSMutableArray*)getUserFavorites;
@end
