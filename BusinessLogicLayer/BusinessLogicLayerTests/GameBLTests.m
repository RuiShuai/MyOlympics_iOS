//
//  GameBLTests.m
//  BusinessLogicLayer
//
//  Created by taotao on 14/12/18.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "GameBL.h"
#import "Game.h"
#import "GameDAO.h"

@interface GameBLTests : XCTestCase

@property (nonatomic,strong) GameBL *bl;
@property (nonatomic,strong) Game *theGame;

@end

@implementation GameBLTests

- (void)setUp {
    [super setUp];
    self.bl = [[GameBL alloc] init];
    self.theGame = [[Game alloc] init];
    
    self.theGame.name = @"test name";
    self.theGame.icon = @"test icon";
    self.theGame.keyInfo = @"test keyInfo";
    self.theGame.basicInfo = @"test basicInfo";
    self.theGame.olympicInfo = @"test olympicInfo";
    
    //插入测试数据
    GameDAO *dao = [GameDAO sharedManager];
    [dao create:self.theGame];
    
}

- (void)tearDown {
    //删除测试数据
    self.theGame.ID = 1;
    GameDAO *dao = [GameDAO sharedManager];
    [dao remove:self.theGame];
//    self.theGame.ID = 2;
//    [dao remove:self.theGame];
    [super tearDown];
}

-(void)testFindAll
{
    NSArray *list = [self.bl readData];
    //XCTAssertTrue([list count]==1,@"查询记录期望值为:1 实际值为:%li",[list count]);
    Game *resGame = list[0];
    XCTAssertEqualObjects(self.theGame.name, resGame.name,@"比赛项目名称测试失败");
    XCTAssertEqualObjects(self.theGame.icon, resGame.icon,@"比赛项目图标测试失败");
    XCTAssertEqualObjects(self.theGame.keyInfo, resGame.keyInfo,@"比赛关键信息测试失败");
    XCTAssertEqualObjects(self.theGame.basicInfo, resGame.basicInfo,@"比赛基本信息测试失败");
    XCTAssertEqualObjects(self.theGame.olympicInfo, resGame.olympicInfo,@"奥运会历史信息测试失败");

}


@end
