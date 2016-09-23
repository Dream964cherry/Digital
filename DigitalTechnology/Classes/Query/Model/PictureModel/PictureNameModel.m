//
//  PictureNameModel.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PictureNameModel.h"
#import "ImagesModel.h"

@implementation PictureNameModel
+ (instancetype)nameModelWithDictionary:(NSDictionary *)dictionary{
    if (dictionary == nil || [dictionary isKindOfClass:[NSNull class]])
        return nil;
    PictureNameModel *model = [[PictureNameModel alloc]init];
    model.name = dictionary[@"name"];
    model.categoryId = dictionary[@"categoryId"];
    NSArray *arr = dictionary[@"images"];
    NSInteger count = arr.count;
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger index = 0; index < count; index ++) {
        ImagesModel *subModel = [ImagesModel imagesModelWithDictionary:arr[index]];
        [arrayM addObject: subModel ];
    }
    model.imagesArr = [arrayM copy];
        return model;
}

@end
