//
//  MorePictureViewController.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MorePictureViewController.h"
#import "common.h"
#import "PictureModel.h"
#import "UIImageView+WebCache.h"

@interface MorePictureViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *morePicCollection;
@property (nonatomic,copy) NSArray *pictureArr;
@end
static NSString *const strIdentifier = @"STRCELL";
@implementation MorePictureViewController
- (void)getPictureData{
    [HttpRequest httpTextRequestWith:self.morePicUrl Dictionnary:nil Success:^(id reponseObject) {
        NSDictionary *P = reponseObject[@"category"];
        NSArray *arr = P[@"images"];
        //NSLog(@"%@",arr);
        NSMutableArray *mutArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            PictureModel *PModel = [PictureModel pictureModelWithDictionary:dict];
            [mutArr addObject:PModel];
        }
        self.pictureArr = [mutArr copy];
        [self.morePicCollection reloadData];
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadDefaultSetting];
    [self getPictureData];
}
- (void)loadDefaultSetting{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat speace = 10;
    CGFloat width = (ScreenWidth - speace * 4)/3;
    CGFloat height = width * 0.7;
    flowLayout.itemSize = CGSizeMake(width, height);
    flowLayout.minimumLineSpacing = speace;
    flowLayout.minimumInteritemSpacing = speace;
    flowLayout.sectionInset = UIEdgeInsetsMake(speace, speace, 0, speace);
    self.morePicCollection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.morePicCollection.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //注册cell
    [self.morePicCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:strIdentifier];
    self.morePicCollection.delegate = self;
    self.morePicCollection.dataSource = self;
    [self.view addSubview:self.morePicCollection];
    _morePicCollection.contentInset = UIEdgeInsetsMake(0, 0, 65, 0);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.pictureArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:strIdentifier forIndexPath:indexPath];
    UIImageView *images = [[UIImageView alloc]initWithFrame:cell.bounds];
    

    PictureModel *PModel = self.pictureArr[indexPath.item];
    [images sd_setImageWithURL:[NSURL URLWithString:PModel.picSrc]];
    [cell addSubview:images];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
//点击cell 实现图片浏览
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = ScreenWidth *1.2;
    CGFloat Y = (ScreenHeight- height) * 0.5;
    
    UIScrollView *bgView = [[UIScrollView alloc] init];
    bgView.frame = [UIScreen mainScreen].bounds;
    bgView.pagingEnabled = YES;
    bgView.backgroundColor = [UIColor blackColor];
    
    [UIView animateWithDuration:1.0 animations:^{
        NSUInteger count = self.pictureArr.count;
        for (NSInteger index = 0; index < count; index ++) {
            UIImageView *bigImage = [[UIImageView alloc]init];
            bigImage.contentMode = UIViewContentModeScaleAspectFit;
//            bigImage.contentMode = UIViewContentModeScaleToFill;
//            bigImage.clipsToBounds = YES;
            bigImage.frame = CGRectMake(index * ScreenWidth, Y, ScreenWidth, height);
            PictureModel *PModel = self.pictureArr[index];
            [bigImage sd_setImageWithURL:[NSURL URLWithString:PModel.bigPic]];
            [bgView addSubview:bigImage];
        }
        bgView.contentSize = CGSizeMake(count * ScreenWidth, 0);
        [[[UIApplication sharedApplication] keyWindow] addSubview:bgView];
    }];
    //添加手势返回
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScroll:)];
    [bgView addGestureRecognizer:tap];
    bgView.userInteractionEnabled = YES;
    
}

- (void)tapScroll:(UITapGestureRecognizer *)tapgester {
    [UIView animateWithDuration:1.0 animations:^{
        [tapgester.view removeFromSuperview];
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
