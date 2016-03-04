//
//  ProductsController.m
//  SQPTracker
//
//  Created by MAbed on 3/2/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import "ProductsController.h"
#import "ProductsTypesController.h"
#import "WebHelper.h"
#import "ProductModel.h"
#import "StoreDB.h"
#import "CartModel.h"
#import "ProductDetailsController.h"
@implementation ProductsController
-(void)viewDidLoad
{
    page=1;
    products=[[NSMutableArray alloc]init];
    

    if([StoreDB getUserChoices].count==0)
    {
        //show setting for the first time
        // to let user add his choices
        [self showProductsTypes:nil];
    }
    
    //get user favorite items from stored DB
    favoritesArray=[[NSMutableArray alloc] initWithArray:[StoreDB getUserFavorites]];
    
    //download user cart.. also set there cart id if authinticaed
    if([WebHelper getUserAccessToken])
        [self getUserCart];
}
-(void)viewWillAppear:(BOOL)animated
{
    //refresh active tab content
    if(!isInFavorites&&!isInCart)
    {
        [self getMoreProducts];
    }
    else if(isInFavorites)
    {
        [self favoritesTabSelected];
    }
    else if(isInCart)
    {
        [self cartTabSelected];
    }
}
-(void)getUserCart
{
    [WebHelper getUserCartWithCompletionHandler:^(NSArray* cart) {
        
        cartArray=[[NSMutableArray alloc]initWithArray:cart];
        
        
    } FaildCompletionHandler:^(NSString *error) {
        
    }];
}
-(void)getMoreProducts
{
    [WebHelper getProductsWithPage:page AndTypes:[StoreDB getUserChoices] AndCompletionHandler:^(NSArray *items) {
        if(!isInFavorites&&!isInCart)
        {
            page++;
            [products addObjectsFromArray:items];
            [_collectionView reloadData];
        }
        
    } FaildCompletionHandler:^(NSString *error) {
        
    }];
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
//    NSLog(@"tab bar changed %i" ,   item.tag);
    if(item.tag!=oldTabBarItem)
    {
        oldTabBarItem=(int)item.tag;
        if(item.tag==0)//products
        {
            [self productsTabSelected];
        }
        else if(item.tag==1)//favories
        {
            [self favoritesTabSelected];
        }
        else if(item.tag==2)//cart
        {
            [self cartTabSelected];
        }
    }
}
-(void)cartTabSelected
{
    isInCart=true;
    [products removeAllObjects];
    [products addObjectsFromArray:cartArray];
    [_collectionView reloadData];
}
-(void)favoritesTabSelected
{
    isInFavorites=true;
    isInCart=false;
    [products removeAllObjects];
    [products addObjectsFromArray:[StoreDB getUserFavorites]];
    [_collectionView reloadData];
}
-(void)productsTabSelected
{
    isInFavorites=false;
    isInCart=false;
    [products removeAllObjects];
    [_collectionView reloadData];
    page=1;
    [self getMoreProducts];
}
- (IBAction)showProductsTypes:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProductsTypesController *productsTypes = [mainStoryboard instantiateViewControllerWithIdentifier:@"ProductsTypesController"];
    [self presentViewController:productsTypes animated:YES completion:nil];
    page=1;
    if(products.count>0)
    {
        [products removeAllObjects];
        [_collectionView reloadData];
    }
}
#pragma mark - searching
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"search text %@",searchText);
    //search in current downloaded products list
    NSPredicate *resultPredicate =[NSPredicate predicateWithFormat:@"SELF.product_label contains[c] %@",searchText];
    searchingResults = [products filteredArrayUsingPredicate:resultPredicate];
    if(searchText.length==0)searchingResults=products;
    [_collectionView reloadData];
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searching=true;
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searching=false;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searching=false;
    [searchBar resignFirstResponder];
    [_collectionView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searching=false;
    [searchBar resignFirstResponder];
}
#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(searching)return searchingResults.count;
    return products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCell" forIndexPath:indexPath];
    ProductModel *product;
    if(searching)
    {
        product=searchingResults[indexPath.row];
    }
    else
    {
        product=products[indexPath.row];
    }
    [cell setUpWithItem:product AndIsFavorited:[self checkIfProductInFavorites:product.product_id]];
    
    //delegate needed because of product favorite button click action
    cell.delegate=self;
    return cell;
}
-(BOOL)checkIfProductInFavorites:(NSString*)productID
{
    for (int i=0; i<favoritesArray.count; i++) {
        ProductModel*item=favoritesArray[i];
//        if ([productID isKindOfClass:[NSString class]]) {
            if([item.product_id isEqualToString:productID])
            {
                return YES;
            }
//        }
//        else
//        {
//            if([item.product_id longLongValue]== [productID longLongValue])
//            {
//                return YES;
//            }
//        }
        
    }
    return NO;
}

-(void)addToFavoritesWithProduct:(ProductModel *)product
{
    //if product already in favorites list remove it else add it
    if([self checkIfProductInFavorites:product.product_id])
    {
        [StoreDB removeFromFavorites:product];
        ProductModel*item;

        if(isInFavorites)
        {
            for (int i=0; i<favoritesArray.count; i++) {
                item=favoritesArray[i];
                
                if([item.product_id isEqualToString:product.product_id])
                {
                    [favoritesArray removeObjectAtIndex:i];
                    break;
                }
            }
        }
    }
    else
    {
        [StoreDB addToFavorites:product];
        [favoritesArray addObject:product];
    }

    if(isInFavorites)
    {
        //[self favoritesTabSelected];
        [products removeAllObjects];
        [products addObjectsFromArray:favoritesArray];
        [_collectionView reloadData];
    }
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(searching||isInFavorites||isInCart)return;
    
    //lazy loading for products when user reach end of products list
    if (indexPath.row == products.count-2) {
        [self getMoreProducts];
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = collectionView.frame.size.width;
    if(self.view.frame.size.width>self.view.frame.size.height)
        return CGSizeMake(width/3,width/3);
    
    return CGSizeMake(width/2,width/2);
}
-(void)viewWillLayoutSubviews
{
    [_collectionView reloadData];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(searching)[self performSegueWithIdentifier:@"GoToProductDetailsController" sender:searchingResults[indexPath.row]];
    else [self performSegueWithIdentifier:@"GoToProductDetailsController" sender:products[indexPath.row]];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"GoToProductDetailsController"]) {
        ProductDetailsController *controller = (ProductDetailsController *)segue.destinationViewController;
        controller.product=(ProductModel*)sender;
    }
}
@end
