//
//  PictureModel.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PictureModel.h"

@implementation PictureModel
+ (instancetype)pictureModelWithDictionary:(NSDictionary *)dict{
    if (dict == nil || [dict isKindOfClass:[NSNull class]])
        return nil;
    PictureModel *model = [[PictureModel alloc]init];
    model.picSrc = dict[@"picSrc"];
    model.bigPic = dict[@"bigPic"];
    model.brief = dict[@"brief"];
    return model;
}
@end
