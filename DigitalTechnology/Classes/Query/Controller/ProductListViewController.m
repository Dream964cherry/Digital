//
//  ProductListViewController.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ProductListViewController.h"
#import "ProductListModel.h"
#import "common.h"
#import "ProductListCell.h"
#import "ProductDetailsViewController.h"

@interface ProductListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy) NSArray *PLArray;
@property (nonatomic,strong)UITableView *productListTableView;
@property (nonatomic,weak) ProductListModel *PLModel;
@property (nonatomic, assign) NSInteger page;
@end

@implementation ProductListViewController
- (NSArray *)PLArray{
    if (!_PLArray) {
        [HttpRequest httpTextRequestWith:self.moreUrl Dictionnary:self.moreDict Success:^(id reponseObject) {
            NSArray *PL = reponseObject[@"data"];
            NSMutableArray *mutArr = [NSMutableArray array];
            for (NSDictionary *dict in PL) {
                ProductListModel *PLModel = [ProductListModel productListModelWithDictionary:dict];
                [mutArr addObject:PLModel];
            }
            self.PLArray = [mutArr copy];
            [self.productListTableView reloadData];
        } Failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    return _PLArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"产品列表";
    [self refresh];
    self.page = 1;
}
- (void)refresh{
    _productListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullRefresh)];
    _productListTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}
- (void)pullRefresh{
    [self setPLArray:self.PLArray];
    
    [self.productListTableView.mj_header endRefreshing];
    
}
/**上拉加载更多*/
- (void)loadMore{
    [self loadMoreData];
//    [_productListTableView.mj_footer endRefreshing];
}
- (void)loadMoreData{
    
    self.page += 1;
    NSArray *a = [self.moreUrl componentsSeparatedByString:@"page=1"];
    NSString *s = [a componentsJoinedByString:[NSString stringWithFormat:@"page=%ld",self.page]];
    [HttpRequest httpTextRequestWith:s Dictionnary:_moreDict Success:^(id reponseObject) {
         [_productListTableView.mj_footer endRefreshing];
              NSArray *PL = reponseObject[@"data"];
            NSMutableArray *mutArr = [NSMutableArray arrayWithArray:self.PLArray];
            for (NSDictionary *dict in PL) {
                ProductListModel *PLModel = [ProductListModel productListModelWithDictionary:dict];
                [mutArr addObject:PLModel];
            }
            self.PLArray = mutArr;
            [self.productListTableView reloadData];

    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    [_productListTableView.mj_footer endRefreshing];

}
- (void)loadDefaultSetting{
    self.productListTableView = [[UITableView alloc]init];
    self.productListTableView.frame = self.view.bounds;
    self.productListTableView.estimatedRowHeight = 80;
    self.productListTableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    [self.view addSubview:_productListTableView];
    _productListTableView.delegate = self;
    _productListTableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.PLArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.PLModel = self.PLArray[indexPath.row];
    ProductListCell *PLCell = [ProductListCell cellWithTableView:tableView];
    [PLCell setPLModel:self.PLModel];
    return PLCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailsViewController *productDetailsVC = [[ProductDetailsViewController alloc]init];
    self.PLModel = self.PLArray[indexPath.row];
    if ([_PLModel.seriesId isEqualToString:@"0"]) {
        NSString *string = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Advanced_ProDetail_V4&proId=%@&provinceId=22&cityId=260&vs=and433",_PLModel.Id];
        productDetailsVC.detailUrl = string;
    } else{
        NSString *string = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Advanced_SeriesDetail_V4&seriesId=%@&provinceId=22&cityId=260&vs=and433",_PLModel.seriesId];
        productDetailsVC.detailUrl = string;
    }
    [self.navigationController pushViewController:productDetailsVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
