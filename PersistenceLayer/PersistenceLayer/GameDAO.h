//
//  GameDAO.h
//  PersistenceLayer
//
//  Created by taotao on 14/12/17.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import "BaseDAO.h"
#import "Game.h"

@interface GameDAO : BaseDAO

+(GameDAO *)sharedManager;

-(int)create:(Game *)model;
-(int)remove:(Game *)model;
-(int)modify:(Game *)model;
-(NSMutableArray *)findAll;
-(Game *)findById:(Game *)model;

@end
