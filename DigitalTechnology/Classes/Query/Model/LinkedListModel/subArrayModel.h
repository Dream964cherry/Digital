//
//  subArray.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/17.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface subArrayModel : NSObject

@property (nonatomic,strong)NSString *Id;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *keys;
+ (instancetype)subWithDictionary:(NSDictionary *)dict;

@end
