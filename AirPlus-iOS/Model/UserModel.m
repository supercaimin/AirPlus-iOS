//
//  UserModel.m
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/27.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import "UserModel.h"

#import "Constants.h"

#import "InstrumentModel.h"


#define kLangSetting @"LangSetting"
static UserModel *sharedLoginUser = nil;

@implementation UserModel

+ (UserModel *) sharedLoginUser
{
    NSDictionary *loginUserInfo = [DEFAULTS objectForKey:kUserLoginInfo];
    if (loginUserInfo && sharedLoginUser == nil) {
        sharedLoginUser = [[UserModel alloc] initWithJsonObject:loginUserInfo];
    }else{
        if (!loginUserInfo) {
            sharedLoginUser = nil;
        }
    }
    return sharedLoginUser;
}

-(instancetype) initWithJsonObject:(NSDictionary *)jsonDict
{
    self = [super init];
    if (self) {
        self.email = [jsonDict objectForKey:@"email"];
        self.schoolId = [jsonDict objectForKey:@"school_id"];
        self.uid = [jsonDict objectForKey:@"id"];
    }
    
    
    return self;
}

+ (void) login:(NSString *)email
      password:(NSString *)password
       success:(void (^)(UserModel *user))success
       failure:(void (^)(NSError* err))failure
{
    NSDictionary *params = @{@"email": email, @"password":password};
    [UserModel requestWithMethod:RequestMethodTypePost url:@"login" params:params success:^(AFHttpResult *response) {
        
        [DEFAULTS setObject:response.jsonObject forKey:kUserLoginInfo];
        sharedLoginUser = nil;
        success(response.jsonObject);
    } failure:^(NSError *err) {
        failure(err);
    }];
}

+ (void) register:(NSString *)email
            password:(NSString *)password
            schoolId:(NSString *)schoolId
            success:(void (^)(UserModel *user))success
            failure:(void (^)(NSError* err))failure
{
    NSDictionary *params = @{@"email": email, @"password":password, @"school_id": schoolId};
    [UserModel requestWithMethod:RequestMethodTypePost url:@"reg" params:params success:^(AFHttpResult *response) {
        
        [DEFAULTS setObject:response.jsonObject forKey:kUserLoginInfo];
        sharedLoginUser = nil;
        
        success(response.jsonObject);
    } failure:^(NSError *err) {
        failure(err);
    }];
}

- (BOOL) isContainInstruments:(InstrumentModel *)instrument
{
    __block BOOL contain = NO;
    [self.instruments enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        InstrumentModel *ins = obj;
        if ([ins.serial isEqualToString:instrument.serial]) {
            contain = YES;
            *stop = YES;
        }
    }];
    return contain;
}


- (BOOL) isLangEn
{
    NSString *lang = [DEFAULTS objectForKey:kLangSetting];
    if (!lang || [lang isEqualToString:@"en"]) {
        return YES;
    }else{
        return NO;
    }
}

- (void) setLangEn:(BOOL) bo
{
    if (bo) {
        [DEFAULTS setObject:@"en" forKey:kLangSetting];
    }else{
        [DEFAULTS setObject:@"zh" forKey:kLangSetting];
    }
    
}

@end
