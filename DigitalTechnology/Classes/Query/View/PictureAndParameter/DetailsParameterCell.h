//
//  DetailsParameterCell.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsParameterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *keyLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
+ (instancetype)detailsParaCellWithTableView:(UITableView *)tableView;
@end
