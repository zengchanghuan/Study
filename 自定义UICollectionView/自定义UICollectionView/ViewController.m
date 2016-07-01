//
//  ViewController.m
//  自定义UICollectionView
//
//  Created by ZengChanghuan on 16/6/30.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "ViewController.h"
#import "XZCollectionViewCell.h"
#import "XZLineLayout.h"
static NSString *ID = @"CELLID";

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *imagesArray;
@end

@implementation ViewController

-(NSMutableArray *)imagesArray
{
    if (!_imagesArray) {
        self.imagesArray = [[NSMutableArray alloc] init];
        for (int i = 0; i <= 20; ++i) {
            [self.imagesArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _imagesArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect rect = CGRectMake(0, 100, 320, 320);
    UICollectionView *collectView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:[XZLineLayout new]];
    collectView.dataSource = self;
    collectView.delegate = self;
    [collectView registerNib:[UINib nibWithNibName:@"XZCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectView];
    
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imagesArray.count;
}

#pragma mark UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XZCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imageName = self.imagesArray[indexPath.item];
    return cell;
}
@end
