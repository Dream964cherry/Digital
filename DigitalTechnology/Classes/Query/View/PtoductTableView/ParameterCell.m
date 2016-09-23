//
//  ParameterCell.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ParameterCell.h"
#import "ProductSortParamModel.h"

@implementation ParameterCell
- (void)setPSPModel:(ProductSortParamModel *)PSPModel{
    _PSPModel = PSPModel;
    if (PSPModel) {
        _nameLabel.text = PSPModel.name;
        _valueLabel.text = PSPModel.value;
    }else{
        _valueLabel.text = @"暂时没有相关参数";
    }
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *strIdentifier = @"ParameterCell";
    ParameterCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ParameterCell" owner:self options:nil] firstObject];
    }
        return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
