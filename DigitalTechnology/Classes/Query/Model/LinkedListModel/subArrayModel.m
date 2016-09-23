//
//  subArray.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/17.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "subArrayModel.h"

@implementation subArrayModel
+ (instancetype)subWithDictionary:(NSDictionary *)dict{
    subArrayModel *model = [[subArrayModel alloc]init];
    model.Id = dict[@"id"];
    model.name = dict[@"name"];
    return model;
}

@end
