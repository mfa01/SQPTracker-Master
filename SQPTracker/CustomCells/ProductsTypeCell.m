//
//  ProductsTypeCell.m
//  SQPTracker
//
//  Created by MAbed on 3/1/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import "ProductsTypeCell.h"
#import "ConfigVars.h"
@implementation ProductsTypeCell
-(void)setupCellWithProductType:(ProductTypeModel*)productType
{
    _lblProductTitle.text=productType.type_label_singular;
}
-(void)setCellSelected:(BOOL)selected
{
    if (selected) {
        _vContentView.backgroundColor=Color_SOUQ_BLUE;
        _lblProductTitle.textColor=[UIColor whiteColor];
        _ivSelectedImage.hidden=false;
    }
    else
    {
        _vContentView.backgroundColor=[UIColor lightGrayColor];
        _lblProductTitle.textColor=[UIColor blackColor];
        _ivSelectedImage.hidden=true;
    }
}
@end
