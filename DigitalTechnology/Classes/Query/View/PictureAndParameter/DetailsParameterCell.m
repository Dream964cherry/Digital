//
//  DetailsParameterCell.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DetailsParameterCell.h"

@implementation DetailsParameterCell
+ (instancetype)detailsParaCellWithTableView:(UITableView *)tableView{
    static NSString *strIdentifier = @"DetailsParameterCell";
    DetailsParameterCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DetailsParameterCell" owner:self options:nil] firstObject];
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
