//
//  PictureHeaderView.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PictureHeaderView.h"
#import "PictureNameModel.h"
#import "Masonry.h"
#import "common.h"

@implementation PictureHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadDefaultSetting];
    }
    return self;
}
- (void)loadDefaultSetting{
    CGFloat width = self.frame.size.width * 0.5;
//    CGFloat height = self.frame.size.height;
    self.headerName = [[UILabel alloc]init];
//    self.headerName.frame = CGRectMake(8 , 5, width * 0.5, height);
    self.headerName.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.headerName];
    [self.headerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(8);
        make.top.mas_equalTo(self).offset(5);
        make.bottom.mas_equalTo(self).offset(-8);
        make.width.mas_equalTo(width);
    }];
    
    UIButton *moreImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreImage setTitle:@"查看更多" forState:UIControlStateNormal];
    [moreImage setTitleColor:ColorWithRGB(29, 122, 251) forState:UIControlStateNormal];
    moreImage.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [moreImage addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:moreImage];
    [moreImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).offset(-8);
        make.top.mas_equalTo(self).offset(5);
        make.bottom.mas_equalTo(self).offset(-8);
        make.width.mas_equalTo(width);
    }];

}
- (void)tapAction{
    if(self.headerTapEventBlock){
        self.headerTapEventBlock();
    }
}
- (void)setPNModel:(PictureNameModel *)PNModel{
    _PNModel = PNModel;
    _headerName.text = PNModel.name;
}
@end
