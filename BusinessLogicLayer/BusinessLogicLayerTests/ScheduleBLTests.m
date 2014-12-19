//
//  ScheduleBLTests.m
//  BusinessLogicLayer
//
//  Created by taotao on 14/12/18.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ScheduleBL.h"
#import "Schedule.h"

@interface ScheduleBLTests : XCTestCase

@property (nonatomic,strong) ScheduleBL *bl;
@property (nonatomic,strong) Schedule *theSchedule;

@end

@implementation ScheduleBLTests

- (void)setUp {
    [super setUp];
    self.bl = [ScheduleBL new];
    //创建Schedule对象
    self.theSchedule = [Schedule new];
    self.theSchedule.date = @"test date";
    self.theSchedule.time = @"test time";
    self.theSchedule.info = @"test info";
    Game *game = [Game new];
    game.name = @"test name";
    game.ID = 1;
    self.theSchedule.game = game;
    
    //插入测试数据
    ScheduleDAO *dao = [ScheduleDAO sharedManager];
    [dao create:self.theSchedule];
}

- (void)tearDown {
    self.theSchedule.ID = 1;
    ScheduleDAO *dao = [ScheduleDAO sharedManager];
    [dao remove:self.theSchedule];
    [super tearDown];
}

-(void)testFindAll
{
    NSMutableDictionary *dict = [self.bl readData];
    
    NSArray *allKeys = [dict allKeys];
    XCTAssertTrue([allKeys count]==1,@"断言比赛天数为:1 实际值为:%li",[allKeys count]);
    NSArray *schedules = [dict objectForKey:self.theSchedule.date];
    Schedule *resSchedule = schedules[0];
    XCTAssertEqualObjects(self.theSchedule.date, resSchedule.date,@"比赛日期测试失败");
    XCTAssertEqualObjects(self.theSchedule.time, resSchedule.time,@"比赛时间测试失败");
    XCTAssertEqualObjects(self.theSchedule.info, resSchedule.info,@"日程描述测试失败");
    //XCTAssertEqual(self.theSchedule.game.ID, resSchedule.game.ID,@"比赛项目ID测试失败");
    //XCTAssertEqualObjects(self.theSchedule.game.name, resSchedule.game.name,@"比赛项目名称测试失败");
}


@end
