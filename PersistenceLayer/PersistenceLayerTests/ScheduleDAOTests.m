//
//  ScheduleDAOTests.m
//  PersistenceLayer
//
//  Created by taotao on 14/12/17.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ScheduleDAO.h"
#import "Schedule.h"

@interface ScheduleDAOTests : XCTestCase

@property (nonatomic,strong) ScheduleDAO *dao;
@property (nonatomic,strong) Schedule *theSchedule;

@end

@implementation ScheduleDAOTests

- (void)setUp {
    [super setUp];
    self.dao = [ScheduleDAO sharedManager];
    self.theSchedule = [[Schedule alloc]init];
    self.theSchedule.date = @"test date";
    self.theSchedule.time = @"test time";
    self.theSchedule.info = @"test info";
    self.theSchedule.game.ID = 1;
}

- (void)tearDown {
    self.dao = nil;
    [super tearDown];
}

- (void)test_1_Create
{
    int res = [self.dao create:self.theSchedule];
    XCTAssertTrue(res==0,@"数据插入失败");
}

- (void)test_2_FindById
{
    self.theSchedule.ID = 1;
    Schedule *resSchedule = [self.dao findById:self.theSchedule];
    XCTAssertNotNil(resSchedule,@"查询记录为nil");
    XCTAssertEqualObjects(self.theSchedule.date, resSchedule.date,@"日程日期测试失败");
    XCTAssertEqualObjects(self.theSchedule.time, resSchedule.time,@"日程时间测试失败");
    XCTAssertEqualObjects(self.theSchedule.info, resSchedule.info,@"日程描述测试失败");
    XCTAssertEqual(self.theSchedule.game.ID, resSchedule.game.ID,@"日程项目测试失败");
}

- (void)test_3_FindAll
{
    NSArray *list = [self.dao findAll];
    XCTAssertTrue([list count]==1,@"查询记录数期望值为:1,实际值为:%li",[list count]);
    Schedule *resSchedule = list[0];
    XCTAssertEqualObjects(self.theSchedule.date, resSchedule.date,@"日程日期测试失败");
    XCTAssertEqualObjects(self.theSchedule.time, resSchedule.time,@"日程时间测试失败");
    XCTAssertEqualObjects(self.theSchedule.info, resSchedule.info,@"日程描述测试失败");
    XCTAssertEqual(self.theSchedule.game.ID, resSchedule.game.ID,@"日程项目测试失败");
}

- (void)test_4_Modify
{
    self.theSchedule.ID = 1;
    self.theSchedule.info = @"test modify info";
    int res = [self.dao modify:self.theSchedule];
    XCTAssertTrue(res == 0 ,@"数据修改失败");
    Schedule *resSchedule = [self.dao findById:self.theSchedule];
    XCTAssertNotNil(resSchedule,@"查询记录为nil");
    XCTAssertEqualObjects(self.theSchedule.date, resSchedule.date,@"日程日期测试失败");
    XCTAssertEqualObjects(self.theSchedule.time, resSchedule.time,@"日程时间测试失败");
    XCTAssertEqualObjects(self.theSchedule.info, resSchedule.info,@"日程描述测试失败");
    XCTAssertEqual(self.theSchedule.game.ID, resSchedule.game.ID,@"日程项目测试失败");
}

- (void)test_5_Remove
{
    int res = [self.dao remove:self.theSchedule];
    XCTAssertTrue(res==0,@"数据修改失败");
    Schedule *resSchedule = [self.dao findById:self.theSchedule];
    XCTAssertNil(resSchedule,@"记录删除失败");
}

@end
