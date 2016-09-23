//
//  PhotoModel.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "GroupsModel.h"

@implementation GroupsModel

+ (instancetype)groupsModelWithDictionary:(NSDictionary *)dictionary{
    GroupsModel *model = [[GroupsModel alloc]init];
    model.cover = dictionary[@"cover"];
    model.ID = [dictionary[@"id"] integerValue];
    model.name = dictionary[@"name"];
    model.photoCount = [dictionary[@"photoCount"] integerValue];
    return model;
}

@end
