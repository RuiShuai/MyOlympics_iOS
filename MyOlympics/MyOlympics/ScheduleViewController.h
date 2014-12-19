//
//  ScheduleViewController.h
//  MyOlympics
//
//  Created by taotao on 14/12/19.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Schedule.h"
#import "ScheduleBL.h"
#import "GameDetailViewController.h"

@interface ScheduleViewController : UITableViewController

@property (strong,nonatomic) NSDictionary *data;//表视图的字典数据
@property (strong,nonatomic) NSArray *arrayGameDateList;//比赛日期列表

@end
