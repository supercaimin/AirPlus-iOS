//
//  SchoolModel.h
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/27.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//


#import "ModelBase.h"

@interface SchoolModel : ModelBase

@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *cityId;
@property (strong, nonatomic) NSString *logo;

@property (strong, nonatomic) NSArray *photos;

+ (void) getSchoolsWithCityId:(NSString *)cityId
                      success:(void (^)(NSArray *schools))success
                      failure:(void (^)(NSError* err))failure;

+ (void) getSchoolWithId:(NSString *)uid
                 success:(void (^)(SchoolModel *school))success
                 failure:(void (^)(NSError* err))failure;

-(instancetype) initWithJsonObject:(NSDictionary *)jsonDict;

@end
