//
//  PMItemCell.m
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/17.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import "PMItemCell.h"

#import "Constants.h"

@interface PMItemCell ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *deviceLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@property (weak, nonatomic) IBOutlet UILabel *pm25Label;

@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;


@end

@implementation PMItemCell

+ (PMItemCell *) PMItemCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell";
    PMItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PMItemCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
    
    self.timeLabel.font = [UIFont flatFontOfSize:14.0];
    self.deviceLabel.font = [UIFont boldFlatFontOfSize:17.0];
    self.locationLabel.font = [UIFont flatFontOfSize:14.0];
    self.valueLabel.font = [UIFont boldFlatFontOfSize:40.0];
    self.pm25Label.font = [UIFont flatFontOfSize:14.0];
    self.gradeLabel.font = [UIFont flatFontOfSize:12.0];
    self.gradeLabel.backgroundColor = [UIColor greenSeaColor];
    [self.gradeLabel.layer setCornerRadius:4.0];
    self.gradeLabel.layer.masksToBounds = YES;
    self.gradeLabel.textColor = [UIColor whiteColor];
    
    int x = arc4random() % 130;
    
    self.valueLabel.text = [NSString stringWithFormat:@"%d", x];
    if (x > 90) {
        self.gradeLabel.text = @"BAD";
        self.gradeLabel.backgroundColor = [UIColor redColor];
    }else if(x > 50){
        self.gradeLabel.text = @"FAIR";
        self.gradeLabel.backgroundColor = [UIColor orangeColor];
    }else{
        self.gradeLabel.text = @"GOOD";
        self.gradeLabel.backgroundColor = [UIColor greenSeaColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
