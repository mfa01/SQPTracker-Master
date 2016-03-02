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
@implementation ProductsTypesController
-(void)viewDidLoad
{
    page=1;
    productsTypes=[[NSMutableArray alloc] init];
    selectedProductsIDs=[[NSMutableArray alloc] init];
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
    if (indexPath.row == productsTypes.count-2) {
        [self getMoreProductsTypes];
    }
}

//- (void)styleSelectionFor:(ProductTypeCell *)cell atIndexPath:(NSIndexPath *)indexPath {
//    BOOL selected = [[typesTableView indexPathsForSelectedRows] containsObject:indexPath];
//    [cell.typeLabel setTextColor:selected?[UIColor whiteColor]:[self.stylingDetails themeColor]];
//    [cell.selectionBackView setBackgroundColor:selected?[self.stylingDetails themeBlueColor]:[self.stylingDetails themeGrayColor]];
//    [cell.selectionImageView setHidden:!selected];
//}

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
