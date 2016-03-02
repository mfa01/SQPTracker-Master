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
@end
