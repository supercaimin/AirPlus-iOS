//
//  SelectCell.m
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/3/15.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import "SelectCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SelectCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation SelectCell

- (void)awakeFromNib {
    // Initialization code
}


+ (SelectCell *) selectCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell";
    SelectCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SelectCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configure:(NSString *)iconUrl name:(NSString *)name
{
    if (iconUrl != nil) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconUrl] ];
    }else{
        self.nameLabel.frame = CGRectMake(10, self.nameLabel.frame.origin.y, self.nameLabel.frame.size.width + 60, self.nameLabel.frame.size.height);
    }
    self.nameLabel.text = name;
    
    
}

@end
