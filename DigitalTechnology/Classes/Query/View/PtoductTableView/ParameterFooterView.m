//
//  ParameterFooterView.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ParameterFooterView.h"
#import "common.h"
#import "Masonry.h"

@implementation ParameterFooterView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadDefaultSetting];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self loadDefaultSetting];
    }
    return self;
}
- (void)loadDefaultSetting{
    UIButton *detailedParameter = [[UIButton alloc]init];
    detailedParameter.backgroundColor = [UIColor whiteColor];
    [detailedParameter setTitle:@"查看详细参数 >" forState:UIControlStateNormal];
    [detailedParameter setTitleColor:ColorWithRGB(29, 122, 251)  forState:UIControlStateNormal];
    detailedParameter.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:detailedParameter];
    [detailedParameter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(1);
    }];
    
    [detailedParameter addTarget:self action:@selector(tapEvent:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)tapEvent:(UIButton *)btn {
    if (self.blocButtonParameter) {
        self.blocButtonParameter(btn);
    }
}
@end
