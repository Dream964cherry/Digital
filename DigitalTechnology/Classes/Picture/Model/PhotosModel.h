//
//  PhotosModel.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotosModel : NSObject
@property (nonatomic,strong)NSString *desc;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *thumb;
@property (nonatomic,strong)NSString *thumbUrl;
@property (nonatomic,strong)NSString *url;

+ (instancetype)photoModelWithDictionary:(NSDictionary *)dictionary;

@end
