//
//  StoreDB.m
//  SQPTracker
//
//  Created by MAbed on 3/2/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import "StoreDB.h"
@implementation StoreDB
#define SQ_DBNAME @"Documents/database.db"
+(NSMutableArray*)getUserChoices
{
    EGODatabase* database = [EGODatabase databaseWithPath:[NSHomeDirectory() stringByAppendingPathComponent:SQ_DBNAME]];
    NSString* tableName=@"ProductType";
    NSString* qStr=[NSString stringWithFormat:@"SELECT * FROM '%@'",tableName];
    EGODatabaseResult* result = [database executeQueryWithParameters:qStr, nil];
    NSMutableArray* items=[[NSMutableArray alloc]init];;
    
    if(result.errorCode==1)
    {
        qStr=[NSString stringWithFormat:@"CREATE TABLE %@(typeID TEXT)",tableName];
        [database executeQueryWithParameters:qStr, nil];
    }
    else
    {
        for(EGODatabaseRow* row in result) {
            NSLog(@"typeID: %@", [row stringForColumn:@"typeID"]);
            [items addObject:[row stringForColumn:@"typeID"]];
        }
    }
    return items;
    
}
+(void)saveUserChoices:(NSMutableArray*)selectedProductsIDs
{
    EGODatabase* database = [EGODatabase databaseWithPath:[NSHomeDirectory() stringByAppendingPathComponent:SQ_DBNAME]];
    NSString* tableName=@"ProductType";
    //drop all records and add them again
    NSString* qStr=[NSString stringWithFormat:@"DELETE FROM '%@'",tableName];
    EGODatabaseResult* result = [database executeQueryWithParameters:qStr, nil];
    if(result.errorCode==1)
    {
        qStr=[NSString stringWithFormat:@"CREATE TABLE %@(typeID TEXT)",tableName];
        [database executeQueryWithParameters:qStr, nil];
    }
    for (int i=0; i<selectedProductsIDs.count; i++) {
        qStr=[NSString stringWithFormat:@"INSERT INTO %@ (typeID) VALUES ('%@')",tableName,selectedProductsIDs[i]];
        [database executeQueryWithParameters:qStr, nil];
    }
}
+(NSMutableArray*)getUserFavorites
{
    EGODatabase* database = [EGODatabase databaseWithPath:[NSHomeDirectory() stringByAppendingPathComponent:SQ_DBNAME]];
    NSString* tableName=@"Favorites";
    NSString* qStr=[NSString stringWithFormat:@"SELECT * FROM '%@'",tableName];
    EGODatabaseResult* result = [database executeQueryWithParameters:qStr, nil];
    NSMutableArray* items=[[NSMutableArray alloc]init];;
    
    if(result.errorCode==1)
    {
        qStr=[NSString stringWithFormat:@"CREATE TABLE %@(product_id TEXT,product_label TEXT,product_images TEXT,product_offer_price INTEGER,product_currency TEXT,product_offer_id TEXT)",tableName];
        [database executeQueryWithParameters:qStr, nil];
    }
    else
    {
        for(EGODatabaseRow* row in result) {
            ProductModel* item=[[ProductModel alloc]init];
            NSString* dataStr=[row stringForColumn:@"product_images"];
            NSError * err;
            NSData *data =[dataStr dataUsingEncoding:NSUTF8StringEncoding];
            if(data!=nil){
                item.product_images = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
            }
            
            item.product_id=[row stringForColumn:@"product_id"];
            item.product_label=[row stringForColumn:@"product_label"];
            item.product_offer_price=[row intForColumn:@"product_offer_price"];
            item.product_currency=[row stringForColumn:@"product_currency"];
            item.product_offer_id=[row stringForColumn:@"product_offer_id"];
            [items addObject:item];
        }
    }
    return items;
    
}
+(void)addToFavorites:(ProductModel*)item
{
    EGODatabase* database = [EGODatabase databaseWithPath:[NSHomeDirectory() stringByAppendingPathComponent:SQ_DBNAME]];
    NSString* tableName=@"Favorites";
   
    NSError * err;
    NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:item.product_images options:0 error:&err];
    NSString * myData = [[NSString alloc] initWithData:jsonData   encoding:NSUTF8StringEncoding];
    
    NSString* qStr=[NSString stringWithFormat:@"INSERT INTO %@ (product_id,product_label,product_images,product_offer_price,product_currency,product_offer_id) VALUES ('%@','%@','%@','%li','%@','%@')",tableName,item.product_id,item.product_label,myData,(long)item.product_offer_price,item.product_currency,item.product_offer_id];

    EGODatabaseResult* result=[database executeQueryWithParameters:qStr, nil];
    if(result.errorCode==1)
    {
        NSString* qStr2=[NSString stringWithFormat:@"CREATE TABLE %@(product_id TEXT,product_label TEXT,product_images TEXT,product_offer_price INTEGER,product_currency TEXT,product_offer_id TEXT)",tableName];
        [database executeQueryWithParameters:qStr2, nil];
        [database executeQueryWithParameters:qStr, nil];
    }
}
+(void)removeFromFavorites:(ProductModel*)item
{
    EGODatabase* database = [EGODatabase databaseWithPath:[NSHomeDirectory() stringByAppendingPathComponent:SQ_DBNAME]];
    NSString* tableName=@"Favorites";
    NSString* removeQStr=[NSString stringWithFormat:@"DELETE FROM %@ WHERE product_id='%@'",tableName,item.product_id];
    [database executeQueryWithParameters:removeQStr, nil];
}
+(ProductModel*)getItemFromFavoritesWithID:(NSString*)itemID
{
    EGODatabase* database = [EGODatabase databaseWithPath:[NSHomeDirectory() stringByAppendingPathComponent:SQ_DBNAME]];
    NSString* tableName=@"Favorites";
    NSString* removeQStr=[NSString stringWithFormat:@"SELECT * FROM %@ WHERE product_id='%@'",tableName,itemID];
    EGODatabaseResult* result=[database executeQueryWithParameters:removeQStr, nil];
    ProductModel* item=[[ProductModel alloc]init];
    if(result.rows.count==0)return nil;
    for(EGODatabaseRow* row in result) {
        
        NSString* dataStr=[row stringForColumn:@"product_images"];
        NSError * err;
        NSData *data =[dataStr dataUsingEncoding:NSUTF8StringEncoding];
        if(data!=nil){
            item.product_images = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        }
        
        item.product_id=[row stringForColumn:@"product_id"];
        item.product_label=[row stringForColumn:@"product_label"];
        item.product_offer_price=[row intForColumn:@"product_offer_price"];
        item.product_currency=[row stringForColumn:@"product_currency"];
        item.product_offer_id=[row stringForColumn:@"product_offer_id"];
    }
    
    return item;
}
//-(void)saveUserChoices
//{
//    EGODatabase* database = [EGODatabase databaseWithPath:[NSHomeDirectory() stringByAppendingPathComponent:SQ_DBNAME]];
//    NSString* tableName=@"ProductType";
//    NSString* qStr=[NSString stringWithFormat:@"SELECT * FROM '%@'",tableName];
//    EGODatabaseResult* result = [database executeQueryWithParameters:qStr, nil];
//    if(result.errorCode==1)
//    {
//        qStr=[NSString stringWithFormat:@"CREATE TABLE %@(user_id TEXT,userName TEXT)",tableName];
//        [database executeQueryWithParameters:qStr, nil];
//    }
//    else
//    {
//        for(EGODatabaseRow* row in result) {
//            NSLog(@"userName: %@", [row stringForColumn:@"userName"]);
//            //        NSLog(@"user_id: %@", [row dateForColumn:@"date"]);
//            //        NSLog(@"Views: %d", [row intForColumn:@"views"]);
//            NSLog(@"user_id: %@", [row stringForColumn:@"user_id"]);
//        }
//    }
//    qStr=[NSString stringWithFormat:@"INSERT INTO %@ (user_id,userName) VALUES ('10', 'Ramesh')",tableName];
//    [database executeQueryWithParameters:qStr, nil];
//}

@end
