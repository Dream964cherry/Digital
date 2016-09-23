//
//  PhotoAlbumViewController.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PhotoAlbumViewController.h"
#import "Masonry.h"
#import "common.h"
#import "PhotosModel.h"
#import "UIImageView+WebCache.h"

@interface PhotoAlbumViewController ()
@property (nonatomic,strong)UIScrollView *photoScroll;

@property (nonatomic,strong)NSArray *photoAlbumDatas;
//当前图片页数
@property (nonatomic,weak)UILabel *labelCurrentPage;

@property(nonatomic,weak)UISwipeGestureRecognizer *leftSwipe;
@property (nonatomic,weak)UISwipeGestureRecognizer *rightSwipe;
@property (nonatomic,weak)UIImageView *imageView;
@property (nonatomic,strong)PhotosModel *PModel;
//记录当前是第几张图片
@property (nonatomic,assign)NSUInteger currentInteger;
@end

@implementation PhotoAlbumViewController

- (void)photoAlbum{
   
        [HttpRequest httpApplicationRequestWith:_pStringUrl Dictionary:nil Success:^(id reponseObject) {
            NSArray *photoArray = reponseObject[@"photos"];
            NSMutableArray *mutableArray = [NSMutableArray array];
            for (NSDictionary *dic in photoArray) {
                self.PModel = [PhotosModel photoModelWithDictionary:dic];
                [mutableArray addObject:self.PModel];
            }
            _photoAlbumDatas = mutableArray;
            [self loadDefaultSetting];
        } Failure:^(NSError *error) {
            NSLog(@"%@",error);
            
        }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self photoAlbum];
    [self barButtonItem];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationItem.title = @"相册";
    self.tabBarController.tabBar.hidden = YES;

}

- (void)barButtonItem{
    /**返回按钮*/
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.bounds = CGRectMake(0, 0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [backButton addTarget:self action:@selector(backEvent) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *downloadButton = [UIButton buttonWithType:UIButtonTypeSystem];
    downloadButton.bounds = CGRectMake(0, 0, 30, 30);
    [downloadButton setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:downloadButton];
    [downloadButton addTarget:self action:@selector(downloadImage) forControlEvents:UIControlEventTouchUpInside];
    
    
}
//布局子视图
- (void)loadDefaultSetting{
    _photoScroll = [[UIScrollView alloc]init];
    _photoScroll.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _photoScroll.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:self.photoScroll];
    //当前图片页数
    UILabel *labelCurrentPage = [[UILabel alloc]init];
    labelCurrentPage.textAlignment = NSTextAlignmentCenter;
    labelCurrentPage.textColor = [UIColor whiteColor];
    _labelCurrentPage = labelCurrentPage;
    [self.view addSubview:labelCurrentPage];
    [labelCurrentPage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(20);
        make.height.mas_equalTo(30);
    }];
    //图片
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor =[UIColor whiteColor];
    _imageView = imageView;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(labelCurrentPage.mas_bottom).offset(10);
        make.height.mas_equalTo(300);
    }];
    
    //图片标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.text = self.PModel.name;
    titleLabel.numberOfLines = 0;
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(10);
        make.trailing.mas_equalTo(self.view).offset(-10);
        make.top.mas_equalTo(imageView.mas_bottom).offset(10);
        make.height.mas_equalTo(44);
    }];
    //图片描述
    UITextView *descriptionTextView = [[UITextView alloc]init];
    descriptionTextView.text = self.PModel.desc;
    descriptionTextView.editable = NO;
    descriptionTextView.selectable = NO;
    descriptionTextView.textColor = [UIColor lightGrayColor];
    descriptionTextView.backgroundColor = [UIColor blackColor];
    descriptionTextView.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:descriptionTextView];
    [descriptionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
        make.leading.trailing.mas_equalTo(titleLabel);
        make.bottom.mas_equalTo(self.view).offset(-10);
    }];
    //向左滑
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipeAction:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipe];
    _leftSwipe =leftSwipe;
    //向右滑
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipeAction:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
    _rightSwipe = rightSwipe;
    
     [self updataData];

}
/**向左滑动手势操作*/
- (void)leftSwipeAction:(UISwipeGestureRecognizer *)leftSwipe{
    if (_leftSwipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        [UIView animateWithDuration:0.5 animations:^{
            _currentInteger ++;
        }];
    }
    [self updataData];
}
/**向右滑动手势操作*/
- (void)rightSwipeAction:(UISwipeGestureRecognizer *)rightSwipe{
    if (_rightSwipe.direction == UISwipeGestureRecognizerDirectionRight) {
        [UIView animateWithDuration:0.5 animations:^{
            _currentInteger --;
        }];
    }
    [self updataData];
}

- (void)updataData{
    if (self.currentInteger < 1) {
        self.rightSwipe.enabled = NO;
    }else{
        self.rightSwipe.enabled = YES;
    }
    if (self.currentInteger == self.photoAlbumDatas.count - 1) {
        self.leftSwipe.enabled = NO;
    }else{
        self.leftSwipe.enabled = YES;
    }
    
    self.PModel = self.photoAlbumDatas[self.currentInteger];
    _labelCurrentPage.text = [NSString stringWithFormat:@"%ld/%ld",self.currentInteger+1,self.photoAlbumDatas.count];
    
        NSString *string = [NSString stringWithFormat:@"%@",self.PModel.url];
       NSURL *imageUrl = [NSURL URLWithString:string];
        [_imageView sd_setImageWithURL:imageUrl];
    
}
//返回按钮事件
- (void)backEvent{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = ColorWithRGB(29, 122, 251);
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)downloadImage{
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(imageSave:didFinishSavingWithError:contextInfo:), nil);
    
}
- (void)imageSave:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error == nil) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"已存入手机相册" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定"
                                                         style:UIAlertActionStyleDefault handler:nil];
        [alertView addAction:defult];
        [self presentViewController:alertView animated:YES completion:nil];
    }else{
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存失败!" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertView addAction:cancel];
        [alertView addAction:defult];
        [self presentViewController:alertView animated:YES
                         completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
