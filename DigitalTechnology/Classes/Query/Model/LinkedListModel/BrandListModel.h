//
//  ABCModel.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/16.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  BrandModel;
@interface BrandListModel : NSObject
//热门品牌
@property (nonatomic, copy) NSArray *rankArr;
@property (nonatomic,  copy) NSString *keys;
//abc各自里面有多少个品牌
@property (nonatomic, copy) NSArray *brandArr;

+ (instancetype) abcModelWithDict:(NSArray *)dict withKeys:(NSString *)keys ;
@end
