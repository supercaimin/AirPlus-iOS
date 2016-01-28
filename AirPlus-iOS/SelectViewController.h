//
//  SelectViewController.h
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/15.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    APSelectCityLevel,
    APSelectSchoolLevel,
    APSelectLocationLevel
} APSelectLevel;

typedef enum {
    APSelectRegisterType,
    APSelectAddType

} APSelectType;



@interface SelectViewController : UIViewController

@property (assign, nonatomic) APSelectLevel level;
@property (assign, nonatomic) APSelectType type;


@property (strong, nonatomic) id selectedObject;



@end
