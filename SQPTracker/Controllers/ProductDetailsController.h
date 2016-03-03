//
//  ProductDetailsController.h
//  SQPTracker
//
//  Created by MAbed on 3/2/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
@interface ProductDetailsController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray* offersArray;
}
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *ivProductImage;
@property (weak, nonatomic) IBOutlet UILabel *lblProductPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnAddToFavorite;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(weak,nonatomic)ProductModel* product;
@end
