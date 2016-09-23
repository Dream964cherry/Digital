//
//  ImagesModel.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImagesModel : NSObject
@property (nonatomic,strong)NSString*picSrc;
@property (nonatomic,strong)NSString *bigPic;
@property (nonatomic,strong)NSString *brief;
+ (instancetype)imagesModelWithDictionary:(NSDictionary *)dictionary;
@end
