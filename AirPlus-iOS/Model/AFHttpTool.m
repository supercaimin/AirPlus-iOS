//
//  AFHttpTool.m
//  powerkeeper
//
//  Created by 蔡 敏 on 15/7/15.
//  Copyright (c) 2015年 Appbees.net. All rights reserved.
//

#import "AFHttpTool.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>

static AFHttpTool *pmDataSyncMananger  = nil;

#define kPMCacheData        @"PMCacheData"

//#define ContentType @"text/html"
//#define ContentType @"application/json"

@implementation AFHttpTool

+ (AFHttpTool *)pmDataSyncMananger{
    if (!pmDataSyncMananger) {
        pmDataSyncMananger = [[AFHttpTool alloc] init];
        pmDataSyncMananger.pmdatas = [AFHttpTool getDataWithFilename:kPMCacheData];
    }
    return pmDataSyncMananger;
}

+ (void)requestWithMethod:(RequestMethodType)methodType
                      url:(NSString*)url
                   params:(NSDictionary*)params
                  success:(void (^)(AFHttpResult *response))success
                  failure:(void (^)(NSError* err, NSString *responseString))failure
              contentType:(NSString *)contentType
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //获得请求管理者
    AFHTTPRequestOperationManager* mgr = [[AFHTTPRequestOperationManager alloc] init];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:contentType];

    mgr.requestSerializer.HTTPShouldHandleCookies = YES;
    
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            //GET请求
            [mgr GET:url parameters:params
             success:^(AFHTTPRequestOperation* operation, NSDictionary* responseObj) {
                 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

                 if (success) {
                     AFHttpResult *result = [[AFHttpResult alloc] init];
                     result.responseString = operation.responseString;
                     result.errCode = 0;
                     result.jsonObject = responseObj;
                     success(result);
                 }
                // NSLog(@"%@",  operation.responseString);
             } failure:^(AFHTTPRequestOperation* operation, NSError* error) {

                 if (failure) {
                     failure(error, operation.responseString);
                     NSLog(@"%@ %@", error.localizedDescription,  operation.responseString);
                  //   [Utility hideHUD];
                     [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                 }
             }];
            
        }
            break;
        case RequestMethodTypePost:
        {
            //POST请求
            [mgr POST:url parameters:params
              success:^(AFHTTPRequestOperation* operation, NSDictionary* responseObj) {
                  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

                  if (success) {


                  }
                  NSLog(@"%@",  operation.responseString);
              } failure:^(AFHTTPRequestOperation* operation, NSError* error) {

                  if (failure) {
                      failure(error, operation.responseString);
                      NSLog(@"%@ %@", error.localizedDescription,  operation.responseString);
                      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                  }
              }];
        }
            break;
        default:
            break;
    }
}


///
/// 上传图片
+ (void)uploadImageWithUrl:(NSString *)url
                                         image:(UIImage *)image
                                       success:(void (^)(AFHttpResult *response))success
                                       failure:(void (^)(NSError* err))failure {
    NSURL* baseURL = [NSURL URLWithString:FAKE_SERVER];
    
    
    
    AFHTTPRequestOperationManager* mgr = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    AFHTTPRequestOperation *op = [mgr POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:@"img" fileName:fileName mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObj) {

        if (success) {

            NSLog(@"%@",  operation.responseString);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
            NSLog(@"%@ %@", error.localizedDescription,  operation.responseString);
            //  [Utility hideHUD];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

            
        }
    }];

    
    [op setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
    }];
    [op start];
    
}

/**
 *  @author Jakey
 *
 *  @brief  下载文件
 *
 *  @param paramDic   附加post参数
 *  @param requestURL 请求地址
 *  @param savedPath  保存 在磁盘的位置
 *  @param success    下载成功回调
 *  @param failure    下载失败回调
 *  @param progress   实时下载进度回调
 */
+ (void)downloadFileWithOption:(NSDictionary *)paramDic
                 withInferface:(NSString*)requestURL
                     savedPath:(NSString*)savedPath
               downloadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               downloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                      progress:(void (^)(float progress))progress

{
    UIWindow *w = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:w];
    [w addSubview:HUD];
    
    // Set determinate bar mode
    HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"GET" URLString:requestURL parameters:paramDic error:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savedPath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float p = (float)totalBytesRead / totalBytesExpectedToRead;
        progress(p);
        NSLog(@"download：%f", (float)totalBytesRead / totalBytesExpectedToRead);
        HUD.progress = (float)totalBytesRead / totalBytesExpectedToRead;
        
        
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        [HUD removeFromSuperview];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSLog(@"下载成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(operation,error);
        NSLog(@"%@ %@", error.localizedDescription,  operation.responseString);
        //  [Utility hideHUD];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [HUD removeFromSuperview];
        
        NSLog(@"下载失败");
        
    }];
    [HUD show:YES];
    
    [operation start];
    
}


+(void) login:(void (^)(AFHttpResult *response))success
      failure:(void (^)(NSError* err, NSString *responseString))failure
{
    [AFHttpTool requestWithMethod:RequestMethodTypePost url:PMWEB_LOGIN params:@{@"username":@"admin", @"password":@"admin", } success:success failure:failure
                      contentType:@"text/html"];

}
+(void) syncdata:(void (^)(AFHttpResult *response))success
         failure:(void (^)(NSError* err, NSString *responseString))failure
{
    [AFHttpTool requestWithMethod:RequestMethodTypeGet
                          url:PMWEB_DATA params:nil
                          success:success
                          failure:failure
                      contentType:@"application/json"];
    //#define ContentType @"text/html"
    //#define ContentType @"application/json"
}

+ (void) getOutdoorData:(NSString *)cityKey
                success:(void (^)(AFHttpResult *response))success
                failure:(void (^)(NSError* err, NSString *responseString))failure;
{
    NSString *url = [NSString stringWithFormat:@"%@%@.html", OUTDOOR_DATA, cityKey];
    [AFHttpTool requestWithMethod:RequestMethodTypeGet
                              url:url params:nil
                          success:success
                          failure:failure
                      contentType:@"text/html"];
}

- (void)sysdata{

    [AFHttpTool syncdata:^(AFHttpResult *response) {
        self.pmdatas = [response.jsonObject objectForKey:@"data"];
        [AFHttpTool cacheWithData:self.pmdatas filename:kPMCacheData];
        [[NSNotificationCenter defaultCenter] postNotificationName:kPMDataSyncSuccessNotification object:self.pmdatas];
    } failure:^(NSError *err, NSString *responseString) {
        
    }];
    
}
- (void) start
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 * 60 target:self selector:@selector(timerTask) userInfo:nil repeats:YES];
    [timer fire];

}

- (void) timerTask
{
    [self sysdata];
}

- (NSArray *) getpmdatasWithSerial:(NSString *)serial
{
    NSMutableArray *ipms = [NSMutableArray array];
    
    for (NSDictionary *pm in self.pmdatas) {
        if ([[pm objectForKey:@"serial"] isEqualToString:serial]) {
            [ipms addObject:pm];
        }
    }
    return ipms;
}

+ (NSString *)documentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    return [paths objectAtIndex:0];
}


+ (void) cacheWithData:(id)data filename:(NSString *)filename
{
    NSString *filePath = [[AFHttpTool documentDirectory] stringByAppendingPathComponent:filename];
    [NSKeyedArchiver archiveRootObject:data toFile:filePath];
}

+ (id) getDataWithFilename:(NSString *) filename
{
    
    NSString *filePath =[[AFHttpTool documentDirectory] stringByAppendingPathComponent:filename];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return object;
}
    
@end
