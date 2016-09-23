//
//  BrandModel.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/16.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "BrandModel.h"

@implementation BrandModel
+ (instancetype)brandModelWithDict:(NSDictionary *)dict{
    if (dict==nil||[dict isKindOfClass:[NSNull class]])return nil;
    BrandModel *model = [[BrandModel alloc]init];
    model.strId = dict[@"id"];
    model.name = dict[@"name"];
    model.picUrl = dict[@"picUrl"];
    return model;
}

@end
