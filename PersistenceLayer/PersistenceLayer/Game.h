//
//  Game.h
//  PersistenceLayer
//
//  Created by taotao on 14/12/17.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

@property (nonatomic,assign) NSUInteger ID;//编号
@property (nonatomic,strong) NSString *name;//姓名
@property (nonatomic,strong) NSString *icon;//图标
@property (nonatomic,strong) NSString *keyInfo;//关键信息
@property (nonatomic,strong) NSString *basicInfo;//基本信息
@property (nonatomic,strong) NSString *olympicInfo;//历史信息

@end
