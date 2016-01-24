//
//  PMDetailsView.h
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/18.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMDetailsView : UIView
+ (id) instancePMDetailsView;

- (void) loadWithData:(NSArray *) datas outPM25s:(NSArray *)outPM25s;

@end
