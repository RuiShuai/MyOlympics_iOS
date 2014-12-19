//
//  BaseDAO.m
//  PersistenceLayer
//
//  Created by taotao on 14/12/17.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import "BaseDAO.h"

@implementation BaseDAO
-(id)init
{
    self = [super init];
    if (self) {
        self.dbFilePath = [DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];
        DBHelper *dbHelper = [DBHelper new];
        [dbHelper initDB];
    }
    return self;
}

-(BOOL)openDB
{
    //NSLog(@"DbFilePath = %@",self.dbFilePath);
    if (sqlite3_open([self.dbFilePath UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"open db failed");
        return false;
    }
    return true;
}

@end
