//
//  DBHelper.h
//  PersistenceLayer
//
//  Created by taotao on 14/12/17.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

#define DB_FILE_NAME @"app.db"

@interface DBHelper : NSObject
{
    sqlite3 *db;
}

//获得沙箱目录
+(NSString *)applicationDocumentsDirectoryFile :(NSString *)fileName;

//初始化数据库
-(void)initDB;

//获取数据库版本号
-(int)dbVersionNumber;

@end
