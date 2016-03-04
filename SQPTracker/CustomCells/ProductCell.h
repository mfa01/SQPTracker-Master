//
//  ProductCell.h
//  SQPTracker
//
//  Created by MAbed on 3/2/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
@protocol ProductCellDelegate<NSObject>
@required
- (void) addToFavoritesWithProduct:(ProductModel*)product;
@end

@interface ProductCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblImageName;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *btnAddToFavorite;
@property (weak, nonatomic) ProductModel *product;
-(void)setUpWithItem:(ProductModel*)product AndIsFavorited:(BOOL)inFavorites;
@property (nonatomic,assign)  id <ProductCellDelegate> delegate;
@end
