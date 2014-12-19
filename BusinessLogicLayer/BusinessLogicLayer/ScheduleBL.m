//
//  ScheduleBL.m
//  BusinessLogicLayer
//
//  Created by taotao on 14/12/18.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import "ScheduleBL.h"

@implementation ScheduleBL

-(NSMutableDictionary *)readData
{
    ScheduleDAO *scheduleDAO = [ScheduleDAO sharedManager];
    NSMutableArray *schedules = [scheduleDAO findAll];
    
    NSMutableDictionary *resDict = [[NSMutableDictionary alloc] init];
    GameDAO *gameDAO = [GameDAO sharedManager];
    //延迟加载game数据
    for (Schedule *schedule in schedules) {
        Game *game = [gameDAO findById:schedule.game];
        schedule.game = game;
        NSArray *allKey = [resDict allKeys];
        
        //把NSMutableArray结构转化为NSMutableDictionary结构
        if ([allKey containsObject:schedule.date]) {
            //1.追加数据
            NSMutableArray *value = [resDict objectForKey:schedule.date];
            [value addObject:schedule];
        } else {
            //0.新建字典
            NSMutableArray *value = [[NSMutableArray alloc] init];
            [value addObject:schedule];
            [resDict setObject:value forKey:schedule.date];
        }
    }
    
    return resDict;
}

@end
