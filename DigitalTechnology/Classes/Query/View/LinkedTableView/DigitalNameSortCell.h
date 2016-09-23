//
//  DigitalTableViewCell.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/16.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DigitalModel;
@interface DigitalNameSortCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) DigitalModel *DiModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
