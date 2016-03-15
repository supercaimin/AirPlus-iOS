//
//  UserModel.h
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/27.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import "ModelBase.h"

@class InstrumentModel;

typedef NS_ENUM(NSInteger, UserModelType){
    UserModelAdminType = 1,
    UserModelCommType = 2
};

@interface UserModel : ModelBase
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *schoolId;
@property (assign, nonatomic) UserModelType type;
@property (strong, nonatomic) NSArray *instruments;

- (BOOL) isContainInstruments:(InstrumentModel *)instrument;


+ (void) login:(NSString *)email
      password:(NSString *)password
       success:(void (^)(UserModel *user))success
       failure:(void (^)(NSError* err))failure;


+ (void) register:(NSString *)email
        password:(NSString *)password
        schoolId:(NSString *)schoolId
        success:(void (^)(UserModel *user))success
        failure:(void (^)(NSError* err))failure;

+ (void) setInstallationId:(NSString *)userId
            installationId:(NSString *)installationId
                   success:(void (^)(UserModel *user))success
                   failure:(void (^)(NSError* err))failure;

+ (UserModel *) sharedLoginUser;

- (BOOL) isLangEn;
- (void) setLangEn:(BOOL) bo;

@end
