//
//  PMDetailsView.m
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/18.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import "PMDetailsView.h"

#import "GraphKit.h"

#import "Constants.h"

@interface PMDetailsView ()<GKLineGraphDataSource>

@property (nonatomic, weak) IBOutlet GKLineGraph *graph;

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *labels;


@property (weak, nonatomic) IBOutlet UILabel *pmValueLabel;

@property (weak, nonatomic) IBOutlet UILabel *xLabel;

@property (weak, nonatomic) IBOutlet UILabel *outdoorPMLabel;

@property (weak, nonatomic) IBOutlet UILabel *tip1Label;

@property (weak, nonatomic) IBOutlet UILabel *tip2Label;

@property (weak, nonatomic) IBOutlet UILabel *tip3Label;

@property (weak, nonatomic) IBOutlet UILabel *tip4Label;

@property (weak, nonatomic) IBOutlet UILabel *tip5Label;


@property (weak, nonatomic) IBOutlet UILabel *tip6Label;

@property (weak, nonatomic) IBOutlet UILabel *unit1Label;

@property (weak, nonatomic) IBOutlet UILabel *unit2Label;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation PMDetailsView


+ (id) instancePMDetailsView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"PMDetailsView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

- (void) awakeFromNib
{
    self.pmValueLabel.font = [UIFont boldFlatFontOfSize:40];
    self.xLabel.font = [UIFont boldFlatFontOfSize:20];
    self.outdoorPMLabel.font = [UIFont boldFlatFontOfSize:20];
    
    self.tip1Label.font = [UIFont flatFontOfSize:10.0];
    self.tip2Label.font = [UIFont flatFontOfSize:10.0];

    self.tip3Label.font = [UIFont flatFontOfSize:10.0];
    self.tip4Label.font = [UIFont flatFontOfSize:10.0];

    self.tip5Label.font = [UIFont flatFontOfSize:10.0];
    self.tip6Label.font = [UIFont flatFontOfSize:10.0];
    
    self.unit1Label.font = [UIFont flatFontOfSize:10.0];
    
    self.unit2Label.font = [UIFont flatFontOfSize:10.0];
    self.statusLabel.layer.cornerRadius = 2.0;
    self.statusLabel.layer.masksToBounds = YES;

}

- (void)load
{
    [self _setupExampleGraph];
}
- (void)_setupExampleGraph {
    
    self.graph.backgroundColor = [UIColor cloudsColor];
    
    self.data = @[
                  @[@20, @40, @20, @60, @40, @140, @80],
                  @[@120, @150, @80, @120, @140, @100, @0],
                  //                  @[@620, @650, @580, @620, @540, @400, @0]
                  ];
    
    self.labels = @[@"12:00", @"13:00", @"14:00", @"15:00", @"16:00", @"17:00", @"18:00"];
    
    self.graph.dataSource = self;
    self.graph.lineWidth = 1.0;
    
    self.graph.valueLabelCount = 6;
    
    [self.graph draw];
}

- (void)_setupTestingGraphLow {
    
    /*
     A custom max and min values can be achieved by adding
     values for another line and setting its color to clear.
     */
    
    self.data = @[
                  @[@10, @4, @8, @2, @9, @3, @6],
                  @[@1, @2, @3, @4, @5, @6, @10]
                  ];
    //    self.data = @[
    //                  @[@2, @2, @2, @2, @2, @2, @6],
    //                  @[@1, @1, @1, @1, @1, @1, @1]
    //                  ];
    
    self.labels = @[@"12:00", @"13:00", @"14:00", @"15:00", @"16:00", @"17:00", @"18:00"];
    
    self.graph.dataSource = self;
    self.graph.lineWidth = 1.0;
    
    //    self.graph.startFromZero = YES;
    self.graph.valueLabelCount = 10;
    
    [self.graph draw];
}

- (void)_setupTestingGraphHigh {
    
    self.data = @[
                  @[@1000, @2000, @3000, @4000, @5000, @6000, @10000]
                  ];
    
    self.labels = @[@"2001", @"2002", @"2003", @"2004", @"2005", @"2006", @"2007"];
    
    self.graph.dataSource = self;
    self.graph.lineWidth = 3.0;
    
    //    self.graph.startFromZero = YES;
    self.graph.valueLabelCount = 10;
    
    [self.graph draw];
}

#pragma mark - GKLineGraphDataSource

- (NSInteger)numberOfLines {
    return [self.data count];
}

- (UIColor *)colorForLineAtIndex:(NSInteger)index {
    id colors = @[[UIColor greenSeaColor],
                  [UIColor wisteriaColor]
                  ];
    return [colors objectAtIndex:index];
}

- (NSArray *)valuesForLineAtIndex:(NSInteger)index {
    return [self.data objectAtIndex:index];
}

- (CFTimeInterval)animationDurationForLineAtIndex:(NSInteger)index {
    return [[@[@1, @1.6, @2.2, @1.4] objectAtIndex:index] doubleValue];
}

- (NSString *)titleForLineAtIndex:(NSInteger)index {
    return [self.labels objectAtIndex:index];
}


- (IBAction)draw:(id)sender {
    
    [self.graph reset];
    [self.graph draw];
}

- (IBAction)reset:(id)sender {
    
    [self.graph reset];

}
@end
