//
//  ListModel.m
//  DigitalTechnology
//
//  Created by qingyun on 16/8/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ArticleListModel.h"

@implementation ArticleListModel

+(instancetype)listModelWithDictionary:(NSDictionary *)dictionary{
    ArticleListModel *model = [[ArticleListModel alloc]init];
    model.title = dictionary[@"title"];
    model.pubDate = dictionary[@"pubDate"];
    model.ID = dictionary[@"id"];
    model.image = dictionary[@"image"];
    return model;
}


@end