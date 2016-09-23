//
//  BrandModel.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/16.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandModel : NSObject
@property (nonatomic, copy) NSString *strId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *picUrl;
+ (instancetype)brandModelWithDict:(NSDictionary *)dict;
@end
