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

@property (strong, nonatomic) NSArray *pms;
@property (strong, nonatomic) NSArray *pm25s;

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
    
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(reset) userInfo:nil repeats:YES];
    self.pmValueLabel.hidden = YES;
    self.statusLabel.hidden = YES;
    self.xLabel.hidden = YES;
    self.outdoorPMLabel.hidden = YES;

}

- (void) loadWithData:(NSArray *) datas outPM25s:(NSArray *)outPM25s
{
    self.pmValueLabel.text = [[datas lastObject] objectForKey:@"reading"];
    self.outdoorPMLabel.text = [outPM25s lastObject];
    float x = [[outPM25s lastObject] floatValue] / [[[datas lastObject] objectForKey:@"reading"] floatValue];
    self.xLabel.text = [NSString stringWithFormat:@"%.1fx", x];
    
    NSString *displayStatus = [[datas lastObject] objectForKey:@"displayStatus"];
    
    if ([displayStatus isEqualToString:@"orange"]) {
        self.statusLabel.backgroundColor = [UIColor orangeColor];
        self.statusLabel.text = @"Light polluted";
    }
    if ([displayStatus isEqualToString:@"yellow"]) {
        self.statusLabel.backgroundColor = [UIColor yellowColor];
        self.statusLabel.text = @"Moderate";
    }
    if ([displayStatus isEqualToString:@"green"]) {
        self.statusLabel.backgroundColor = [UIColor colorWithHexString:@"0x75C83D" alpha:1.0];
        self.statusLabel.text = @"Good";
    }
    if ([displayStatus isEqualToString:@"red"]) {
        self.statusLabel.backgroundColor = [UIColor redColor];
        self.statusLabel.text = @"Unhealthy";
    }
    if ([displayStatus isEqualToString:@"purple"]) {
        self.statusLabel.backgroundColor = [UIColor purpleColor];
        self.statusLabel.text = @"Very Unhealthy";
    }
    if ([displayStatus isEqualToString:@"maroon"]) {
        self.statusLabel.backgroundColor = [UIColor magentaColor];
        self.statusLabel.text = @"Hazardous";
    }
    
    CGSize labelsize = [self.statusLabel.text sizeWithFont:self.statusLabel.font constrainedToSize:CGSizeMake(320,2000) lineBreakMode:UILineBreakModeWordWrap];
    
    self.statusLabel.frame = CGRectMake(self.statusLabel.frame.origin.x, self.statusLabel.frame.origin.y, labelsize.width + 10.0, self.statusLabel.frame.size.height);
    [self parse24hIndoor:datas];
    self.pm25s = outPM25s;
    [self _setupExampleGraph];
    
    self.pmValueLabel.hidden = NO;
    self.statusLabel.hidden = NO;
    self.xLabel.hidden = NO;
    self.outdoorPMLabel.hidden = NO;
}

- (void) parse24hIndoor:(NSArray *)datas
{
    NSMutableArray *hours = [[NSMutableArray alloc] init];
    NSMutableArray *pms = [[NSMutableArray alloc] init];
    NSArray* reversedArray = [[datas reverseObjectEnumerator] allObjects];

    [reversedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict = obj;
        NSString *date = [dict objectForKey:@"readingDate"];
        NSString *hour = [date substringWithRange:NSMakeRange(11, 2)];
        if (![[hours lastObject] isEqualToString:hour]) {
            [hours addObject:hour];
            [pms addObject:[dict objectForKey:@"reading"]];
        }
        if (hours.count == 24) {
            *stop = YES;
        }
    }];
    
    self.pms =  [[pms reverseObjectEnumerator] allObjects];
}
- (void)_setupExampleGraph {
    
    self.graph.backgroundColor = [UIColor cloudsColor];
    self.graph.opaque = NO;
    self.graph.dataSource = self;
    self.graph.lineWidth = 1.0;
    
    self.graph.startFromZero = YES;
    
    self.graph.valueLabelCount = 6;
        
    [self.graph draw];
}


#pragma mark - GKLineGraphDataSource

- (NSInteger)numberOfLines {
    return 2;
}

- (UIColor *)colorForLineAtIndex:(NSInteger)index {
    id colors = @[[UIColor wisteriaColor],
                  [UIColor peterRiverColor]
                  ];
    return [colors objectAtIndex:index];
}

- (NSArray *)valuesForLineAtIndex:(NSInteger)index {
    if (index == 0) {
        return self.pms;
    }
    return self.pm25s;
}

- (CFTimeInterval)animationDurationForLineAtIndex:(NSInteger)index {
    return [[@[@1, @1.6, @2.2, @1.4] objectAtIndex:index] doubleValue];
}

- (NSString *)titleForLineAtIndex:(NSInteger)index {
    return @".";
}


- (void)reset {
    
    [self.graph reset];
    [self.graph draw];
}

@end
