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
-(void)setUpWithItem:(ProductModel*)product AndIsFavorited:(BOOL)inFavorites
{
    _lblImageName.text=product.product_label;
    [_imageView sd_setImageWithURL:[product getImageForProductsDashboard]];
    _product=product;
    [_btnAddToFavorite setSelected:inFavorites];
}
-(IBAction)addToFavorite:(id)sender
{
    if([_delegate respondsToSelector:@selector(addToFavoritesWithProduct:)])
        [_delegate addToFavoritesWithProduct:_product];
    _btnAddToFavorite.selected=!_btnAddToFavorite.selected;
}
@end
