//
//  PhotoMenuCell.h
//  DigitalTechnology
//
//  Created by wmh on 16/8/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GroupsModel;

@interface PhotoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *HeadImage;
@property (weak, nonatomic) IBOutlet UILabel *HeadlineLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (strong, nonatomic) GroupsModel *Pmodel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
