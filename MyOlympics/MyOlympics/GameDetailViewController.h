//
//  GameDetailViewController.h
//  MyOlympics
//
//  Created by taotao on 14/12/19.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface GameDetailViewController : UIViewController

@property (nonatomic,strong) Game *detailItem;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lblGameName;
@property (weak, nonatomic) IBOutlet UIImageView *imgGameIcon;
@property (weak, nonatomic) IBOutlet UITextView *txtViewKeyInfo;
@property (weak, nonatomic) IBOutlet UITextView *txtViewBasicInfo;
@property (weak, nonatomic) IBOutlet UITextView *txtViewOlympicInfo;

@end
