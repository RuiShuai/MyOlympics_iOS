//
//  GameDAOTests.m
//  PersistenceLayer
//
//  Created by taotao on 14/12/17.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "GameDAO.h"
#import "DBHelper.h"
#import "Game.h"

@interface GameDAOTests : XCTestCase

@property (nonatomic,strong) GameDAO *dao;
@property (nonatomic,strong) Game *theGame;

@end

@implementation GameDAOTests

- (void)setUp {
    [super setUp];
    self.dao = [GameDAO sharedManager];
    self.theGame = [[Game alloc]init];
    self.theGame.name = @"test GameName";
    self.theGame.icon = @"test GameIcon";
    self.theGame.keyInfo = @"test KeyInfo";
    self.theGame.basicInfo = @"test BasicInfo";
    self.theGame.olympicInfo = @"test OlympicInfo";
}

- (void)tearDown {
    self.dao = nil;
    [super tearDown];
}

- (void)test_1_Create
{
    int res = [self.dao create:self.theGame];
    XCTAssertTrue(res == 0,@"数据插入失败");
}

- (void)test_2_FindById
{
    self.theGame.ID = 1;
    Game *resGame = [self.dao findById:self.theGame];
    XCTAssertNotNil(resGame,@"查询记录为nil");
    XCTAssertEqualObjects(self.theGame.name, resGame.name,@"比赛项目名测试失败");
    XCTAssertEqualObjects(self.theGame.icon, resGame.icon,@"比赛项目图标测试失败");
    XCTAssertEqualObjects(self.theGame.keyInfo, resGame.keyInfo,@"项目关键信息测试失败");
    XCTAssertEqualObjects(self.theGame.basicInfo, resGame.basicInfo,@"项目基本信息测试失败");
    XCTAssertEqualObjects(self.theGame.olympicInfo, resGame.olympicInfo,@"项目历史信息测试失败");
}

- (void)test_3_FindAll
{
    NSArray *list = [self.dao findAll];
    XCTAssertTrue([list count] == 1,@"查询记录数期望值为:42 实际值为:%li",[list count]);
    Game *resGame = list[0];
    XCTAssertEqualObjects(self.theGame.name, resGame.name,@"比赛项目名测试失败");
    XCTAssertEqualObjects(self.theGame.icon, resGame.icon,@"比赛项目图标测试失败");
    XCTAssertEqualObjects(self.theGame.keyInfo, resGame.keyInfo,@"项目关键信息测试失败");
    XCTAssertEqualObjects(self.theGame.basicInfo, resGame.basicInfo,@"项目基本信息测试失败");
    XCTAssertEqualObjects(self.theGame.olympicInfo, resGame.olympicInfo,@"项目历史信息测试失败");
}

- (void)test_4_Modify
{
    self.theGame.ID = 1;
    self.theGame.name = @"test modify name";
    int res = [self.dao modify:self.theGame];
    XCTAssertTrue(res==0,@"数据修改失败");
    Game *resGame = [self.dao findById:self.theGame];
    XCTAssertNotNil(resGame,@"查询记录为nil");
    XCTAssertEqualObjects(self.theGame.name, resGame.name,@"比赛项目名测试失败");
    XCTAssertEqualObjects(self.theGame.icon, resGame.icon,@"比赛项目图标测试失败");
    XCTAssertEqualObjects(self.theGame.keyInfo, resGame.keyInfo,@"项目关键信息测试失败");
    XCTAssertEqualObjects(self.theGame.basicInfo, resGame.basicInfo,@"项目基本信息测试失败");
    XCTAssertEqualObjects(self.theGame.olympicInfo, resGame.olympicInfo,@"项目历史信息测试失败");
}

- (void)test_5_Remove
{
    int res = [self.dao remove:self.theGame];
    XCTAssertTrue(res==0,@"数据修改失败");
    Game *resGame = [self.dao findById:self.theGame];
    XCTAssertNil(resGame,@"记录删除失败");
}

@end
