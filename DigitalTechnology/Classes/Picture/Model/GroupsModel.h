//
//  PhotoModel.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupsModel : NSObject

@property (nonatomic,strong)NSString *cover;
@property (nonatomic,assign)NSInteger ID;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,assign)NSInteger photoCount;

+ (instancetype)groupsModelWithDictionary:(NSDictionary *)dictionary;
@end
