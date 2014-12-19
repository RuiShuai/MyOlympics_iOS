//
//  ScheduleViewController.m
//  MyOlympics
//
//  Created by taotao on 14/12/19.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import "ScheduleViewController.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.data == nil || [self.data count] == 0) {
        //从后台获取数据
        ScheduleBL *bl = [ScheduleBL new];
        self.data = [bl readData];
        NSArray *keys = [self.data allKeys];
        //对key进行排序
        self.arrayGameDateList = [keys sortedArrayUsingSelector:@selector(compare:)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSArray *keys = [self.data allKeys];
    //NSLog(@"sections:%li",[keys count]);
    return [keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //比赛日期
    NSString *strGameDate = [self.arrayGameDateList objectAtIndex:section];
    //比赛日期下的日程表
    NSArray *schedules = [self.data objectForKey:strGameDate];
    //NSLog(@"rows in Section:%li",[schedules count]);
    return [schedules count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //比赛日期
    NSString *strGameDate = [self.arrayGameDateList objectAtIndex:section];
    return strGameDate;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //比赛日期
    NSString *strGameDate = [self.arrayGameDateList objectAtIndex:indexPath.section];
    //比赛日期下的日程表
    NSArray *schedules = [self.data objectForKey:strGameDate];
    Schedule *schedule = [schedules objectAtIndex:indexPath.row];
    //NSLog(@"%@",schedule);
    // Configure the cell...
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    //NSLog(@"the cell is:%@",cell);
    NSString *subtitle = [[NSString alloc]initWithFormat:@"%@ | %@",schedule.info,schedule.game.name];
    cell.textLabel.text = schedule.time;
    cell.detailTextLabel.text = subtitle;
    return cell;
}

//添加表索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *listTitles = [[NSMutableArray alloc]init];
    //2016-08-09 -> 08-09
    for (NSString *item in self.arrayGameDateList) {
        //截掉年份,作为索引
        NSString *title = [item substringFromIndex:5];
        [listTitles addObject:title];
    }
    return listTitles;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
