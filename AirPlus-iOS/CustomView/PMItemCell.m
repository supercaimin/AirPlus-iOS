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
    self.gradeLabel.backgroundColor = [UIColor peterRiverColor];
    [self.gradeLabel.layer setCornerRadius:4.0];
    self.gradeLabel.layer.masksToBounds = YES;
    self.gradeLabel.textColor = [UIColor whiteColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) configureWithData:(NSDictionary *) pm
                  location:(NSString *)location
                    school:(NSString *)school;
{
    self.deviceLabel.text = location;
    self.locationLabel.text = school;
    NSString *time = [pm objectForKey:@"readingDate"];
    time = [time stringByReplacingOccurrencesOfString:@"上午" withString:@"AM"];
    time = [time stringByReplacingOccurrencesOfString:@"下午" withString:@"PM"];
    self.timeLabel.text = time;

    self.valueLabel.text = [pm objectForKey:@"reading"];
    
    NSString *displayStatus = [pm objectForKey:@"displayStatus"];
    if ([displayStatus isEqualToString:@"orange"]) {
        self.gradeLabel.backgroundColor = [UIColor orangeColor];
        self.gradeLabel.text = @"Light polluted";
    }
    if ([displayStatus isEqualToString:@"yellow"]) {
        self.gradeLabel.backgroundColor = [UIColor yellowColor];
        self.gradeLabel.text = @"Moderate";
    }
    if ([displayStatus isEqualToString:@"green"]) {
        self.gradeLabel.backgroundColor = [UIColor colorWithHexString:@"0x75C83D" alpha:1.0];
        self.gradeLabel.text = @"Good";
    }
    if ([displayStatus isEqualToString:@"red"]) {
        self.gradeLabel.backgroundColor = [UIColor redColor];
        self.gradeLabel.text = @"Unhealthy";
    }
    if ([displayStatus isEqualToString:@"purple"]) {
        self.gradeLabel.backgroundColor = [UIColor purpleColor];
        self.gradeLabel.text = @"Very Unhealthy";
    }
    if ([displayStatus isEqualToString:@"maroon"]) {
        self.gradeLabel.backgroundColor = [UIColor magentaColor];
        self.gradeLabel.text = @"Hazardous";
    }

    CGSize labelsize = [self.gradeLabel.text sizeWithFont:self.gradeLabel.font constrainedToSize:CGSizeMake(320,2000) lineBreakMode:UILineBreakModeWordWrap];
    
    self.gradeLabel.frame = CGRectMake(320 - labelsize.width - 30, self.gradeLabel.frame.origin.y, labelsize.width + 10.0, self.gradeLabel.frame.size.height);

}
@end
