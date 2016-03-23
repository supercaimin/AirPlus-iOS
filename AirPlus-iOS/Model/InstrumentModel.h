//
//  InstrumentModel.h
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/27.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//



#import "ModelBase.h"

@interface InstrumentModel : ModelBase

@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *schoolId;
@property (strong, nonatomic) NSString *schoolName;
@property (strong, nonatomic) NSString *serial;
@property (strong, nonatomic) NSString *cityKey;

@property (assign, nonatomic) BOOL isPublic;

@property (strong, nonatomic) NSDictionary *pm;

+ (void) getInstrumentsWithSchoolId:(NSString *)schoolId
                            success:(void (^)(NSArray *instruments))success
                            failure:(void (^)(NSError* err))failure;

+ (void) getPM25WithUid:(NSString *)uid
                success:(void (^)(NSArray *instruments))success
                failure:(void (^)(NSError* err))failure;

+ (void) addUserInstrument:(NSString *)userId
              instrumentId:(NSString *)instrumentId
                   success:(void (^)(void))success
                   failure:(void (^)(NSError* err))failure;

+ (void) delUserInstrument:(NSString *)userId
              instrumentId:(NSString *)instrumentId
                   success:(void (^)(void))success
                   failure:(void (^)(NSError* err))failure;

+ (void) getInstrumentsWithUserId:(NSString *)userId
                            success:(void (^)(NSArray *instruments))success
                            failure:(void (^)(NSError* err))failure;
@end