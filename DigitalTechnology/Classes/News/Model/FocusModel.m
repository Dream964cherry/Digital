//
//  PicsModel.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/1.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FocusModel.h"

@implementation FocusModel
+(instancetype)picsModelWithDictionary:(NSDictionary *)dictionary{
    FocusModel *model = [[FocusModel alloc]init];
    model.Id = dictionary[@"id"];
    model.title = dictionary[@"title"];
    model.image = dictionary[@"image"];
    model.pubDate = dictionary[@"pubDate"];
    
    return model;
}

@end
