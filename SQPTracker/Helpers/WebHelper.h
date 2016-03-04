//
//  WebHelper.h
//  SQPTracker
//
//  Created by MAbed on 3/1/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WebHelper : NSObject
+(void)getProductsTypesWithPage:(int)page AndCompletionHandler:(void (^)(NSArray*items))completionHandler FaildCompletionHandler:(void (^)(NSString*error))faildCompletionHandler;
+(void)getProductsWithPage:(int)page AndTypes:(NSMutableArray*)types AndCompletionHandler:(void (^)(NSArray*items))completionHandler FaildCompletionHandler:(void (^)(NSString*error))faildCompletionHandler;

+(void)getProductOffersWithProductID:(NSString*)productID AndCompletionHandler:(void (^)(NSArray*items))completionHandler FaildCompletionHandler:(void (^)(NSString*error))faildCompletionHandler;

+(void)authorizeUser;
+(void)getAccesTokenWithCode:(NSString*)code AndCompletionHandler:(void (^)(id user))completionHandler FaildCompletionHandler:(void (^)(NSString* error))faildCompletionHandler;
+(NSString*)getUserAccessToken;
+(NSString*)getUserID;
+ (NSDictionary *)parseQueryString:(NSString *)query;


+(void)getUserCartWithCompletionHandler:(void (^)(id cart))completionHandler FaildCompletionHandler:(void (^)(NSString*error))faildCompletionHandler;
+(void)addProductToUserCartId:(NSString*)cartId AndProductId:(NSString*)productId AndCompletionHandler:(void (^)(bool success))completionHandler FaildCompletionHandler:(void (^)(NSString*error))faildCompletionHandler;
+(NSString*)getCartID;
@end
