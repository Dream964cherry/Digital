//
//  ProductListModel.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductListModel : NSObject
@property (nonatomic,strong) NSString *Id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *subcateId;
@property (nonatomic,strong) NSString *manuId;
@property (nonatomic,strong) NSString *Pic160x120;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *mark;
//进行判断的标志
@property (nonatomic,strong) NSString *seriesId;

+ (instancetype)productListModelWithDictionary:(NSDictionary *)dictionnary;

@end
