//
//  InstrumentModel.m
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/27.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import "InstrumentModel.h"

@implementation InstrumentModel

-(instancetype) initWithJsonObject:(NSDictionary *)jsonDict
{
    self = [super init];
    if (self) {
        self.name = [jsonDict objectForKey:@"name"];
        self.schoolId = [jsonDict objectForKey:@"school_id"];
        self.schoolName = [jsonDict objectForKey:@"school_name"];
        self.uid = [jsonDict objectForKey:@"id"];
        self.serial = [jsonDict objectForKey:@"serial"];
        self.cityKey = [jsonDict objectForKey:@"city_key"];

        self.isPublic = [[jsonDict objectForKey:@"is_public"] boolValue];
    }
    
    
    return self;
}

+ (void) getInstrumentsWithSchoolId:(NSString *)schoolId
                            success:(void (^)(NSArray *instruments))success
                            failure:(void (^)(NSError* err))failure
{
    [InstrumentModel requestWithMethod:RequestMethodTypeGet url:[NSString stringWithFormat:@"get_instruments_by_school/%@", schoolId] params:nil success:^(AFHttpResult *response) {
        __block NSMutableArray *instrumentsObjects = [[NSMutableArray alloc] init];
        NSArray *jsonObjects = response.jsonObject;
        [jsonObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            InstrumentModel *instrument = [[InstrumentModel alloc] initWithJsonObject:obj];
            [instrumentsObjects addObject:instrument];
        }];
        
        success(instrumentsObjects);
    } failure:^(NSError *err) {
        failure(err);
    }];
}

+ (void) getPM25WithUid:(NSString *)uid
                success:(void (^)(NSArray *instruments))success
                failure:(void (^)(NSError* err))failure
{
    [InstrumentModel requestWithMethod:RequestMethodTypeGet url:[NSString stringWithFormat:@"get_pm_by_instrument/%@", uid] params:nil success:^(AFHttpResult *response) {
    } failure:^(NSError *err) {
        failure(err);
    }];
}

+ (void) addUserInstrument:(NSString *)userId
              instrumentId:(NSString *)instrumentId
                   success:(void (^)(void))success
                   failure:(void (^)(NSError* err))failure
{
    NSDictionary *params = @{@"user_id": userId, @"instrument_id":instrumentId};
    [InstrumentModel requestWithMethod:RequestMethodTypePost url:@"add_user_instrument" params:params success:^(AFHttpResult *response) {
        success();
    } failure:^(NSError *err) {
        failure(err);
    }];
}

+ (void) delUserInstrument:(NSString *)userId
              instrumentId:(NSString *)instrumentId
                   success:(void (^)(void))success
                   failure:(void (^)(NSError* err))failure
{
    NSDictionary *params = @{@"user_id": userId, @"instrument_id":instrumentId};
    [InstrumentModel requestWithMethod:RequestMethodTypePost url:@"del_user_instrument" params:params success:^(AFHttpResult *response) {
        success();
    } failure:^(NSError *err) {
        failure(err);
    }];
}

+ (void) getInstrumentsWithUserId:(NSString *)userId
                            success:(void (^)(NSArray *instruments))success
                            failure:(void (^)(NSError* err))failure
{
    [InstrumentModel requestWithMethod:RequestMethodTypeGet url:[NSString stringWithFormat:@"get_instruments_by_user/%@", userId] params:nil success:^(AFHttpResult *response) {
        __block NSMutableArray *instrumentsObjects = [[NSMutableArray alloc] init];
        NSArray *jsonObjects = response.jsonObject;
        [jsonObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            InstrumentModel *instrument = [[InstrumentModel alloc] initWithJsonObject:obj];
            [instrumentsObjects addObject:instrument];
        }];
        
        success(instrumentsObjects);
    } failure:^(NSError *err) {
        failure(err);
    }];
}


@end
