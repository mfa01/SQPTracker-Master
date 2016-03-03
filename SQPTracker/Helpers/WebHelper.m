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
            completionHandler(user);
        }
    };
//    
    r.errorBlock = ^(NSError *error) {
        faildCompletionHandler(error.localizedDescription);
    };
    [r startAsynchronous];
}
@end
