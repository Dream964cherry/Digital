//
//  QueryViewController.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QueryViewController.h"
#import "Masonry.h"
#import "common.h"

#import "DigitalNameSortCell.h"
#import "BrandNameCell.h"

#import "DigitalModel.h"
#import "BrandListModel.h"
#import "BrandModel.h"

#import "ProductListViewController.h"


@interface QueryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *nameSortTableView;
@property (nonatomic,weak) UITableView *brandNameTableView;
//判断是否为subArr数组；
@property (nonatomic) BOOL isSubarray;
//左边的数据
@property (nonatomic,copy) NSArray *digitalArr;
//品牌的数组
@property (nonatomic,copy) NSArray *brandArr;
//右边的TableView数组
@property (nonatomic, copy) NSArray *rightBrandArray;
//左边TableView的模型
@property (nonatomic,strong) DigitalModel *DiModel;
//右边TableView的模型
@property (nonatomic,strong) BrandListModel *abcModel;
//右边分类的数组
@property (nonatomic, copy) NSArray *subArray;

@property (nonatomic, assign) NSInteger page;

@end

@implementation QueryViewController
- (NSArray *)rightBrandArray{
    if (!_rightBrandArray) {
        _rightBrandArray = [[NSArray alloc]init];
    }
  return   _rightBrandArray;
}
//右边的产品分类
- (NSArray *)subArray{
    if (!_subArray) {
        //数据路径
        NSString *path = [[NSBundle mainBundle]pathForResource:@"Digital" ofType:@"plist"];
        NSArray *aray = [NSArray arrayWithContentsOfFile:path];
        NSInteger count = aray.count;
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
        for (NSInteger index =0; index<count; index ++) {
            DigitalModel *model = [DigitalModel digitalModelWithDictionnary:aray[index]];
            [arrayM addObject:model];
        }
        _subArray = [arrayM copy];
    }
    return _subArray;
}
/**数码产品数据*/
- (void)getData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Digital" ofType:@"plist"];
    NSArray *arr = [[NSArray alloc]initWithContentsOfFile:path];
    NSMutableArray *mutArr = [NSMutableArray arrayWithCapacity:arr.count];
    for (NSDictionary *dic in arr) {
        self.DiModel = [DigitalModel digitalModelWithDictionnary:dic];
        [mutArr addObject:_DiModel];
    }
    
    _digitalArr = [mutArr copy];
    [_nameSortTableView reloadData];
    //默认选中左边TableView的首行
    [self.nameSortTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self deFaultClikFist];
    [self loadDefaultSetting];
    [self getData];
    [self getBrandData:_DiModel.subId complete:nil];
    //第一次进入时选中刷新的数据
    
}
//- (void)viewWillAppear:(BOOL)animated{
//    [self deFaultClikFist];
//}
/**布局子视图*/
- (void)loadDefaultSetting{
    //数码产品分类
    UITableView *nameSortTableView = [[UITableView alloc]init];
    nameSortTableView.delegate = self;
    nameSortTableView.dataSource = self;
    [self.view addSubview:nameSortTableView];
    [nameSortTableView setRowHeight:45];
    [nameSortTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.leading.mas_equalTo(self.view);
        make.width.mas_equalTo(140);
    }];
    nameSortTableView.tag = 100;
    _nameSortTableView = nameSortTableView;
    //左右TableView之间的分隔线
    UIView *CuttingLineView = [UIView new];
    CuttingLineView.backgroundColor = ColorWithRGB(90.20, 102.20, 102.20);
    [self.view addSubview:CuttingLineView];
    [CuttingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.view);
        make.leading.mas_equalTo(nameSortTableView.mas_trailing);
        make.width.mas_equalTo(1);
    }];
    //品牌分类
    UITableView *brandNameTableView = [[UITableView alloc]init];
    brandNameTableView.delegate = self;
    brandNameTableView.dataSource = self;
    brandNameTableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    [self.view addSubview:brandNameTableView];
    [brandNameTableView setRowHeight:70];
    [brandNameTableView setSectionHeaderHeight:30];
    [brandNameTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.trailing.mas_equalTo(self.view);
        make.leading.mas_equalTo(CuttingLineView.mas_trailing);
    }];
    brandNameTableView.tag = 101;
    _brandNameTableView = brandNameTableView;
    
}
/**品牌数据*/
- (void)getBrandData:(NSString *)str complete:(void(^)())complete{
    //请求品牌数据的网址
    NSString *strUrl = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Android_38o_ManuList&subcateId=%@&noParam=1&vs=and433",str];
    [HttpRequest httpTextRequestWith:strUrl Dictionnary:nil Success:^(id reponseObject) {
        //热门品牌里的数据
        NSArray *rank = reponseObject[@"rank"];
        //按首字母区分的品牌数据
        NSDictionary *dict = reponseObject[@"abc"];
        //所有品牌的首字母
        NSInteger count = dict.allKeys.count;
        //首字母排序
        NSArray *allkeys = [dict.allKeys  sortedArrayUsingSelector:@selector(compare:)];
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
        //热门的数据
        BrandListModel *rankModel = [BrandListModel abcModelWithDict:rank withKeys:@""];
        [arrayM addObject:rankModel];
        
        [dict writeToFile:@"/Users/qingyun/Desktop/aaaa.plist" atomically:YES];
        
        for (NSInteger index = 0; index <count ; index++) {
            NSArray *arr = dict[allkeys[index]];
            //按首字母取数据
            BrandListModel *model = [BrandListModel abcModelWithDict:arr withKeys:allkeys[index]];
            [arrayM addObject:model];
        }
        self.brandArr = [arrayM copy];
        if (complete) {
            complete();
        }
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}
#pragma mark UITableViewDelegate
/**返回右边TableView的Header个数*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag == 100) {
        return 1;
    }else {
        if (_isSubarray) {
            return 1;
        }else{
            //return _allKey.count;
            return self.rightBrandArray.count;
        }
    }
    return 0;
}
/**返回右边TableView的Header的字段*/
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 100) {
        return nil;
    }else{
        if (section ==0) {
            if (_isSubarray) {
                return nil;
            }else{
                return @"热门品牌";
            }
         }
        BrandListModel *abcModel = self.rightBrandArray[section];
        NSString *headerStr = abcModel.keys;
        return headerStr;
       // return @"aaaa";
    }
}
/**返回cell的个数*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 100) {
        return self.digitalArr.count;
    }else {
        if (_isSubarray) {
            return self.rightBrandArray.count;
//            return self.subArray.count;
        }
        BrandListModel *abcModel = self.rightBrandArray[section];
        return abcModel.brandArr.count;
    };
}

//第一次进入时选中刷新的数据
- (void)deFaultClikFist{
    DigitalModel *model = self.digitalArr[0];
    if ([model.type isEqualToString:@"cate"]) {
        _isSubarray = YES;
        self.rightBrandArray = model.subArr;
        [_brandNameTableView reloadData];
        [_nameSortTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }else{
        _isSubarray = NO;
        _DiModel = self.digitalArr[0];
        [self getBrandData:_DiModel.subId complete:^{
            self.rightBrandArray = [self.brandArr copy];
            [self.brandNameTableView reloadData];
        }];
    }
}
/**选中左边TableView中cell*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 100 ) {
        DigitalModel *model = self.digitalArr[indexPath.row];
        if ([model.type isEqualToString:@"cate"]) {
            _isSubarray = YES;
            self.rightBrandArray = model.subArr;
            [_brandNameTableView reloadData];
            [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        }else{
            _isSubarray = NO;
            _DiModel = self.digitalArr[indexPath.row];

            [self getBrandData:_DiModel.subId complete:^{
                self.rightBrandArray = [self.brandArr copy];
                [self.brandNameTableView reloadData];

            }];
        }
    }else{
        ProductListViewController *productListVC = [[ProductListViewController alloc]init];
        if (_isSubarray) {
            subArrayModel *model = self.rightBrandArray[indexPath.row];
            NSString *stringUrl = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php"];
            NSString *str = [NSString stringWithFormat:@"%@",model.Id];
            self.page = 1;
//            self.page = self.page + 1;
            NSString *paStr = [NSString stringWithFormat:@"%ld",self.page];
            NSDictionary *dict = @{@"c":@"Advanced_List_V1",@"subcateId":str,@"orderBy":@"1",@"page":paStr,@"locationId":@"1"};
            productListVC.moreUrl = stringUrl;
            productListVC.moreDict = dict;
        }else{
            BrandListModel *model = self.rightBrandArray[indexPath.section];
            BrandModel *brandModel = model.brandArr[indexPath.row];
            //加载更多
            self.page = 1;
//            self.page +=1;
            NSString *Url = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Advanced_List_V1&subcateId=%@&manuId=%@&orderBy=1&page=%ld&locationId=1",_DiModel.subId,brandModel.strId,self.page];
            productListVC.moreUrl = Url;
            productListVC.moreDict = nil;
        }
        [self.navigationController pushViewController:productListVC animated:YES];
    }
}
#pragma  mark Cell
/**判断返回cell*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 100) {
        DigitalNameSortCell *sortCell = [DigitalNameSortCell cellWithTableView:tableView];
        DigitalModel *model = self.digitalArr[indexPath.row];
        [sortCell setDiModel:model];
        return sortCell;
    }else {
        if (_isSubarray) {
            //右边的第二种cell
            subArrayModel *model = self.rightBrandArray[indexPath.row];
            static NSString *strIdentifier = @"UITableViewCell";
            UITableViewCell *tabCell = [tableView dequeueReusableCellWithIdentifier:strIdentifier];
            if (!tabCell) {
            tabCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdentifier];
            }
            tabCell.textLabel.text = model.name;
            return tabCell;
        }else{
            //品牌列表cell
        BrandListModel *model = self.rightBrandArray[indexPath.section];
        BrandNameCell *brandCell = [BrandNameCell cellWithTableView:tableView];
        BrandModel *brandModel = model.brandArr[indexPath.row];
        [brandCell setBrandModel:brandModel];
           return brandCell;
        }
    }
}

@end
