//
//  BrandNameCell.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/16.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BrandModel;

@interface BrandNameCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *brandLogoImage;
@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;

@property (strong,nonatomic) BrandModel *brandModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
