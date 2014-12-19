//
//  GameViewController.h
//  MyOlympics
//
//  Created by taotao on 14/12/19.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameBL.h"
#import "Game.h"
#import "GameViewCell.h"
#import "GameDetailViewController.h"


@interface GameViewController : UICollectionViewController
{
    NSUInteger COL_COUNT;//一行中的列数
}

@property (strong,nonatomic) NSArray *games;


@end
