//
//  GameDAO.m
//  PersistenceLayer
//
//  Created by taotao on 14/12/17.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import "GameDAO.h"

@implementation GameDAO

static GameDAO *sharedManager = nil;

+(GameDAO *)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        //从父类继承中获得初始化
        sharedManager = [[super alloc] init];
    });
    return sharedManager;
}

-(int)create:(Game *)model
{
    if ([self openDB]) {
        NSString *sqlStr = @"INSERT INTO Game (name,icon,keyInfo,basicInfo,olympicInfo) VALUES (?,?,?,?,?)";
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL)==SQLITE_OK) {
            
            //绑定参数开始
            sqlite3_bind_text(statement, 1, [model.name UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [model.icon UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 3, [model.keyInfo UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 4, [model.basicInfo UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 5, [model.olympicInfo UTF8String], -1, NULL);
            
            //执行插入
            if (sqlite3_step(statement)!=SQLITE_DONE) {
                NSAssert(NO,@"插入数据失败.");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return 0;
}
-(int)remove:(Game *)model
{
    if ([self openDB]) {
        
        //先删除子表gameID相关数据
        NSString *sqlScheduleStr = [[NSString alloc] initWithFormat:@"DELETE from Schedule where gameID = %lu",(unsigned long)model.ID];
        char *err;
        
        //开启事务,立刻提交之前事务
        sqlite3_exec(db, "BEGIN IMMEDIATE TRANSACTION", NULL, NULL, &err);
        if (sqlite3_exec(db, [sqlScheduleStr UTF8String], NULL, NULL, &err)!=SQLITE_OK) {
            //回滚事务
            sqlite3_exec(db, "ROLLBACK TRANSACTION", NULL, NULL, NULL);
            NSAssert(NO,@"删除数据失败.");
        }
                                    
        //先删除主表Game数据
        NSString *sqlGameStr = [[NSString alloc] initWithFormat:@"DELETE from Game where ID = %li",model.ID];
        if (sqlite3_exec(db, [sqlGameStr UTF8String], NULL, NULL, &err)!=SQLITE_OK) {
            //回滚事务
            sqlite3_exec(db, "ROLLBACK TRANSACTION", NULL, NULL, &err);
            NSAssert(NO, @"删除数据失败.");
        }
        //提交事务
        sqlite3_exec(db, "COMMIT TRANSACTION", NULL, NULL, &err);
        sqlite3_close(db);
    }
    return 0;
}

-(int)modify:(Game *)model
{
    if ([self openDB]) {
        NSString *sqlStr = @"UPDATE Game set name = ?,icon = ?,keyInfo = ?,basicInfo = ?,olympicInfo = ? where ID = ?";
        
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            //绑定参数开始
            sqlite3_bind_text(statement, 1, [model.name UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [model.icon UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 3, [model.keyInfo UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 4, [model.basicInfo UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 5, [model.olympicInfo UTF8String], -1, NULL);
            sqlite3_bind_int(statement, 6, (int)model.ID);
            //执行
            if (sqlite3_step(statement)!=SQLITE_DONE) {
                NSAssert(NO,@"修改数据失败.");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return 0;
}

-(NSMutableArray *)findAll
{
    
    NSMutableArray *listData = [[NSMutableArray alloc]init];
    
    if ([self openDB]) {
        NSString *qsql = @"SELECT name,icon,keyInfo,basicInfo,olympicInfo,ID FROM Game";
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            //执行
            while (sqlite3_step(statement)==SQLITE_ROW) {
                Game *game = [[Game alloc]init];
                
                char *cName = (char *)sqlite3_column_text(statement, 0);
                game.name = [[NSString alloc] initWithUTF8String:cName];
                
                char *cIcon = (char *)sqlite3_column_text(statement, 1);
                game.icon = [[NSString alloc] initWithUTF8String:cIcon];
                
                char *cKeyInfo = (char *)sqlite3_column_text(statement, 2);
                game.keyInfo = [[NSString alloc] initWithUTF8String:cKeyInfo];
                
                char *cBasicInfo = (char *)sqlite3_column_text(statement, 3);
                game.basicInfo = [[NSString alloc] initWithUTF8String:cBasicInfo];
                
                char *cOlympicInfo = (char *)sqlite3_column_text(statement, 4);
                game.olympicInfo = [[NSString alloc] initWithUTF8String:cOlympicInfo];
                
                game.ID = sqlite3_column_int(statement, 5);
                
                [listData addObject:game];
                
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return listData;
}

-(Game *)findById:(Game *)model
{
    
    if ([self openDB]) {
        NSString *qsql = @"SELECT name,icon,keyInfo,basicInfo,olympicInfo,ID FROM Game where ID = ?";
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL)==SQLITE_OK) {
            //绑定参数开始
            sqlite3_bind_int(statement, 1, (int)model.ID);
            //执行
            if (sqlite3_step(statement)==SQLITE_ROW) {
                Game *game = [[Game alloc]init];
                
                char *cName = (char *)sqlite3_column_text(statement, 0);
                game.name = [[NSString alloc] initWithUTF8String:cName];
                
                char *cIcon = (char *)sqlite3_column_text(statement, 1);
                game.icon = [[NSString alloc]initWithUTF8String:cIcon];
                
                char *cKeyInfo = (char *)sqlite3_column_text(statement, 2);
                game.keyInfo = [[NSString alloc]initWithUTF8String:cKeyInfo];
                
                char *cBasicInfo = (char *)sqlite3_column_text(statement, 3);
                game.basicInfo = [[NSString alloc]initWithUTF8String:cBasicInfo];
                
                char *cOlympicInfo = (char *)sqlite3_column_text(statement, 4);
                game.olympicInfo = [[NSString alloc]initWithUTF8String:cOlympicInfo];
                
                game.ID = sqlite3_column_int(statement, 5);
                
                sqlite3_finalize(statement);
                sqlite3_close(db);
                return  game;
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }

    return nil;
}

@end
