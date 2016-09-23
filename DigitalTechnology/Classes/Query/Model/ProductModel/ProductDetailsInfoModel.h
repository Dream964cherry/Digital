//
//  ProductDetailsModel.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetailsInfoModel : NSObject
@property (nonatomic,strong) NSString *Id;
//数码分类的各个id
@property (nonatomic,strong) NSString *subcateId;
//产品简述
@property (nonatomic,strong) NSString *second_title;
@property (nonatomic,strong) NSString *manuId;
//产品名称
@property (nonatomic,strong) NSString *name;
//图片
@property (nonatomic,strong) NSString *pic;
//价格
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *priceRange;
@property (nonatomic,strong) NSString *mark;
@property (nonatomic,strong) NSString *seriesId;

+ (instancetype)detailsModelWithDictionary:(NSDictionary *)Dictionary;

@end
