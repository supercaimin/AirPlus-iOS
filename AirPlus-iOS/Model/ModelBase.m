//
//  ModelBase.m
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/27.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import "ModelBase.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>




#define ContentType @"application/json"

@implementation ModelBase
- (void)requestWithMethod:(RequestMethodType)methodType
                      url:(NSString*)url
                   params:(NSDictionary*)params
                  success:(void (^)(AFHttpResult *response))success
                  failure:(void (^)(NSError* err))failure
{
    // [Utility showHUD];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL* baseURL = [NSURL URLWithString:FAKE_SERVER];
    //获得请求管理者
    AFHTTPRequestOperationManager* mgr = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
#ifdef ContentType
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:ContentType];
#endif
    mgr.requestSerializer.HTTPShouldHandleCookies = YES;
    
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            //GET请求
            [mgr GET:url parameters:params
             success:^(AFHTTPRequestOperation* operation, NSDictionary* responseObj) {
                 // [Utility hideHUD];
                 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                 
                 if (success) {
                 }
                 NSLog(@"%@",  operation.responseString);
             } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
                 if (failure) {
                     failure(error);
                 }
             }];
            
        }
            break;
        case RequestMethodTypePost:
        {
            //POST请求
            [mgr POST:url parameters:params
              success:^(AFHTTPRequestOperation* operation, NSDictionary* responseObj) {
                  // [Utility hideHUD];
                  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                  
                  if (success) {
             
                      
                  }
                  NSLog(@"%@",  operation.responseString);
              } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
                  if (failure) {
                  }
              }];
        }
            break;
        default:
            break;
    }
}

@end
