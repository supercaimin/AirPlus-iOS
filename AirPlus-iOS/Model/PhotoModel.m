//
//  PhotoModel.m
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/27.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel


-(instancetype) initWithJsonObject:(NSDictionary *)jsonDict
{
    self = [super init];
    if (self) {
        self.src = [jsonDict objectForKey:@"src"];
        self.schoolId = [jsonDict objectForKey:@"school_id"];
        self.uid = [jsonDict objectForKey:@"id"];
    }
    
    
    return self;
}
@end
