//
//  ListModel.h
//  DigitalTechnology
//
//  Created by qingyun on 16/8/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleListModel : NSObject
/**标题*/
@property (nonatomic,strong) NSString *title;
/**时间*/
@property (nonatomic,strong) NSString *pubDate;
/**图片*/
@property (nonatomic,strong) NSString *image;
/**详情id*/
@property (nonatomic,strong) NSString *ID;

@property (nonatomic,strong) NSString *summary;

+ (instancetype)listModelWithDictionary:(NSDictionary *)dictionary;


@end
