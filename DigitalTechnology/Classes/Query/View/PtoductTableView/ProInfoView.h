//
//  ProInfoView.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductDetailsInfoModel;
@interface ProInfoView : UIView
@property (nonatomic,strong) ProductDetailsInfoModel *PDIModel;

@property (nonatomic,weak) UIImageView *picImageView;
@property (nonatomic,weak) UILabel *productName;
@property (nonatomic,weak) UILabel *productDescribe;
@property (nonatomic,weak) UILabel *productPrice;
@property (nonatomic,weak) UIButton *loadMoreImage;

@end
