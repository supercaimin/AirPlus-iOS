//
//  PM25DataModel.h
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/27.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//


#import "ModelBase.h"

@interface PM25DataModel : ModelBase

@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *serial;
@property (strong, nonatomic) NSString *reading;
@property (strong, nonatomic) NSString *displayStatus;
@property (strong, nonatomic) NSString *readingSate;


@end