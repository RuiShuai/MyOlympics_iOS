//
//  GameDetailViewController.m
//  MyOlympics
//
//  Created by taotao on 14/12/19.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import "GameDetailViewController.h"

@interface GameDetailViewController ()

@end

@implementation GameDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条标题
    self.navigationItem.title = self.detailItem.name;
    
    self.imgGameIcon.image = [UIImage imageNamed:self.detailItem.icon];
    self.lblGameName.text = self.detailItem.name;
    self.txtViewBasicInfo.text = self.detailItem.basicInfo;
    self.txtViewKeyInfo.text = self.detailItem.keyInfo;
    self.txtViewOlympicInfo.text = self.detailItem.olympicInfo;
    
    //初始化scrollView frame
    self.scrollView.frame = self.view.frame;
    self.scrollView.contentInset = UIEdgeInsetsMake(-50, 0, 0, 0);//top,left,bottom,right;
    
    self.scrollView.contentSize = CGSizeMake(320, 900);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
