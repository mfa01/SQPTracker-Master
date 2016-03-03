//
//  ProductCell.h
//  SQPTracker
//
//  Created by MAbed on 3/2/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
@interface ProductCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblImageName;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
-(void)setUpWithItem:(ProductModel*)product;
@end
