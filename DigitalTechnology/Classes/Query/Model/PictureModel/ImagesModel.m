//
//  ImagesModel.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ImagesModel.h"

@implementation ImagesModel
+ (instancetype)imagesModelWithDictionary:(NSDictionary *)dictionary{
    if (dictionary == nil || [dictionary isKindOfClass:[NSNull class]])
        return nil;
    ImagesModel *model = [[ImagesModel alloc]init];
    model.picSrc = dictionary[@"picSrc"];
    model.bigPic = dictionary[@"bigPic"];
    model.brief = dictionary[@"brief"];
    return model;
}

@end
