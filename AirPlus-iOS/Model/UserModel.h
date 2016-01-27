//
//  UserModel.h
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/27.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, UserModelType){
    UserModelAdminType = 1,
    UserModelCommType = 2
};
#import "ModelBase.h"

@interface UserModel : ModelBase
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *schoolId;
@property (assign, nonatomic) UserModelType type;

- (void) login:(NSString *)email
      password:(NSString *)password
       success:(void (^)(AFHttpResult *response))success
       failure:(void (^)(NSError* err))failure;


@end
