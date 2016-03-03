//
//  ProductCell.m
//  SQPTracker
//
//  Created by MAbed on 3/2/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import "ProductCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ProductCell
-(void)setUpWithItem:(ProductModel*)product
{
    _lblImageName.text=product.product_label;
    [_imageView sd_setImageWithURL:[product getImageForProductsDashboard]];
}
@end
