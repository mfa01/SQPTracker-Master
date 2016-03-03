//
//  StoreDB.m
//  SQPTracker
//
//  Created by MAbed on 3/2/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import "StoreDB.h"

@implementation StoreDB
+(NSMutableArray*)getUserChoices
{
    EGODatabase* database = [EGODatabase databaseWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/database.db"]];
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
    EGODatabase* database = [EGODatabase databaseWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/database.db"]];
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
    EGODatabase* database = [EGODatabase databaseWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/database.db"]];
    NSString* tableName=@"Favorites";
    NSString* qStr=[NSString stringWithFormat:@"SELECT * FROM '%@'",tableName];
    EGODatabaseResult* result = [database executeQueryWithParameters:qStr, nil];
    NSMutableArray* items=[[NSMutableArray alloc]init];;
    
    if(result.errorCode==1)
    {
        qStr=[NSString stringWithFormat:@"CREATE TABLE %@(productID TEXT)",tableName];
        [database executeQueryWithParameters:qStr, nil];
    }
    else
    {
        for(EGODatabaseRow* row in result) {
            NSLog(@"typeID: %@", [row stringForColumn:@"productID"]);
            [items addObject:[row stringForColumn:@"productID"]];
        }
    }
    return items;
    
}
+(void)saveUserFavorites:(NSMutableArray*)selectedProductsIDs
{
    EGODatabase* database = [EGODatabase databaseWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/database.db"]];
    NSString* tableName=@"Favorites";
    //drop all records and add them again
    NSString* qStr=[NSString stringWithFormat:@"DELETE FROM '%@'",tableName];
    EGODatabaseResult* result = [database executeQueryWithParameters:qStr, nil];
    if(result.errorCode==1)
    {
        qStr=[NSString stringWithFormat:@"CREATE TABLE %@(productID TEXT)",tableName];
        [database executeQueryWithParameters:qStr, nil];
    }
    for (int i=0; i<selectedProductsIDs.count; i++) {
        qStr=[NSString stringWithFormat:@"INSERT INTO %@ (productID) VALUES ('%@')",tableName,selectedProductsIDs[i]];
        [database executeQueryWithParameters:qStr, nil];
    }
}
//-(void)saveUserChoices
//{
//    EGODatabase* database = [EGODatabase databaseWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/database.db"]];
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
