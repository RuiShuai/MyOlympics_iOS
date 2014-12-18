//
//  Schedule.h
//  PersistenceLayer
//
//  Created by taotao on 14/12/17.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"


@interface Schedule : NSObject

@property (nonatomic,assign) NSUInteger ID;
@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *info;
@property (nonatomic,strong) Game *game;


@end
