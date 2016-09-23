//
//  PictureNameModel.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureNameModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *categoryId;

@property (nonatomic,strong) NSMutableArray *imagesArr;

+(instancetype)nameModelWithDictionary:(NSDictionary *)dictionary;
@end
