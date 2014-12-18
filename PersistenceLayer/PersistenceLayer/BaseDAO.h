//
//  BaseDAO.h
//  PersistenceLayer
//
//  Created by taotao on 14/12/17.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "DBHelper.h"

@interface BaseDAO : NSObject
{
    sqlite3 *db;
}

@property (nonatomic,strong) NSString *dbFilePath;//数据文件全路径

-(BOOL)openDB;//打开SQLite数据库 true/false

@end
