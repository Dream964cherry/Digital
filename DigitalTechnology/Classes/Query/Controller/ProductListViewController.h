//
//  ProductListViewController.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ProductListViewController : UIViewController
@property (nonatomic,strong)NSString *ListUrl;
@property (nonatomic,strong)NSDictionary *parameterDict;
@property (nonatomic,strong)NSString *moreUrl;
@property (nonatomic,strong)NSDictionary *moreDict;
@end
