//
//  CountDownViewController.m
//  MyOlympics
//
//  Created by taotao on 14/12/19.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import "CountDownViewController.h"

@interface CountDownViewController ()

@end

@implementation CountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建NSDateComponents对象
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    [comps setDay:5];
    [comps setMonth:8];
    [comps setYear:2016];
    
    //创建日历对象
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //获得2016-08-05的NSDate日期对象
    NSDate *VEDay = [calendar dateFromComponents:comps];
    //获得当前日期到2016-08-05的NSDateComponents对象
    NSDateComponents *components = [calendar components:NSDayCalendarUnit fromDate:[NSDate date] toDate:VEDay options:0];
    //获得当前日期到2016-08-05相差的天数
    int days = (int)[components day];
    
    //使用TextKit格式化倒计时字符串
    NSMutableAttributedString *attributedTextHolder = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%i天",days]];
    [attributedTextHolder addAttribute:NSFontAttributeName value:[UIFont preferredFontForTextStyle:UIFontTextStyleBody] range:NSMakeRange(attributedTextHolder.length-1, 1)];
    self.lblCountDown.attributedText = attributedTextHolder;
    
    
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
