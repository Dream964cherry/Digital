//
//  ProductSortParamModel.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ProductSortParamModel.h"

@implementation ProductSortParamModel
+ (instancetype)parameterModelWithDictionary:(NSDictionary *)dict{
    if (dict == nil || [dict isKindOfClass:[NSNull class]])
        return nil;
    ProductSortParamModel *model = [[ProductSortParamModel alloc]init];
    model.name = dict[@"name"];
    model.value = dict[@"value"];
    return model;
}
@end
