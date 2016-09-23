//
//  DigitalModel.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/16.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DigitalModel.h"

@implementation DigitalModel
+ (instancetype)digitalModelWithDictionnary:(NSDictionary *)dicttionnary{
    DigitalModel *model = [[DigitalModel alloc]init];
    model.name = dicttionnary[@"name"];
    model.src = dicttionnary[@"src"];
    model.subId = dicttionnary[@"subId"];
    model.type = dicttionnary[@"type"];
    NSArray *array = dicttionnary[@"subArr"];
    NSInteger count = array.count;
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger index = 0; index < count; index ++) {
        subArrayModel *subModel = [subArrayModel subWithDictionary:array[index]];
        [arrayM addObject: subModel ];
    }
    model.subArr = [arrayM copy];
    return model;
}
@end
