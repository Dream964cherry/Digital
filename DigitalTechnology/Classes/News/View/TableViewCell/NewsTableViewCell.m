//
//  FirstKindOfTableViewCell.m
//  DigitalTechnology
//
//  Created by wmh on 16/8/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "ArticleListModel.h"
#import "UIImageView+WebCache.h"

@implementation NewsTableViewCell
- (void)setLModel:(ArticleListModel *)LModel{
    _LModel = LModel;
    _titleLabel.text = LModel.title;
    _dateLabel.text = LModel.pubDate;
    NSURL *url = [NSURL URLWithString:LModel.image];
    [_leftImageView sd_setImageWithURL:url];
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableVIew{
    
    static NSString *strIdentifier = @"NewsTableViewCell";
    NewsTableViewCell *cell = [tableVIew dequeueReusableCellWithIdentifier:strIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NewsTableViewCell" owner:nil options:nil] firstObject];
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
