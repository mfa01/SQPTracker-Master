//
//  ProductsTypesController.h
//  SQPTracker
//
//  Created by MAbed on 3/1/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductsTypesController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    int page;
    NSMutableArray* productsTypes;
    NSMutableArray* selectedProductsIDs;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
