//
//  ViewController.m
//  自定义collectionView布局
//
//  Created by ma c on 15/10/9.
//  Copyright (c) 2015年 梁学. All rights reserved.
//

#import "ViewController.h"
#import "LXImagesCell.h"

#import "LXLineLayout.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSMutableArray *images;

@property (nonatomic,weak)UICollectionView *collectionView;


@end

@implementation ViewController

static NSString *const ID = @"image";

- (NSMutableArray *)images{
    if (!_images) {
        self.images = [[NSMutableArray alloc]init];
        for (int i = 1; i <= 20 ; i++) {
            [self.images addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat w = self.view.frame.size.width;
    CGRect rect = CGRectMake(0, 100, w, 200);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:[[LXLineLayout alloc]init]];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerNib:[UINib nibWithNibName:@"LXImagesCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[LXLineLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[LXLineLayout alloc]init] animated:YES];
    }else{
        [self.collectionView setCollectionViewLayout:[[UICollectionViewLayout alloc]init] animated:YES];
    }
}

#pragma mark- CollectionView Deleagte

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LXImagesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];

    cell.image = self.images[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    //删除模型数据
    [self.images removeObjectAtIndex:indexPath.item];
    //刷新ui
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

@end
