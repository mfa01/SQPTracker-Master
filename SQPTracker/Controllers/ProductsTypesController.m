//
//  ProductsTypesController.m
//  SQPTracker
//
//  Created by MAbed on 3/1/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import "ProductsTypesController.h"
#import "WebHelper.h"
#import "ProductTypeModel.h"
#import "ProductsTypeCell.h"
#import "StoreDB.h"
@implementation ProductsTypesController
-(void)viewDidLoad
{
    page=1;
    productsTypes=[[NSMutableArray alloc] init];
    selectedProductsIDs=[[NSMutableArray alloc] init];
    [selectedProductsIDs addObjectsFromArray:[StoreDB getUserChoices]];
    [self getMoreProductsTypes];
}
-(void)getMoreProductsTypes
{
    [WebHelper getProductsTypesWithPage:page AndCompletionHandler:^(NSArray *items) {
        page++;
        [productsTypes addObjectsFromArray:items];
        [_tableView reloadData];
        
    } FaildCompletionHandler:^(NSString *error) {
        
    }];
}
- (IBAction)btnGo:(id)sender {
    //save user choices and go to products to load prodcuts there
    [StoreDB saveUserChoices:selectedProductsIDs];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductTypeModel*item = [productsTypes objectAtIndex:indexPath.row];
    static NSString *CellId = @"ProductsTypeCell";
    ProductsTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    [cell setupCellWithProductType:item];
    return cell;
}


- (void)tableView:(nonnull UITableView *)tableView willDisplayCell:(nonnull ProductsTypeCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ProductTypeModel*item = [productsTypes objectAtIndex:indexPath.row];

    if([selectedProductsIDs containsObject:item.type_id])
    {
        [cell setCellSelected:YES];
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else
    {
        [cell setCellSelected:NO];
    }
    
    //lazy loading for types when reach end of list
    if (indexPath.row == productsTypes.count-2) {
        [self getMoreProductsTypes];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return productsTypes.count;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductTypeModel *type = [productsTypes objectAtIndex:indexPath.row];
    [selectedProductsIDs removeObject:type.type_id];
    ProductsTypeCell*cell=[tableView cellForRowAtIndexPath:indexPath];
    [cell setCellSelected:NO];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductTypeModel *type = [productsTypes objectAtIndex:indexPath.row];
    [selectedProductsIDs addObject:type.type_id];
    ProductsTypeCell*cell=[tableView cellForRowAtIndexPath:indexPath];

    [cell setCellSelected:YES];
}

@end
