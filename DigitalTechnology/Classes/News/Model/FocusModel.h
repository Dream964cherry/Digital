//
//  PicsModel.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/1.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FocusModel : NSObject
@property (nonatomic,strong)NSString *Id;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *image;
@property (nonatomic,strong)NSString *pubDate;

+(instancetype)picsModelWithDictionary:(NSDictionary *)dictionary;


@end
