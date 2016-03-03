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
#import "ProductCell.h"
#import "ProductDetailsController.h"
@implementation ProductsController
-(void)viewDidLoad
{
    page=1;
    products=[[NSMutableArray alloc]init];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getMoreProducts];
}
-(void)getMoreProducts
{

    [WebHelper getProductsWithPage:page AndTypes:[StoreDB getUserChoices] AndCompletionHandler:^(NSArray *items) {
        page++;
        [products addObjectsFromArray:items];
        [_collectionView reloadData];
        
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
            [products removeAllObjects];
            [_collectionView reloadData];
            page=1;
            [self getMoreProducts];
        }
        else if(item.tag==1)//favories
        {
//            [products removeAllObjects];
//            NSMutableArray* productIdsArray=[StoreDB getUserFavorites];
//            [_collectionView reloadData];

        }
    }
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
    [cell setUpWithItem:product];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(searching)return;
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
