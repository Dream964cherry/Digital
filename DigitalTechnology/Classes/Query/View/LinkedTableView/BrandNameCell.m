//
//  BrandNameCell.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/16.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "BrandNameCell.h"
#import "BrandListModel.h"
#import "BrandModel.h"
#import "UIImageView+WebCache.h"

@implementation BrandNameCell
- (void)setBrandModel:(BrandModel *)brandModel{
    _brandModel = brandModel;
    _brandNameLabel.text = brandModel.name;
    NSURL *url = [NSURL URLWithString:brandModel.picUrl];
    
    [_brandLogoImage sd_setImageWithURL:url];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *strIdentifier = @"BrandNameCell";
    BrandNameCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BrandNameCell" owner:self options:nil] firstObject];
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
