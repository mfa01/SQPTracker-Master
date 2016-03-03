//
//  User.h
//  SQPTracker
//
//  Created by MAbed on 3/3/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"
@interface User : JSONModel
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *user_access_token;


@end
