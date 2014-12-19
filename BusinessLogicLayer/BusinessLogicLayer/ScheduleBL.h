//
//  ScheduleBL.h
//  BusinessLogicLayer
//
//  Created by taotao on 14/12/18.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScheduleDAO.h"
#import "Schedule.h"
#import "GameDAO.h"
#import "Game.h"

@interface ScheduleBL : NSObject

-(NSMutableDictionary *)readData;

@end
