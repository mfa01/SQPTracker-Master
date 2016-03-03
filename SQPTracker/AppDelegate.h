//
//  AppDelegate.h
//  SQPTracker
//
//  Created by MAbed on 3/1/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//We should allow the user to connect his/her Souq account to the application
//User should be able to switch the screen between ‘all products’ and ‘favorite’ one
//product details:Add/Remove this product from his favorite list
//Consider using notifications when application runs in the background and product price changed
//Allow user to add a product to his souq cart
@end

