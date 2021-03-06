//
//  CityModel.h
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/27.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//


#import "ModelBase.h"

@interface CityModel : ModelBase

@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *logo;

+ (void) getAll:(void (^)(NSArray *citys))success
       failure:(void (^)(NSError* err))failure;
@end