//
//  ABCModel.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/16.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "BrandListModel.h"
#import "BrandModel.h"

@implementation BrandListModel
+ (instancetype) abcModelWithDict:(NSArray *)dict withKeys:(NSString *)keys {
    if (dict==nil||[dict isKindOfClass:[NSNull class]]) return nil ;
    BrandListModel *model = [[BrandListModel alloc]init];
    model.keys = keys;
    NSInteger count = dict.count;
    NSMutableArray *arraM= [NSMutableArray arrayWithCapacity:count];
    for (NSInteger index = 0; index < count; index ++) {
        BrandModel *brandModel = [BrandModel brandModelWithDict:dict[index]];
        [arraM addObject:brandModel];
    }
    model.brandArr = [arraM copy];
    return model;
}
@end
