//
//  AFHttpResult.h
//  powerkeeper
//
//  Created by 蔡 敏 on 15/7/16.
//  Copyright (c) 2015年 Appbees.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFHttpResult : NSObject

@property (nonatomic, assign) NSInteger httpStatus;
@property (nonatomic, assign) NSInteger errCode;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) id jsonObject;
@property (nonatomic, strong) NSString *responseString;


@end
