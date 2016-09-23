//
//  ProductDetailsViewController.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "ProInfoView.h"
#import "ParameterFooterView.h"
#import "ParameterCell.h"
#import "Masonry.h"
#import "common.h"
#import "ProductDetailsInfoModel.h"
#import "ProductSortParamModel.h"

#import "ProductPictureViewController.h"
#import "ProductParametersViewController.h"

@interface ProductDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,copy) NSArray *sortParamArr;
@property (nonatomic,weak) UITableView *parameterTableView;
@property (nonatomic, strong) NSString *strId;
@property (nonatomic, strong) NSString *strSubcateId;
@property (nonatomic, strong) NSString *strseriesId;
@end

@implementation ProductDetailsViewController

- (void)viewWillAppear:(BOOL)animated{
    [self getProductDetailData];
    [self sortParamData];
}
- (void)getProductDetailData{
    [HttpRequest httpTextRequestWith:self.detailUrl Dictionnary:nil Success:^(id reponseObject) {
        NSDictionary *PDL = reponseObject[@"proInfo"];
        ProductDetailsInfoModel *model = [ProductDetailsInfoModel detailsModelWithDictionary:PDL];
        [self setWithModel:model];
//        [self getImageData:model];

    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
        [HttpRequest httpApplicationRequestWith:self.detailUrl Dictionary:nil Success:^(id reponseObject) {
            NSDictionary *PDL = reponseObject[@"seriesInfo"];
            ProductDetailsInfoModel *model = [ProductDetailsInfoModel detailsModelWithDictionary:PDL];
            [self setWithModel:model];
        } Failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }];
}

- (void)sortParamData{
        [HttpRequest httpTextRequestWith:self.detailUrl Dictionnary:nil Success:^(id reponseObject) {
            NSArray *paramArr = reponseObject[@"sortParam"];
            NSMutableArray *mutArr = [NSMutableArray array];
            for (NSDictionary *dict in paramArr) {
                ProductSortParamModel *PSPModel = [ProductSortParamModel parameterModelWithDictionary:dict];
                [mutArr addObject:PSPModel];
            }
            self.sortParamArr = [mutArr copy];
            [self.parameterTableView reloadData];
        } Failure:^(NSError *error) {
            NSLog(@"%@",error);
            [HttpRequest httpApplicationRequestWith:self.detailUrl Dictionary:nil Success:^(id reponseObject) {
            } Failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"产品详情";
    [self loadDefaultSetting];
}

- (void)loadDefaultSetting{
    UITableView *parameterTableView = [[UITableView alloc]init];
    parameterTableView.frame = self.view.bounds;
    parameterTableView.delegate = self;
    parameterTableView.dataSource = self;
    parameterTableView.estimatedRowHeight = 30;
    parameterTableView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
    parameterTableView.layoutMargins = UIEdgeInsetsZero;
    [self.view addSubview:parameterTableView];
    self.parameterTableView = parameterTableView;
    //tableView的footerView
    ParameterFooterView *moreParameter = [[ParameterFooterView alloc]init];
    moreParameter.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //Button的响应事件
    [moreParameter setBlocButtonParameter:^(UIButton *btn) {
        ProductParametersViewController *productParametersVC = [[ProductParametersViewController alloc]init];
        NSString *parStr = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Android_38o_ProParam&proId=%@",self.strId];
        
        productParametersVC.parameterUrl = parStr;
        [self.navigationController pushViewController:productParametersVC animated:YES];
    }];
    moreParameter.frame = CGRectMake(0, 0, ScreenWidth, 30);
//    [parameterTableView addSubview:moreParameter];
    parameterTableView.tableFooterView = moreParameter;
    
}
- (void)setWithModel:(ProductDetailsInfoModel *) model{
    ProInfoView *proInfo = [[ProInfoView alloc]init];
    proInfo.backgroundColor = [UIColor groupTableViewBackgroundColor];
    proInfo.bounds = CGRectMake(0, 0, ScreenWidth, 470);
    [proInfo setPDIModel:model];
    [_parameterTableView addSubview:proInfo];
    _parameterTableView.tableHeaderView = proInfo;
    self.strId = model.Id;
    self.strSubcateId = model.subcateId;
    self.strseriesId = model.seriesId;
    [proInfo.loadMoreImage addTarget:self action:@selector(getImageData) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark UITableViewDegelate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sortParamArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductSortParamModel *model = self.sortParamArr[indexPath.row];
    ParameterCell *PCell = [ParameterCell cellWithTableView:tableView];
    [PCell setPSPModel:model];
        return PCell;
}
- (void)getImageData{
    ProductPictureViewController *productPictureVC = [[ProductPictureViewController alloc]init];
    if (self.strseriesId == nil) {
        NSString *PUrl = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Advanced_Picture_V1&seriesId=%@&subcateId=%@",self.strId,self.strSubcateId];
        productPictureVC.picURL = PUrl;
    }else{
        NSString *pictureUrl = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Advanced_Picture_V1&proId=%@&subcateId=%@",self.strId,self.strSubcateId];
        productPictureVC.picURL = pictureUrl;
    }
    [self.navigationController pushViewController:productPictureVC animated:YES];
}
@end
