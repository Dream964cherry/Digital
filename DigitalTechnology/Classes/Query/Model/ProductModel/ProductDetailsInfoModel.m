//
//  ProductDetailsModel.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ProductDetailsInfoModel.h"

@implementation ProductDetailsInfoModel
+ (instancetype)detailsModelWithDictionary:(NSDictionary *)dictionary
{
    if (dictionary == nil || [dictionary isKindOfClass:[NSNull class]])
        return nil;
    ProductDetailsInfoModel *model = [ProductDetailsInfoModel new];
    model.Id = dictionary[@"id"];
    model.subcateId = dictionary[@"subcateId"];
    model.second_title = dictionary[@"second_title"];
    model.name = dictionary[@"name"];
    model.seriesId = dictionary[@"seriesId"];
    model.mark = dictionary[@"mark"];
    model.pic = dictionary[@"pic"];
    model.price = dictionary[@"price"];
    model.manuId = dictionary[@"manuId"];
    model.priceRange = dictionary[@"priceRange"];
    return model;
}
@end
