//
//  PhotoMenuCell.m
//  DigitalTechnology
//
//  Created by wmh on 16/8/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PhotoCell.h"
#import "GroupsModel.h"
#import "UIImageView+WebCache.h"

@implementation PhotoCell

- (void)setPmodel:(GroupsModel *)Pmodel{
    _Pmodel = Pmodel;
    NSURL *imageUrl =[NSURL URLWithString:Pmodel.cover];
    [_HeadImage sd_setImageWithURL:imageUrl];
    _HeadlineLabel.text = Pmodel.name;
    NSInteger count = Pmodel.photoCount;
    NSString *countStr = [NSString stringWithFormat:@"%ld图",(long)count];
    _countLabel.text = countStr;
    
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *strIdentifier = @"PhotoCell";
    PhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PhotoCell" owner:nil options:nil] firstObject];
        //cell.selected = NO;
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
