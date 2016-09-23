//
//  ProductSortParamModel.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductSortParamModel : NSObject

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *value;

+ (instancetype)parameterModelWithDictionary:(NSDictionary *)dict;
@end
