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
    }
    if ([displayStatus isEqualToString:@"yellow"]) {
        self.statusLabel.backgroundColor = [UIColor yellowColor];
    }
    if ([displayStatus isEqualToString:@"green"]) {
        self.statusLabel.backgroundColor = [UIColor greenSeaColor];
    }
    if ([displayStatus isEqualToString:@"red"]) {
        self.statusLabel.backgroundColor = [UIColor redColor];
    }
    if ([displayStatus isEqualToString:@"purple"]) {
        self.statusLabel.backgroundColor = [UIColor purpleColor];
    }
    if ([displayStatus isEqualToString:@"maroon"]) {
        self.statusLabel.backgroundColor = [UIColor magentaColor];
    }
    
    
    int xx = [self.pmValueLabel.text integerValue];
    
    if (xx > 200) {
        self.statusLabel.text = @"BAD";
        self.statusLabel.backgroundColor = [UIColor redColor];
    }else if(xx > 100){
        self.statusLabel.text = @"FAIR";
        self.statusLabel.backgroundColor = [UIColor orangeColor];
    }else{
        self.statusLabel.text = @"GOOD";
        self.statusLabel.backgroundColor = [UIColor greenSeaColor];
    }
    [self parse24hIndoor:datas];
    self.pm25s = outPM25s;
    [self _setupExampleGraph];
}

- (void) parse24hIndoor:(NSArray *)datas
{
    NSMutableArray *hours = [[NSMutableArray alloc] init];
    NSMutableArray *pms = [[NSMutableArray alloc] init];
    [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    
    self.pms = pms;
}
- (void)_setupExampleGraph {
    
    self.graph.backgroundColor = [UIColor cloudsColor];
    
    self.graph.dataSource = self;
    self.graph.lineWidth = 1.0;
    
    self.graph.startFromZero = YES;
    
    self.graph.valueLabelCount = 8;
    
    [self.graph draw];
}


#pragma mark - GKLineGraphDataSource

- (NSInteger)numberOfLines {
    return 2;
}

- (UIColor *)colorForLineAtIndex:(NSInteger)index {
    id colors = @[[UIColor greenSeaColor],
                  [UIColor wisteriaColor]
                  ];
    return [colors objectAtIndex:index];
}

- (NSArray *)valuesForLineAtIndex:(NSInteger)index {
    if (index == 0) {
        return self.pm25s;
    }
    return self.pms;
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
