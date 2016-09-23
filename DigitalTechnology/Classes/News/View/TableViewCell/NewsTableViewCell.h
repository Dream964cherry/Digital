//
//  FirstKindOfTableViewCell.h
//  DigitalTechnology
//
//  Created by wmh on 16/8/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ArticleListModel;
@interface NewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong,nonatomic) ArticleListModel *LModel;

+ (instancetype)cellWithTableView:(UITableView *)tableVIew;

@end
