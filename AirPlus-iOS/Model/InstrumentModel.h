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
@property (strong, nonatomic) NSString *serial;
@property (assign, nonatomic) BOOL isPublic;


@end