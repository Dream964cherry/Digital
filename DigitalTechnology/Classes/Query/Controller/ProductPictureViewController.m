//
//  ProductPictureViewController.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ProductPictureViewController.h"
#import "common.h"
#import "PictureNameModel.h"
#import "ImagesModel.h"
#import "PictureHeaderView.h"
#import "UIImageView+WebCache.h"

#import "MorePictureViewController.h"

@interface ProductPictureViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *pictureCollectionView;
@property (nonatomic,copy)NSArray *picNameArr;
@end
//cell的标志符
static NSString *const strIdentifier = @"UICollectionViewCell";
//header的标志符
static NSString * const strIdHeader = @"strIdHeader";
@implementation ProductPictureViewController

- (NSArray *)picNameArr{
    if (!_picNameArr) {
        [HttpRequest httpTextRequestWith:self.picURL Dictionnary:nil Success:^(id reponseObject) {
            NSArray *PN = reponseObject[@"category"];
            NSMutableArray *mutArr = [NSMutableArray array];
            for (NSDictionary *dict in PN) {
                PictureNameModel *PNModel = [PictureNameModel nameModelWithDictionary:dict];
                [mutArr addObject:PNModel];
            }
            _picNameArr = [mutArr copy];
            [self.pictureCollectionView reloadData];
        } Failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    return _picNameArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"产品图片";
    [self loadDefaultSetting];
}
- (void)loadDefaultSetting{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (ScreenWidth - 8) * 0.5;
    CGFloat height = width * 0.7;
    flowLayout.itemSize = CGSizeMake(width, height);
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.sectionInset =UIEdgeInsetsMake(1,1, 1, 1);

    //设置header的高度
    flowLayout.headerReferenceSize = CGSizeMake(44, 44);
    
    self.pictureCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    //注册一个cell
    [self.pictureCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:strIdentifier];
    // 注册一个Header
    [self.pictureCollectionView registerClass:[PictureHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:strIdHeader];
    //
    _pictureCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.pictureCollectionView.delegate = self;
    self.pictureCollectionView.dataSource = self;
    
    self.pictureCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 65, 0);
    [self.view addSubview:self.pictureCollectionView];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.picNameArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    PictureNameModel *PNModel  = self.picNameArr[section];
    return PNModel.imagesArr.count;
}
/**cell注册*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:strIdentifier forIndexPath:indexPath];
    UIImageView *picture = [[UIImageView alloc]initWithFrame:cell.bounds];
    PictureNameModel *PNModel = self.picNameArr[indexPath.section];
    ImagesModel *imgModel = PNModel.imagesArr[indexPath.item];
    [picture sd_setImageWithURL:[NSURL URLWithString:imgModel.picSrc]];
    [cell addSubview:picture];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
/**Header注册*/
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        PictureHeaderView *headerView =(PictureHeaderView *) [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:strIdHeader forIndexPath:indexPath];
        PictureNameModel *PNModel =self.picNameArr[indexPath.section];
        [headerView setPNModel:PNModel];
        headerView.backgroundColor = [UIColor whiteColor];
        [headerView setHeaderTapEventBlock:^{
            MorePictureViewController *morePictureVC = [[MorePictureViewController alloc]init];
            NSString *picString = [NSString stringWithFormat:@"%@&classId=%@",self.picURL,PNModel.categoryId];
            morePictureVC.morePicUrl = picString;
            [self.navigationController pushViewController:morePictureVC animated:YES];
        }];
        reusableview = headerView;
    }
    return reusableview;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
