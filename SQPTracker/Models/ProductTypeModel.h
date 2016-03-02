//
//  ProductTypeModel.h
//  SQPTracker
//
//  Created by MAbed on 3/1/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface ProductTypeModel : JSONModel
@property (nonatomic, strong) NSString *type_id;
@property (nonatomic, strong) NSString *type_label_plural;
@property (nonatomic, strong) NSString *type_label_singular;
@property (nonatomic, strong) NSString *type_link;
@end
