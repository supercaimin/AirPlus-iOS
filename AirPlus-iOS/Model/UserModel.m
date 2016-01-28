//
//  UserModel.m
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/27.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (void) login:(NSString *)email password:(NSString *)password success:(void (^)(AFHttpResult *))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = @{@"email":email, @"password":password};
    [UserModel requestWithMethod:RequestMethodTypePost url:@"login" params:params success:success failure:failure];
}

@end
