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
@end
