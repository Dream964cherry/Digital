//
//  common.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#ifndef common_h
#define common_h

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define ColorWithRGB(redValue, greenValue, blueValue) ([UIColor colorWithRed:((redValue)/255.0) green:((greenValue)/255.0) blue:((blueValue)/255.0) alpha:1])

#define ColorRandom QLColorWithRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#import "HttpRequest.h"
#import "MJRefresh.h"

#endif /* common_h */
