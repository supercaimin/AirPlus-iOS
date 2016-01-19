//
//  Constants.h
//  P2P
//
//  Created by 蔡 敏 on 15/2/2.
//  Copyright (c) 2015年 Appbees.net. All rights reserved.
//

#ifndef P2P_Constants_h
#define P2P_Constants_h

#import <MBProgressHUD/MBProgressHUD.h>

#import "UIColor+RCColor.h"
#import "UIImage+RCImage.h"

#import "UIColor+FlatUI.h"
#import "UISlider+FlatUI.h"
#import "UIStepper+FlatUI.h"
#import "UITabBar+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "FUIButton.h"
#import "FUISwitch.h"
#import "UIFont+FlatUI.h"
#import "FUIAlertView.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UIProgressView+FlatUI.h"
#import "FUISegmentedControl.h"
#import "UIPopoverController+FlatUI.h"
#import "NSString+Icons.h"
#import "UITableViewCell+FlatUI.h"


#define RGB(r, g, b) \
[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r, g, b, a) \
[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define STRING(a) a==[NSNull null]?@"":a

#define ERROR_INFO(ErrorDomain,ErrorCode,ErroeDescript) [[NSError alloc] initWithDomain:[NSString stringWithFormat:ErrorDomain] code:ErrorCode userInfo:[NSDictionary dictionaryWithObject:ErroeDescript forKey:NSLocalizedDescriptionKey]];


#define ERROR_NOINFO(ErrorDomain,ErrorCode) [[NSError alloc] initWithDomain:[NSString stringWithFormat:ErrorDomain] code:ErrorCode userInfo:nil];


#define ERROR_DICTINFO(ErrorDomain,ErrorCode,ErroeDictionary) [[NSError alloc] initWithDomain:[NSString stringWithFormat:ErrorDomain] code:ErrorCode userInfo:ErroeDictionary];

#define DEFAULTS [NSUserDefaults standardUserDefaults]
#define ShareApplicationDelegate [[UIApplication sharedApplication] delegate]
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define is_IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#pragma mark - 硬件
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define iPhone6                                                                \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                \
? CGSizeEqualToSize(CGSizeMake(750, 1334),                              \
[[UIScreen mainScreen] currentMode].size)           \
: NO)
#define iPhone6Plus                                                            \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                \
? CGSizeEqualToSize(CGSizeMake(1242, 2208),                             \
[[UIScreen mainScreen] currentMode].size)           \
: NO)


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#define FAKE_SERVER     @"http://121.40.33.126:8086/index.php/api/"
#define BASE_URL        @"http://121.40.33.126:8086/"



#define IMAGE_URL(path) [NSString stringWithFormat:@"%@%@", BASE_URL, path]
#define NSTRING(s)       s == [NSNull null]?@"":s

#define DEFAULT_USER_PORTRAIT    IMAGE_URL(@"assets/admin/images/default-headimage.jpg")



#define kWXAPP_ID  @"wxfc6d08159f36df72"
#define kWXAPP_SECRET   @"04f189702ce2dcf7d1ca913b8902a073"

#ifndef TARGET_IPHONE_SIMULATOR
#define CLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define CLog(...) {}

#endif


#endif


