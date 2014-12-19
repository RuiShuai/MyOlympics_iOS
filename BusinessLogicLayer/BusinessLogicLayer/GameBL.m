//
//  GameBL.m
//  BusinessLogicLayer
//
//  Created by taotao on 14/12/18.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import "GameBL.h"

@implementation GameBL

-(NSMutableArray *)readData
{
    GameDAO *dao = [GameDAO sharedManager];
    
    NSMutableArray *list = [dao findAll];
    
    return list;
}

@end
