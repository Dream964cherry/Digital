//
//  ProductListCell.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ProductListCell.h"
#import "UIImageView+WebCache.h"

@implementation ProductListCell
- (void)setPLModel:(ProductListModel *)PLModel{
    _PLModel = PLModel;
    //图片
    NSURL *url = [NSURL URLWithString:PLModel.Pic160x120];
    [_productImage sd_setImageWithURL:url];
    _productDescriptionLabel.text = PLModel.name;
    //价格
    NSString *string = [NSString stringWithFormat:@"%@%@",PLModel.mark,PLModel.price];
    _priceLabel.text = string;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *strIdentifier = @"ProductListCell";
    ProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ProductListCell" owner:self options:nil] firstObject];
        
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
