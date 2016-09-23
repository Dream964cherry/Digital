//
//  ProductListModel.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ProductListModel.h"

@implementation ProductListModel
+ (instancetype)productListModelWithDictionary:(NSDictionary *)dictionnary{
    ProductListModel *model = [[ProductListModel alloc]init];
    model.Id = dictionnary[@"id"];
    model.name = dictionnary[@"name"];
    model.Pic160x120 = dictionnary[@"160x120Pic"];
    model.price = dictionnary[@"price"];
    model.mark = dictionnary[@"mark"];
    model.subcateId = dictionnary[@"subcateId"];
    model.manuId = dictionnary[@"manuId"];
    model.seriesId = dictionnary[@"seriesId"];
    return model;
}
@end
