//
//  ProductParametersViewController.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ProductParametersViewController.h"
#import "common.h"
#import "DetailsParameterCell.h"

@interface ProductParametersViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) UITableView *parameterTableView;
@property (nonatomic, strong) NSMutableArray *arrName;
@property (nonatomic, strong) NSMutableArray*arrCanshu;
@end

@implementation ProductParametersViewController
- (void)getParameterData{
    [HttpRequest httpTextRequestWith:self.parameterUrl Dictionnary:nil Success:^(id reponseObject) {
        _arrName = [NSMutableArray array];
         _arrCanshu = [NSMutableArray array];
        for (NSDictionary *dic in reponseObject) {
            for (NSString *arr in dic) {
                [_arrName addObject:arr];
                [_arrCanshu addObject:dic[arr]];
            }
    };
        [self.parameterTableView reloadData];
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"详细参数";
    [self getParameterData];
    [self loadDefaulSetting];
    
}
- (void)loadDefaulSetting{
    UITableView *parameterTableView = [[UITableView alloc]init];
    parameterTableView.frame = self.view.bounds;
    parameterTableView.delegate = self;
    parameterTableView.dataSource = self;
    parameterTableView.estimatedRowHeight = 50;
    parameterTableView.contentInset = UIEdgeInsetsMake(0, 0, 65, 0);

    [self.view addSubview:parameterTableView];
    self.parameterTableView = parameterTableView;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arrName.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.arrName[section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.arrCanshu[section];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsParameterCell *detailParamCell = [DetailsParameterCell detailsParaCellWithTableView:tableView];
    NSArray *arr = self.arrCanshu[indexPath.section];
    NSMutableArray *arrM = [NSMutableArray array];
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *arrMut = [NSMutableArray array];
    for (NSDictionary *s in arr) {
        [arrM addObject:s];
        for (NSString *str in s) {
            [array addObject:str];
            [arrMut addObject:s[str]];
        }
    }
    detailParamCell.keyLabel.text = array[indexPath.row];
    detailParamCell.valueLabel.text = arrMut[indexPath.row];
    return detailParamCell;
}
@end
