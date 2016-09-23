//
//  DigitalModel.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/16.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "subArrayModel.h"
@interface DigitalModel : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *subId;
@property (nonatomic,strong) NSString *src;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSArray *subArr;

+ (instancetype) digitalModelWithDictionnary:(NSDictionary *)dicttionnary;
@end

