//
//  SchoolModel.m
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/27.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import "SchoolModel.h"

@implementation SchoolModel
-(instancetype) initWithJsonObject:(NSDictionary *)jsonDict
{
    self = [super init];
    if (self) {
        self.name = [jsonDict objectForKey:@"name"];
        self.cityId = [jsonDict objectForKey:@"city_id"];
        self.uid = [jsonDict objectForKey:@"id"];
        self.logo = [jsonDict objectForKey:@"logo"];
        self.photos = [jsonDict objectForKey:@"images"];
        self.isOpen = [jsonDict objectForKey:@"is_open"];
    }
    
    
    return self;
}

+ (void) getSchoolsWithCityId:(NSString *)cityId success:(void (^)(NSArray *schools))success failure:(void (^)(NSError* err))failure{
    [SchoolModel requestWithMethod:RequestMethodTypeGet url:[NSString stringWithFormat:@"get_schools_by_city/%@", cityId] params:nil success:^(AFHttpResult *response) {
        __block NSMutableArray *schoolsObjects = [[NSMutableArray alloc] init];
        NSArray *jsonObjects = response.jsonObject;
        [jsonObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SchoolModel *school = [[SchoolModel alloc] initWithJsonObject:obj];
            [schoolsObjects addObject:school];
        }];
        
        success(schoolsObjects);
    } failure:^(NSError *err) {
        failure(err);
    }];
}

+ (void) getSchoolWithId:(NSString *)uid
                 success:(void (^)(SchoolModel *school))success
                 failure:(void (^)(NSError* err))failure
{
    [SchoolModel requestWithMethod:RequestMethodTypeGet url:[NSString stringWithFormat:@"get_school/%@", uid] params:nil success:^(AFHttpResult *response) {
        SchoolModel *school = [[SchoolModel alloc] initWithJsonObject:response.jsonObject];
        success(school);
    } failure:^(NSError *err) {
        failure(err);
    }];
}

@end
