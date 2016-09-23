//
//  ProInfoView.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//
#import "ProInfoView.h"
#import "UIImageView+WebCache.h"
#import "ProductDetailsInfoModel.h"
#import "Masonry.h"
#import "common.h"
#import "ProductPictureViewController.h"

static NSInteger const height = 30;

@interface ProInfoView ()
@end

@implementation ProInfoView
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self loadDefaultSetting];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadDefaultSetting];
}
    return self;
}
- (void)setPDIModel:(ProductDetailsInfoModel *)PDIModel{
    _PDIModel = PDIModel;
    NSURL *url = [NSURL URLWithString:_PDIModel.pic];
    [self.picImageView sd_setImageWithURL:url];
    _productName.text = _PDIModel.name;
    if (_PDIModel.second_title) {
        _productDescribe.text = _PDIModel.second_title;
    }else{
        _productDescribe.text = @"";
    }
    if (_PDIModel.price) {
        NSString *string = [NSString stringWithFormat:@"%@%@",_PDIModel.mark,_PDIModel.price];
        _productPrice.text = string;
    }else{
        NSString *string = [NSString stringWithFormat:@"¥%@",_PDIModel.priceRange];
          _productPrice.text = string;
    }
}
- (void)loadDefaultSetting{
    
    /**产品图片*/
    UIImageView *picImageView = [[UIImageView alloc]init];
    [self addSubview:picImageView];
    self.picImageView = picImageView;
    picImageView.contentMode = UIViewContentModeScaleToFill;
    picImageView.clipsToBounds = YES;
    [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(300);
    }];
    /**查看更多图片*/
    UIButton *loadMoreImage = [[UIButton alloc]init];
    loadMoreImage.backgroundColor = [UIColor whiteColor];
    [loadMoreImage setTitle:@"点击查看更多图片  >" forState: UIControlStateNormal];
    [loadMoreImage setTitleColor:ColorWithRGB(29, 122, 251) forState:UIControlStateNormal];
    [loadMoreImage setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    loadMoreImage.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:loadMoreImage];
    _loadMoreImage = loadMoreImage;
    [loadMoreImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(picImageView.mas_bottom).offset(1);
        make.height.mas_equalTo(height);
    }];
    
    UIView *V = [[UIView alloc]init];
    V.backgroundColor = [UIColor whiteColor];
    [self addSubview:V];
    [V mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(loadMoreImage.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];
    /**名字*/
    UILabel *productName = [[UILabel alloc]init];
    productName.numberOfLines = 0;
    productName.font = [UIFont systemFontOfSize:18];
    _productName = productName;
    [V addSubview:productName];
    [productName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(15);
        make.trailing.mas_equalTo(self).offset(-15);
        make.top.mas_equalTo(V.mas_top).offset(5);
    }];
    /**描述*/
    UILabel *productDescribe = [[UILabel alloc]init];
    productDescribe.numberOfLines = 0;
    productDescribe.font = [UIFont systemFontOfSize:14];
    [V addSubview:productDescribe];
    _productDescribe = productDescribe;
    [productDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(productName);
        make.top.mas_equalTo(productName.mas_bottom).offset(5);
    }];
    /**价格*/
    UILabel *productPrice = [[UILabel alloc]init];
    productPrice.textColor = [UIColor redColor];
    productPrice.textAlignment = NSTextAlignmentRight;
    productPrice.font = [UIFont systemFontOfSize:18];
    [V addSubview:productPrice];
    _productPrice = productPrice;
    [productPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(productName);
        make.top.mas_equalTo(productDescribe.mas_bottom).offset(5);
    }];
}
@end
