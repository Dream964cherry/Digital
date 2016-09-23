//
//  ViewController.m
//  DigitalTechnology
//
//  Created by wmh on 16/8/13.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MainViewController.h"
#import "NewsViewController.h"
#import "QueryViewController.h"
#import "PictureViewController.h"
#import "MainNavigationController.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NewsViewController *NewsVC = [NewsViewController new];
    [self addViewController:NewsVC ImageName:@"News" title:@"资讯"];
    
    QueryViewController *QueryVC = [QueryViewController new];
    [self addViewController:QueryVC ImageName:@"Query" title:@"查产品"];
    PictureViewController *PictureVC = [PictureViewController new];
    [self addViewController:PictureVC ImageName:@"Picture" title:@"图赏"];
    
    
    
    
    
    

    
}
- (void)addViewController:(UIViewController *)viewController ImageName:(NSString *)stringImageName title:(NSString *)stringTitle{
        viewController.tabBarItem.image = [UIImage imageNamed:stringImageName];
    viewController.title = stringTitle;
    
    viewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0,-2);
    MainNavigationController *navigationVC = [[MainNavigationController alloc]initWithRootViewController:viewController];
    [self addChildViewController:navigationVC];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
