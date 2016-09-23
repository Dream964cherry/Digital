//
//  PictureViewController.m
//  DigitalTechnology
//
//  Created by wmh on 16/8/13.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#define PHOTO_URL @"http://mrobot.pconline.com.cn/v2/cms/channels/11?pageSize=20&pageNo=1"

#import "PictureViewController.h"
#import "PhotoAlbumViewController.h"
#import "common.h"
#import "PhotoCell.h"
#import "GroupsModel.h"

@interface PictureViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray *groupsData;
@property (nonatomic,weak)UITableView *pictureTableView ;
@property (nonatomic,assign)NSInteger pageNO;
@property (nonatomic,weak)GroupsModel *GModel;
@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    [self getRequest];
    //下拉刷新
    _pictureTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    //上拉加载
    _pictureTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}
/**下拉刷新*/
- (void)refresh{
    [self getRequest];
    [_pictureTableView.mj_header endRefreshing];
    
}
/**上拉加载*/
- (void)loadMore{
    [self loadingData];
    [_pictureTableView.mj_footer endRefreshing];
}
/**数据请求*/
- (void)getRequest{

    [HttpRequest httpTextRequestWith:PHOTO_URL Dictionnary:nil Success:^(id reponseObject) {
        NSArray *groupsArr = reponseObject[@"groups"];
        NSMutableArray *mutArray = [NSMutableArray array];
        for (NSDictionary *dic in groupsArr) {
            GroupsModel *GModel = [GroupsModel groupsModelWithDictionary:dic];
            [mutArray addObject:GModel];
        }
        _groupsData = [mutArray copy];
        [_pictureTableView reloadData];
        
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
/**加载更多数据*/
- (void)loadingData{
    self.pageNO = 1;
    self.pageNO +=1;
    NSString *url = [NSString stringWithFormat:@"http://mrobot.pconline.com.cn/v2/cms/channels/11?pageSize=20&pageNo=%ld",self.pageNO];
  
    [HttpRequest httpTextRequestWith:url Dictionnary:nil Success:^(id reponseObject) {
        NSArray *groupsArr = reponseObject[@"groups"];
        NSMutableArray *mutArray = [NSMutableArray arrayWithArray:self.groupsData];
        for (NSDictionary *dic in groupsArr) {
            GroupsModel *GModel = [GroupsModel groupsModelWithDictionary:dic];
            [mutArray addObject:GModel];
        }
        _groupsData = mutArray  ;
        [_pictureTableView reloadData];

    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)loadDefaultSetting{
    UITableView *pictureTableView = [[UITableView alloc]init];
    pictureTableView.frame = self.view.bounds;
    pictureTableView.contentInset = UIEdgeInsetsMake(0, 0, 19, 0);
    [self.view addSubview:pictureTableView];
    
    pictureTableView.delegate = self;
    pictureTableView.dataSource = self;
    [pictureTableView setRowHeight:200];
    //tableView.estimatedRowHeight = 120;
    pictureTableView.separatorStyle = NO;
    self.pictureTableView = pictureTableView;
    
}
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.groupsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCell *cell = [PhotoCell cellWithTableView:tableView];
    GroupsModel *GModel = self.groupsData[indexPath.row];
    [cell setPmodel:GModel];
    return cell;
}
//cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupsModel *GModel = self.groupsData[indexPath.row];
    PhotoAlbumViewController *photoAlbumVC = [[PhotoAlbumViewController alloc]init];
    NSString *stringUrl = [NSString stringWithFormat:@"http://mrobot.pconline.com.cn/v2/photo/albums?modelId=%ld",(long)GModel.ID];
    photoAlbumVC.pStringUrl = stringUrl;
    [self.navigationController pushViewController:photoAlbumVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
