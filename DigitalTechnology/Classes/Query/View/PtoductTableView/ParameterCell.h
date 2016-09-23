//
//  ParameterCell.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductSortParamModel;
@interface ParameterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *lab;

@property (strong, nonatomic) ProductSortParamModel *PSPModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
