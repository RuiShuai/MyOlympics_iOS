//
//  GameViewController.m
//  MyOlympics
//
//  Created by taotao on 14/12/19.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //如果是iPhone设备,列数为2
        COL_COUNT = 2;
    } else {
        //如果是iPad设备,列数为5
        COL_COUNT = 5;
    }
    
    self.navigationItem.title = @"Games";
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    if (self.games == nil || [self.games count] == 0) {
        GameBL *bl = [[GameBL alloc]init];
        //获取全部数据
        NSMutableArray *array = [bl readData];
        self.games = array;
        [self.collectionView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        Game *game = [self.games objectAtIndex:(indexPath.section * COL_COUNT + indexPath.row)];
        GameDetailViewController *detailVC = [segue destinationViewController];
        detailVC.detailItem = game;
    }
    
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.games count]/COL_COUNT;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return COL_COUNT;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //初始化CollectionViewCell
    GameViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gameCell" forIndexPath:indexPath];
    Game *game = [self.games objectAtIndex:(indexPath.section * COL_COUNT + indexPath.row)];
    cell.imageView.image = [UIImage imageNamed:game.icon];
   
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
