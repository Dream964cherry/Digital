//
//  HttpRequse.h
//  DigitalTechnology
//
//  Created by qingyun on 16/9/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject

+ (void)httpTextRequestWith:(NSString *)url Dictionnary:(NSDictionary *)dictionary Success:(void(^)(id reponseObject))success Failure:(void(^)(NSError *error))failure;

+ (void)httpApplicationRequestWith:(NSString *)url Dictionary:(NSDictionary *)dict Success:(void(^)(id reponseObject))success Failure:(void(^)(NSError *error))failure;

+ (void)postHttpApplicationRequestWith:(NSString *)url Dictionary:(NSDictionary *)dictionary Success:(void(^)(id reponseObject))success Failure:(void(^)(NSError *error))failure;
@end
