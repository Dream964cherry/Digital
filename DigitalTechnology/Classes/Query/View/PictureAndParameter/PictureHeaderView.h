//
//  PictureHeaderView.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PictureNameModel;
@interface PictureHeaderView : UICollectionReusableView
@property (nonatomic,strong)UILabel *headerName;
@property (nonatomic,copy)void(^headerTapEventBlock)();
@property (nonatomic,strong)PictureNameModel *PNModel;
@end
