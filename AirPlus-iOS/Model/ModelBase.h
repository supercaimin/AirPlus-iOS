//
//  ModelBase.h
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/27.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//


#import "Constants.h"

#import "AFHttpResult.h"

@class AFHTTPRequestOperation;


@interface ModelBase : NSObject

/**
 *  发送一个请求
 *
 *  @param methodType   请求方法
 *  @param url          请求路径
 *  @param params       请求参数
 *  @param success      请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure      请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
-(void) requestWithMethod:(RequestMethodType)
                methodType url : (NSString *)url
                params:(NSDictionary *)params
                success:(void (^)(AFHttpResult *response))success
                failure:(void (^)(NSError *err))failure;

@end