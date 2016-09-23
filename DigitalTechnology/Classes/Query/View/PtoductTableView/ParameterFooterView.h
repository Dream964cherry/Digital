//
//  ParameterFooterView.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParameterFooterView : UIView
@property (nonatomic,weak)UIButton *detailedParameter;
@property (nonatomic, strong) void(^blocButtonParameter)(UIButton *);
@end
