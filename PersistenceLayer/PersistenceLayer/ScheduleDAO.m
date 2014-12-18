//
//  ScheduleDAO.m
//  PersistenceLayer
//
//  Created by taotao on 14/12/17.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import "ScheduleDAO.h"

@implementation ScheduleDAO

static ScheduleDAO *sharedManager = nil;
+(ScheduleDAO *)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedManager = [[super alloc]init];
    });
    return sharedManager;
}

-(int)create:(Schedule *)model
{
    if ([self openDB]) {
        NSString *sqlStr = @"INSERT INTO Schedule (date,time,info,gameID) VALUES (?,?,?,?)";
        
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL)==SQLITE_OK) {
            //绑定参数开始
            sqlite3_bind_text(statement, 1, [model.date UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [model.time UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 3, [model.info UTF8String], -1, NULL);
            sqlite3_bind_int(statement, 4, (int)model.game.ID);
            
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
-(int)remove:(Schedule *)model
{
    if ([self openDB]) {
        NSString *sqlStr = @"DELETE from Schedule where ID = ?";
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL)==SQLITE_OK) {
            //绑定参数开始
            sqlite3_bind_int(statement, 1, (int)model.ID);
            //执行
            if (sqlite3_step(statement)!=SQLITE_DONE) {
                NSAssert(NO,@"删除数据失败.");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    
    return 0;
}

-(int)modify:(Schedule *)model
{
    if ([self openDB]) {
        NSString *sqlStr = @"UPDATE Schedule set info = ?,gameID = ?,date = ?,time = ? where ID = ?";
        
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL)==SQLITE_OK) {
            //绑定参数开始
            sqlite3_bind_text(statement, 1, [model.info UTF8String], -1, NULL);
            sqlite3_bind_int(statement, 2, (int)model.game.ID);
            sqlite3_bind_text(statement, 3, [model.date UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 4, [model.time UTF8String], -1, NULL);
            sqlite3_bind_int(statement, 5, (int)model.ID);
            
            //执行
            if (sqlite3_step(statement) != SQLITE_DONE) {
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
        NSString *qsql = @"SELECT date,time,info,gameID,ID FROM Schedule";
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL)==SQLITE_OK) {
            //执行
            while (sqlite3_step(statement)==SQLITE_ROW) {
                Schedule *schedule = [[Schedule alloc]init];
                Game *game = [[Game alloc]init];
                schedule.game = game;
                
                char *cDate = (char *)sqlite3_column_text(statement, 0);
                schedule.date = [[NSString alloc]initWithUTF8String:cDate];
                
                char *cTime = (char *)sqlite3_column_text(statement, 1);
                schedule.time = [[NSString alloc]initWithUTF8String:cTime];
                
                char *cInfo = (char *)sqlite3_column_text(statement, 2);
                schedule.info = [[NSString alloc]initWithUTF8String:cInfo];
                
                schedule.game.ID = sqlite3_column_int(statement, 3);
                schedule.ID = sqlite3_column_int(statement, 4);
                
                [listData addObject:schedule];
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    
    return listData;
}

-(Schedule *)findById:(Schedule *)model
{
    if ([self openDB]) {
        NSString *qsql = @"SELECT date,time,info,gameID,ID FROM Schedule where ID = ?";
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL)==SQLITE_OK) {
            
            //绑定参数开始
            sqlite3_bind_int(statement, 1, (int)model.ID);
            
            //执行
            if (sqlite3_step(statement)==SQLITE_ROW) {
                Schedule *schedule = [[Schedule alloc]init];
                Game *game = [[Game alloc] init];
                schedule.game = game;
                
                char *cDate = (char *)sqlite3_column_text(statement, 0);
                schedule.date = [[NSString alloc] initWithUTF8String:cDate];
                
                char *cTime = (char *)sqlite3_column_text(statement, 1);
                schedule.time = [[NSString alloc] initWithUTF8String:cTime];
                
                char *cInfo = (char *)sqlite3_column_text(statement, 2);
                schedule.info = [[NSString alloc]initWithUTF8String:cInfo    ];
                
                schedule.game.ID = sqlite3_column_int(statement, 3);
                schedule.ID = sqlite3_column_int(statement, 4);
                
                sqlite3_finalize(statement);
                sqlite3_close(db);
                
                return  schedule;
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return nil;
}

@end
