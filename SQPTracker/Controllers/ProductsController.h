//
//  ProductsController.h
//  SQPTracker
//
//  Created by MAbed on 3/2/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductCell.h"
@interface ProductsController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate,ProductCellDelegate>
{
    int page;
    NSMutableArray* products;
    int oldTabBarItem;
    BOOL searching;
    bool isInCart;
    BOOL isInFavorites;
    NSArray*searchingResults;
    NSMutableArray* favoritesArray;
    NSMutableArray* cartArray;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
