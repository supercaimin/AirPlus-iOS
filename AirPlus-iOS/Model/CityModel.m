//
//  CityModel.m
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/27.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

-(instancetype) initWithJsonObject:(NSDictionary *)jsonDict
{
    self = [super init];
    if (self) {
        self.name = [jsonDict objectForKey:@"city_name"];
        self.key = [jsonDict objectForKey:@"city_key"];
        self.uid = [jsonDict objectForKey:@"id"];
    }
    
    
    return self;
}
+ (void) getAll:(void (^)(NSArray *citys))success failure:(void (^)(NSError *))failure
{
    [CityModel requestWithMethod:RequestMethodTypeGet url:@"get_cites" params:nil success:^(AFHttpResult *response) {
        __block NSMutableArray *cityObjects = [[NSMutableArray alloc] init];
        NSArray *jsonObjects = response.jsonObject;
        [jsonObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CityModel *city = [[CityModel alloc] initWithJsonObject:obj];
            [cityObjects addObject:city];
        }];
        
        success(cityObjects);
    } failure:^(NSError *err) {
        failure(err);
    }];
}


@end
