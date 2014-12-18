//
//  ScheduleDAO.h
//  PersistenceLayer
//
//  Created by taotao on 14/12/17.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import "BaseDAO.h"
#import "Schedule.h"
#import "Game.h"

@interface ScheduleDAO : BaseDAO

+(ScheduleDAO *)sharedManager;

-(int)create:(Schedule *)model;
-(int)remove:(Schedule *)model;
-(int)modify:(Schedule *)model;
-(NSMutableArray *)findAll;

-(Schedule *)findById:(Schedule *)model;

@end
