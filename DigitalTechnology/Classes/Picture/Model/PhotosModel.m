//
//  PhotosModel.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PhotosModel.h"

@implementation PhotosModel

+ (instancetype)photoModelWithDictionary:(NSDictionary *)dictionary{
    PhotosModel *model = [[PhotosModel alloc]init];
    model.desc = dictionary[@"desc"];
    model.thumb = dictionary[@"thumb"];
    model.name = dictionary[@"name"];
    model.thumbUrl = dictionary[@"thumbUrl"];
    model.url = dictionary[@"url"];
    return model;
}

@end
