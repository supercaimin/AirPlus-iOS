//
//  PhotoModel.h
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/27.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ModelBase.h"

@interface PhotoModel : ModelBase

@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *src;
@property (strong, nonatomic) NSString *schoolId;


@end