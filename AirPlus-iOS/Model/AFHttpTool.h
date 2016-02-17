//
//  AFHttpTool.h
//  powerkeeper
//
//  Created by 蔡 敏 on 15/7/15.
//  Copyright (c) 2015年 Appbees.net. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Constants.h"

#import "AFHttpResult.h"


@class AFHTTPRequestOperation;



@interface AFHttpTool : NSObject

+ (AFHttpTool *)pmDataSyncMananger;

+ (void)downloadFileWithOption:(NSDictionary *)paramDic
                 withInferface:(NSString*)requestURL
                     savedPath:(NSString*)savedPath
               downloadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               downloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                      progress:(void (^)(float progress))progress;

/**
 *  发送一个请求
 *
 *  @param methodType   请求方法
 *  @param url          请求路径
 *  @param params       请求参数
 *  @param success      请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure      请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+(void) requestWithMethod:(RequestMethodType)
                    methodType url : (NSString *)url
                   params:(NSDictionary *)params
                  success:(void (^)(AFHttpResult *response))success
                  failure:(void (^)(NSError* err, NSString *responseString))failure;

+ (void)uploadImageWithUrl:(NSString *)url
                     image:(UIImage *)image
                   success:(void (^)(AFHttpResult *response))success
                   failure:(void (^)(NSError* err))failure;

+ (void) login:(void (^)(AFHttpResult *response))success
       failure:(void (^)(NSError* err, NSString *responseString))failure;

+ (void) syncdata:(void (^)(AFHttpResult *response))success
          failure:(void (^)(NSError* err, NSString *responseString))failure;

+ (void) getOutdoorData:(void (^)(AFHttpResult *response))success
                failure:(void (^)(NSError* err, NSString *responseString))failure;

- (void) start;

- (NSArray *) getpmdatasWithSerial:(NSString *)serial;
- (void) timerTask;

@property (nonatomic, strong) NSArray *pmdatas;


@end