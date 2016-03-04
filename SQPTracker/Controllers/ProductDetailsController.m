//
//  ProductDetailsController.m
//  SQPTracker
//
//  Created by MAbed on 3/2/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import "ProductDetailsController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "WebHelper.h"
#import "OfferPriceCell.h"
#import "StoreDB.h"
@implementation ProductDetailsController
-(void)viewWillAppear:(BOOL)animated
{
    _lblName.text=_product.product_label;
    [_ivProductImage sd_setImageWithURL:[_product getImageForProductsDetails]];
    _lblProductPrice.text=[_product getPriceWithCurrency];
    [self getOffers];
    [self checkFavorite];
    
}
- (IBAction)addToCart:(id)sender {
    if([WebHelper getUserAccessToken])
    {
        [WebHelper addProductToUserCartId:[WebHelper getCartID] AndProductId:_product.product_offer_id AndCompletionHandler:^(bool success) {
            NSLog(@"%u",success);
            [self showMessage:@"Cong..Product added to the Cart"];
            
        } FaildCompletionHandler:^(NSString *error) {
            NSLog(@"%@",error);
        }];
    }
    else
    {
        [self showMessage:@"Please login to add products to cart"];
    }
}
-(void)showMessage:(NSString*)msg
{
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                               actionWithTitle:@"Ok"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   
                               }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)checkFavorite
{
    if([StoreDB getItemFromFavoritesWithID:_product.product_id])
        [_btnFavorites setSelected:YES];
    else [_btnFavorites setSelected:NO];
    
    isFavorite=_btnFavorites.isSelected;
}
- (IBAction)addToFavorites:(id)sender {
    if(isFavorite)
    {
        [StoreDB removeFromFavorites:_product];
        [_btnFavorites setSelected:NO];
    }
    else
    {
        [StoreDB addToFavorites:_product];
        [_btnFavorites setSelected:YES];
    }
}
-(void)getOffers
{
    [WebHelper getProductOffersWithProductID:_product.product_id AndCompletionHandler:^(NSArray *items) {
        offersArray=[NSArray arrayWithArray:items];
        [_tableView reloadData];
        
    } FaildCompletionHandler:^(NSString *error) {
        
    }];
}
#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductOfferModel*item = [offersArray objectAtIndex:indexPath.row];
    static NSString *CellId = @"OfferPriceCell";
    OfferPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    [cell setUpWithItem:item];
    
    
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return offersArray.count;
}

@end
