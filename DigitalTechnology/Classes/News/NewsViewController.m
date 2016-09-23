//
//  NewsViewController.m
//  DigitalTechnology
//
//  Created by wmh on 16/8/13.
//  Copyright © 2016年 qingyun. All rights reserved.
//
#define NEWS_URL @"http://mrobot.pconline.com.cn/v2/cms/channels/2?pageNo=1&pageSize=20&appVersion=4.6.0"
#define IMAGE_URL @"http://mrobot.pconline.com.cn/v2/cms/channels/999?pageNo=1&pageSize=20&appVersion=4.6.0"

#import "NewsViewController.h"
#import "NewsTableViewCell.h"

#import "ArticleListModel.h"
#import "FocusModel.h"

#import "NewsDetailsViewController.h"

#import "UIImageView+WebCache.h"
#import "SDCycleScrollView.h"

#import "common.h"

#import "CarouselFigureDetailsViewController.h"


@interface NewsViewController ()  <UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

//资讯列表数据
@property (nonatomic,copy)NSArray *listDatas;
//轮播图数据
@property (nonatomic,copy)NSArray *picsDatas;

@property (nonatomic) NSInteger page;

@property (nonatomic,weak)UITableView *NewsTableView;
@end

@implementation NewsViewController

/**资讯列表数据*/
- (void)listData{
    NSDictionary *dict = @{@"pageNO":@"1",@"pageSize":@"20",@"appVersion":@"4.6.0"};
    [HttpRequest httpTextRequestWith:NEWS_URL Dictionnary:dict Success:^(id reponseObject) {
        NSArray *listArr = reponseObject[@"articleList"];
        NSMutableArray *mutArray = [NSMutableArray array];
        for (NSDictionary *dic in listArr) {
            ArticleListModel *LModel = [ArticleListModel listModelWithDictionary:dic];
            [mutArray addObject:LModel];
        }
        _listDatas = [mutArray copy];
        [_NewsTableView reloadData];
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
/**轮播图数据*/
- (void)carouselFigureData{
    
    [HttpRequest httpTextRequestWith:IMAGE_URL Dictionnary:nil Success:^(id reponseObject) {
        NSArray *focusArr = reponseObject[@"focus"];
        NSMutableArray *mutArray = [NSMutableArray array];
        
        for (NSDictionary *dict in focusArr) {
            FocusModel *focusModel = [FocusModel picsModelWithDictionary:dict];
            [mutArray addObject:focusModel];
        }
        _picsDatas = [mutArray copy];
        [self carouselFigure];
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    [self carouselFigureData];
    [self listData];
    /**下拉刷新和上拉加载*/
    _NewsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    
    _NewsTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
   
    self.navigationItem.title = @"数码科技";
}

- (void)refresh{
    [self carouselFigureData];
    [self listData];
    [_NewsTableView.mj_header endRefreshing];
    
}
- (void)loadMore{
    [self getRequest];
    [_NewsTableView.mj_footer endRefreshing];
    
}
/**轮播图*/
- (void)carouselFigure{
    
    UIScrollView *scrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    
    NSInteger count = _picsDatas.count;
    NSMutableArray *imageMutArr = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray *titleMutArr = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger index = 0; index < count; index ++) {
        FocusModel *focusModel = self.picsDatas[index];
        [imageMutArr addObject:focusModel.image];
        [titleMutArr addObject:focusModel.title];
        }
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 200) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView.pageControlAliment =  SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.titlesGroup = titleMutArr;
    // 自定义分页控件小圆标颜色
    cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    [scrView addSubview:cycleScrollView];
    //--- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView.imageURLStringsGroup = imageMutArr;
    });
    cycleScrollView.scrollDirection = UILayoutConstraintAxisVertical;
    _NewsTableView.tableHeaderView = scrView;
    
}
//布局tableView
- (void)loadDefaultSetting{
    UITableView *NewsTableView = [[UITableView alloc]init];
    NewsTableView.frame = self.view.bounds;
    NewsTableView.delegate = self;
    NewsTableView.dataSource = self;
    [NewsTableView setRowHeight:100];
    NewsTableView.separatorStyle = NO;
    _NewsTableView = NewsTableView;
    NewsTableView.tableFooterView = [UIView new];
    NewsTableView.contentInset = UIEdgeInsetsMake(0, 0, 65, 0);
    [self.view addSubview:NewsTableView];
    
    NewsTableView.tableFooterView = [UIView new];
    [NewsTableView layoutIfNeeded];
    
    


}

/**上拉加载数据*/
- (void)getRequest{
    /**改变网址的page参数的数*/
    
//    self.page = (self.page == 1) ? 2 : self.page+1;
//    
//    NSString *url = @"http://lib.wap.zol.com.cn/ipj/docList.php?class_id=0&retina=1&last_time=&vs=iph401&isReviewing=NO&page=0";
//    NSDictionary *dict = @{@"class_id":@0,@"retina":@1,@"vs":@"iph401",@"isReviewing":@"NO",@"page":@(self.page)};
    self.page = 1;
    self.page +=1;
    NSString *url = [NSString stringWithFormat:@"http://mrobot.pconline.com.cn/v2/cms/channels/2?pageSize=20&pageNo=%ld",self.page];
    [HttpRequest httpTextRequestWith:url Dictionnary:nil Success:^(id reponseObject) {
        NSArray *listArr = reponseObject[@"articleList"];
        NSMutableArray *mutArray = [NSMutableArray arrayWithArray:self.listDatas];
        for (NSDictionary *dict in listArr) {
            ArticleListModel *LModel = [ArticleListModel listModelWithDictionary:dict];
            [mutArray addObject:LModel];
        }
        self.listDatas = mutArray;
       [_NewsTableView reloadData];
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark UITableViewDegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return self.listdatas.count;
    return self.listDatas.count;
}
  
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticleListModel *model = self.listDatas[indexPath.row];
   
        NewsTableViewCell *cell = [NewsTableViewCell cellWithTableView:tableView];
        [cell setLModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
}

//cell 选中之后显示
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticleListModel *model = self.listDatas[indexPath.row];
      NewsDetailsViewController *detailsVC = [[NewsDetailsViewController alloc]init];
//    NSString *strUrl = [NSString stringWithFormat:@"http://mrobot.pconline.com.cn/v3/cms/articles/%@?articleTemplate=3.6.0&channelId=2&size=18&picRule=2&app=pconlinebrowser&template=(null)&appVersion=4.6.0&platform=android&deviceModel=F105&resVer=43002",model.ID ];
    NSString *strUrl = [NSString stringWithFormat:@"http://mrobot.pconline.com.cn/v3/cms/articles/%@",model.ID];
    detailsVC.urlWeb = strUrl;
    [self.navigationController pushViewController:detailsVC animated:YES];
//
}

/**资讯上拉加载调用*/
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    if (_NewsTableView.contentOffset.y > _NewsTableView.contentSize.height - _NewsTableView.frame.size.height) {
//        [self getRequest];
//    }
//}
#pragma mark SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    FocusModel *focus = self.picsDatas[index];
    NSString *urlString = [NSString stringWithFormat:@"http://mrobot.pconline.com.cn/v3/cms/articles/%@",focus.Id];
        CarouselFigureDetailsViewController *CFDVC = [CarouselFigureDetailsViewController new];

    CFDVC.picsUrl = urlString;
    [self.navigationController pushViewController:CFDVC animated:YES];
}
@end
