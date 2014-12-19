//
//  Schedule.m
//  PersistenceLayer
//
//  Created by taotao on 14/12/17.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import "Schedule.h"

@implementation Schedule

-(NSString *)description
{
    NSString *desc = [[NSString alloc] initWithFormat:@"Schedule with ID:%li,date:%@,time:%@,info:%@,gameID:%li",_ID,_date,_time,_info,_game.ID];
    return desc;
}

@end
