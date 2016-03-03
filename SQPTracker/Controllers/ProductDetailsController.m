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
@implementation ProductDetailsController
-(void)viewWillAppear:(BOOL)animated
{
    _lblName.text=_product.product_label;
    [_ivProductImage sd_setImageWithURL:[_product getImageForProductsDetails]];
    _lblProductPrice.text=[_product getPriceWithCurrency];
    [self getOffers];
    
    
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
