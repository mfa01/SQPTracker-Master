//
//  ProductsTypeCell.h
//  SQPTracker
//
//  Created by MAbed on 3/1/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductTypeModel.h"
@interface ProductsTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblProductTitle;
@property (weak, nonatomic) IBOutlet UIImageView *ivSelectedImage;
@property (weak, nonatomic) IBOutlet UIView *vContentView;
-(void)setupCellWithProductType:(ProductTypeModel*)productType;
-(void)setCellSelected:(BOOL)selected;
@end
