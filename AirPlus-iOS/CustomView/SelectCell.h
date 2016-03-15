//
//  SelectCell.h
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/3/15.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCell : UITableViewCell
+ (SelectCell *) selectCellWithTableView:(UITableView *)tableView;
- (void) configure:(NSString *) iconUrl name:(NSString *)name;
@end
