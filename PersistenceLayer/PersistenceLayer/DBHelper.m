//
//  DBHelper.m
//  PersistenceLayer
//
//  Created by taotao on 14/12/17.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import "DBHelper.h"


@implementation DBHelper

-(void)initDB
{
  
    //加载DBConfig.plist
    NSString *configTablePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"DBConfig" ofType:@"plist"];
    NSLog(@"configTablePath = %@",configTablePath);
    
    NSDictionary *configTable = [[NSDictionary alloc] initWithContentsOfFile:configTablePath];
    //get dbVersion from file
    NSNumber *dbConfigVersion = [configTable objectForKey:@"DB_VERSION"];
    if (dbConfigVersion == nil) {
        dbConfigVersion = [NSNumber numberWithInt:0];
    }
    
    //get version_number from DBVersionInfo Table
    int versionNumber = [self dbVersionNumber];
    
    //版本号不一致时
    if ([dbConfigVersion intValue] != versionNumber) {
        NSString *dbFilePath = [DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];
        
        if (sqlite3_open([dbFilePath UTF8String], &db) != SQLITE_OK) {
            sqlite3_close(db);
            NSAssert(NO,@"open db failed!");
        } else {
            //load data
            NSLog(@"db upgrading...");
            char *err;
            NSString *createTablePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"create_load" ofType:@"sql"];
            NSString *sql = [[NSString alloc] initWithContentsOfFile:createTablePath encoding:NSUTF8StringEncoding error:nil];
            if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
                NSLog(@"db upgrade failed with error: %@",[NSMutableString stringWithCString:err encoding:NSUTF8StringEncoding]);
            }
            
            //save curent dbVersionNumber to dbfile("app.db")
            NSString *usql = [[NSString alloc] initWithFormat:@"update  DBVersionInfo set version_number = %i", [dbConfigVersion intValue]];
            if (sqlite3_exec(db, [usql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
                NSAssert(NO,@"update DBVersionInfo failed.");
            }
            
            sqlite3_close(db);
        }
        
    }
    
    
}

-(int)dbVersionNumber
{
    NSString *dbFilePath = [DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];
    int versionNumber = -1;
    if (sqlite3_open([dbFilePath UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO,@"db open failed");
    } else {
        NSString *sql = @"create table if not exists DBVersionInfo (version_number int );";
        if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, NULL) != SQLITE_OK) {
            NSAssert(NO, @"create table failed");
        }
        NSString *qsql = @"select version_number from DBVersionInfo";
        
        sqlite3_stmt *statement;
        //pre-process
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL)==SQLITE_OK) {
            if (sqlite3_step(statement)==SQLITE_ROW) {
                NSLog(@"with data");
                versionNumber = sqlite3_column_int(statement, 0);
            } else {
                NSString *csql = @"insert into DBVersionInfo (version_number) values(-1)";
                if (sqlite3_exec(db, [csql UTF8String], NULL, NULL, NULL)!= SQLITE_OK) {
                    NSAssert(NO,@"insert version_number failed.");
                }
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    
    
    
    return versionNumber;
}

+(NSString *)applicationDocumentsDirectoryFile :(NSString *)fileName
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:fileName];
    return path;
}

@end
