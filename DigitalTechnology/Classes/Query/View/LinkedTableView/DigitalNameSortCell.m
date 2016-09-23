//
//  DigitalTableViewCell.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/16.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DigitalNameSortCell.h"
#import "DigitalModel.h"
#import "UIImageView+WebCache.h"

@implementation DigitalNameSortCell

- (void)setDiModel:(DigitalModel *)DiModel{
    _DiModel = DiModel;
    NSURL *url = [NSURL URLWithString:DiModel.src];
    [_logoImage sd_setImageWithURL:url];
    
    _nameLabel.text = DiModel.name;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *strIdentifier = @"DigitalNameSortCell";
    DigitalNameSortCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DigitalNameSortCell" owner:self options:nil] firstObject];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];//这句不可省略
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
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
