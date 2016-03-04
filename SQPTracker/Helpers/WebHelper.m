//
//  WebHelper.m
//  SQPTracker
//
//  Created by MAbed on 3/1/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import "WebHelper.h"
#import <STHTTPRequest/STHTTPRequest.h>
#import "ConfigVars.h"
#import "ProductTypeModel.h"
#import "ProductModel.h"
#import "ProductOfferModel.h"
#import "User.h"
#import "CartModel.h"
@implementation WebHelper
+(void)getProductsTypesWithPage:(int)page AndCompletionHandler:(void (^)(NSArray*))completionHandler FaildCompletionHandler:(void (^)(NSString*))faildCompletionHandler
{
    NSMutableArray* items=[[NSMutableArray alloc]init];
    STHTTPRequest *r = [STHTTPRequest requestWithURLString:[NSString stringWithFormat:@"%@/%@/%@",WEB_MAIN_URL,WEB_Version,WEB_Product_Type]];


    r.GETDictionary=@{
                      @"page":@(page),
                      @"language":@"en",
                      @"format":@"json",
                      @"app_id":App_ID,
                      @"app_secret":Client_Secret
                      };
    
    r.completionBlock = ^(NSDictionary *headers, NSString *body) {
        //NSLog(body);
        NSError* err = nil;
        NSData *objectData = [body dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&err];
        if(err)
        {
            faildCompletionHandler(err.localizedDescription);
        }
        else
        {
            NSArray* productsArr=[json valueForKey:@"data"] ;
            
            for (int i=0; i<productsArr.count; i++) {
                ProductTypeModel* productType = [[ProductTypeModel alloc] initWithDictionary:productsArr[i] error:&err];
                if(err)faildCompletionHandler(err.localizedDescription);
                else [items addObject:productType];
            }
            completionHandler(items);
        }
    };
    
    r.errorBlock = ^(NSError *error) {
        faildCompletionHandler(error.localizedDescription);
    };
    [r startAsynchronous];
}

+(void)getProductsWithPage:(int)page AndTypes:(NSMutableArray*)types AndCompletionHandler:(void (^)(NSArray*))completionHandler FaildCompletionHandler:(void (^)(NSString*))faildCompletionHandler
{
    NSMutableArray* items=[[NSMutableArray alloc]init];
    STHTTPRequest *r = [STHTTPRequest requestWithURLString:[NSString stringWithFormat:@"%@/%@/%@",WEB_MAIN_URL,WEB_Version,WEB_Products]];
    
    
    NSString* strTypes=@"";
    for (int i=0; i<types.count; i++) {
        if(i==0)strTypes=types[i];
        else strTypes=[NSString stringWithFormat:@"%@,%@",strTypes,types[i]];
    }
    //NSLog(strTypes);
    
    r.GETDictionary=@{
                      @"page":@(page),
                      @"product_types":strTypes,
                      @"country":@"ae",
                      @"language":@"en",
                      @"format":@"json",
                      @"app_id":App_ID,
                      @"app_secret":Client_Secret
                      };
    
    r.completionBlock = ^(NSDictionary *headers, NSString *body) {
        //NSLog(body);
        NSError* err = nil;
        NSData *objectData = [body dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&err];
        if(err)
        {
            faildCompletionHandler(err.localizedDescription);
        }
        else
        {
            NSArray* productsArr=[[json valueForKey:@"data"] objectForKey:@"products"] ;
            
            for (int i=0; i<productsArr.count; i++) {
                ProductModel* product = [[ProductModel alloc] initWithDictionary:productsArr[i] error:&err];
                if(err)faildCompletionHandler(err.localizedDescription);
                else [items addObject:product];
            }
            completionHandler(items);
        }
    };
    
    r.errorBlock = ^(NSError *error) {
        faildCompletionHandler(error.localizedDescription);
    };
    [r startAsynchronous];
}
+(void)getProductOffersWithProductID:(NSString*)productID AndCompletionHandler:(void (^)(NSArray*))completionHandler FaildCompletionHandler:(void (^)(NSString*))faildCompletionHandler
{
    NSMutableArray* items=[[NSMutableArray alloc]init];
    STHTTPRequest *r = [STHTTPRequest requestWithURLString:[NSString stringWithFormat:@"%@/%@/%@/%@",WEB_MAIN_URL,WEB_Version,WEB_Products,productID]];
    
    r.GETDictionary=@{
                      @"show_offers":@(1),
                      @"country":@"ae",
                      @"language":@"en",
                      @"format":@"json",
                      @"app_id":App_ID,
                      @"app_secret":Client_Secret
                      };
    
    r.completionBlock = ^(NSDictionary *headers, NSString *body) {
        //NSLog(body);
        NSError* err = nil;
        NSData *objectData = [body dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&err];
        if(err)
        {
            faildCompletionHandler(err.localizedDescription);
        }
        else
        {
            NSArray* productsArr=[[json valueForKey:@"data"] objectForKey:@"offers"] ;
            
            for (int i=0; i<productsArr.count; i++) {
                ProductOfferModel* product = [[ProductOfferModel alloc] initWithDictionary:productsArr[i] error:&err];
                if(err)faildCompletionHandler(err.localizedDescription);
                else [items addObject:product];
            }
            completionHandler(items);
        }
    };
    
    r.errorBlock = ^(NSError *error) {
        faildCompletionHandler(error.localizedDescription);
    };
    [r startAsynchronous];
}

+(void)authorizeUser
{
    NSString *authorizationURL;
    authorizationURL = [NSString stringWithFormat:
                        @"%@/%@/?redirect_uri=%@&scope=%@&client_id=%@&response_type=code",
                        WEB_MAIN_URL, WEB_Auth, WEB_Auth_Redirect, WEB_AuthScope, App_ID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authorizationURL]];
}
+(void)getAccesTokenWithCode:(NSString*)code AndCompletionHandler:(void (^)(id))completionHandler FaildCompletionHandler:(void (^)(NSString*))faildCompletionHandler
{
    STHTTPRequest *r = [STHTTPRequest requestWithURLString:[NSString stringWithFormat:@"%@/%@",WEB_MAIN_URL,WEB_AccessToken]];
    
//
    r.POSTDictionary=@{
                      @"code":code,
                      @"client_id":App_ID,
                      @"client_secret":Client_Secret,
                      @"redirect_uri":WEB_Auth_Redirect,
                      @"grant_type":@"authorization_code",
                      @"app_id":App_ID,
                      @"app_secret":Client_Secret
                      };
    
    r.completionBlock = ^(NSDictionary *headers, NSString *body) {
        //NSLog(body);
        NSError* err = nil;
        NSData *objectData = [body dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&err];
        if(err)
        {
            faildCompletionHandler(err.localizedDescription);
        }
        else
        {
            NSDictionary* dic=[json valueForKey:@"data"] ;
            User* user = [[User alloc] initWithDictionary:dic error:&err];
            [WebHelper saveUserAccessToken:user.user_access_token AndUserID:user.user_id];
            completionHandler(user);
        }
    };
//    
    r.errorBlock = ^(NSError *error) {
        faildCompletionHandler(error.localizedDescription);
    };
    [r startAsynchronous];
}
+(void)saveUserAccessToken:(NSString*)token AndUserID:(NSString*)userId
{
    [[NSUserDefaults standardUserDefaults]setObject:token forKey:Keys_UserAccessToken];
    [[NSUserDefaults standardUserDefaults]setObject:userId forKey:Keys_UserID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString*)getUserAccessToken
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:Keys_UserAccessToken];
}
+(NSString*)getUserID
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:Keys_UserID];
}


+ (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}



+(void)getUserCartWithCompletionHandler:(void (^)(id))completionHandler FaildCompletionHandler:(void (^)(NSString*))faildCompletionHandler
{
    STHTTPRequest *r = [STHTTPRequest requestWithURLString:[NSString stringWithFormat:@"%@/%@/%@",WEB_MAIN_URL,WEB_Version,WEB_CARTS]];
    r.GETDictionary=@{
                       @"language":@"en",
                       @"client_id":App_ID,
                       @"client_secret":Client_Secret,
                       @"country":@"ae",
                       @"customer_id":[WebHelper getUserID],
                       @"app_id":App_ID,
                       @"app_secret":Client_Secret,
                       @"access_token":[WebHelper getUserAccessToken]
                       };
    r.completionBlock = ^(NSDictionary *headers, NSString *body) {
        NSError* err = nil;
        NSData *objectData = [body dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&err];
        if(err)
        {
            faildCompletionHandler(err.localizedDescription);
        }
        else
        {
            NSDictionary* dic=[json valueForKey:@"data"] ;
            CartModel* cart = [[CartModel alloc] initWithDictionary:dic error:&err];
            [[NSUserDefaults standardUserDefaults]setObject:cart.cart_id forKey:Keys_UserCartID];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            NSMutableArray* items=[[NSMutableArray alloc]init];
            NSArray* productsArr=(NSArray*)cart.cart_products;
            for (int i=0; i<productsArr.count; i++) {

                ProductModel* product = [[ProductModel alloc]init];
                long long longID=[[productsArr[i] objectForKey:@"id"] longLongValue];
                NSString*str=[[NSNumber numberWithLongLong:longID] stringValue];
                product.product_id=str;
                product.product_label=[productsArr[i] objectForKey:@"label"];
                product.product_images=[[productsArr[i] objectForKey:@"selected_offer"] objectForKey:@"product_images"];
                product.product_currency=[productsArr[i] objectForKey:@"currency"];
                product.product_offer_id=[[productsArr[i] objectForKey:@"selected_offer"] objectForKey:@"id"];
                
                if(err)faildCompletionHandler(err.localizedDescription);
                else [items addObject:product];
            }
            
            completionHandler(items);
        }
    };
    //
    r.errorBlock = ^(NSError *error) {
        faildCompletionHandler(error.localizedDescription);
    };
    [r startAsynchronous];
}
+(NSString*)getCartID
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:Keys_UserCartID];
}
+(void)addProductToUserCartId:(NSString*)cartId AndProductId:(NSString*)productId AndCompletionHandler:(void (^)(bool))completionHandler FaildCompletionHandler:(void (^)(NSString*))faildCompletionHandler
{
    STHTTPRequest *r = [STHTTPRequest requestWithURLString:[NSString stringWithFormat:@"%@/%@/%@/%@/%@",WEB_MAIN_URL,WEB_Version,WEB_CARTS,cartId,WEB_OFFERS]];
    
    r.POSTDictionary=@{
                      @"language":@"en",
                      @"client_id":App_ID,
                      @"client_secret":Client_Secret,
                      @"country":@"ae",
                      @"customer_id":[WebHelper getUserID],
                      @"app_id":App_ID,
                      @"format":@"json",
                      @"offer_id":productId,
                      //@"cart_id":cartId,48127161
                      @"app_secret":Client_Secret,
                      @"quantity":@(1),
                      @"access_token":[WebHelper getUserAccessToken]
                      };
    r.completionBlock = ^(NSDictionary *headers, NSString *body) {
        //NSLog(body);
        NSError* err = nil;
        NSData *objectData = [body dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&err];
        if(err)
        {
            faildCompletionHandler(err.localizedDescription);
        }
        else
        {
            NSDictionary* dic=[json valueForKey:@"data"] ;
            if([[dic objectForKey:@"success"] boolValue])
            {
                completionHandler([[dic objectForKey:@"success"] boolValue]);
            }
        }
    };
    //
    r.errorBlock = ^(NSError *error) {
        faildCompletionHandler(error.localizedDescription);
    };
    [r startAsynchronous];
}

@end
