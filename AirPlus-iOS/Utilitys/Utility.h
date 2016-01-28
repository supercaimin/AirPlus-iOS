//
//  Utility.h
//  powerkeeper
//
//  Created by 蔡 敏 on 15/7/8.
//  Copyright (c) 2015年 Appbees.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Utility : NSObject

+ (UIViewController *) getViewController:(UIView *) targetView;

+ (void) showHUD;
+ (void) hideHUD;
+ (void) showMessage:(NSString *)content;
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+(BOOL) isEmailAddress:(NSString*)email;

@end
