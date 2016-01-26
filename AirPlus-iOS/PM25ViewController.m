//
//  PM25ViewController.m
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/17.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import "PM25ViewController.h"

#import "JSAnimatedImagesView.h"

#import "PMDetailsView.h"

#import "Constants.h"

@interface PM25ViewController ()<JSAnimatedImagesViewDataSource>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet JSAnimatedImagesView *animatedImagesView;

@property (strong, nonatomic) PMDetailsView *pmContentView;

@property (strong, nonatomic) NSArray *outPM25s;

@end

@implementation PM25ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cloudsColor];
    
    FUIButton *closeButton = [[FUIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 16)];
    closeButton.titleLabel.font = [UIFont iconFontWithSize:20];
    [closeButton setTitle:[NSString iconStringForEnum:FUIArrowLeft] forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    
    [closeButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    self.animatedImagesView.dataSource = self;
    
    UIView *buttomToolbar = [[UIView alloc] initWithFrame:
                            
                            CGRectMake(0.0f, SCREEN_HEIGHT - 44.0f, 320.0f, 44.0f)];
    buttomToolbar.backgroundColor = RGBA(0x16, 0xa0, 0x85, 0.5);
    UILabel *addLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 2, 200, 40)];
    addLabel.font = [UIFont iconFontWithSize:16.0];
    addLabel.textColor = [UIColor cloudsColor];
    addLabel.text =[NSString stringWithFormat:@"%@Add To Home", [NSString iconStringForEnum:FUIPlus]];
    
    addLabel.userInteractionEnabled=YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addToHome:)];
    
    [addLabel addGestureRecognizer:labelTapGestureRecognizer];
    
    [buttomToolbar addSubview:addLabel];
    
    [self.view addSubview:buttomToolbar];
    
    [self.scrollView addSubview:self.pmContentView];
    
    [AFHttpTool getOutdoorData:^(AFHttpResult *response) {

    } failure:^(NSError *err, NSString *responseString) {
        int count = 0;
        for (int i = 0; i < responseString.length; i++) {
            char c = [responseString characterAtIndex:i];
            
            if (c == 'd') {
                NSString *mark = [responseString substringWithRange:NSMakeRange(i, 6)];
                if([mark isEqualToString:@"data:["]){
                    if (count < 1) {
                        count ++;
                        continue;
                    }
                    int j = i;
                    while ([responseString characterAtIndex:j] != ']') {
                        j ++;
                    }
                    
                    NSString *pm25Str = [responseString substringWithRange:NSMakeRange(i+6, j - i - 6)];
                    self.outPM25s = [pm25Str componentsSeparatedByString:@","];

                    
                    break;
                }
            }
            
        }
        [self.pmContentView loadWithData:self.pms outPM25s:self.outPM25s];

    }];



}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIColor imageWithColor:[UIColor greenSeaColor]]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    
    
}

- (void)addToHome:(id)sender
{
    
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIScrollView *) scrollView {
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_HEIGHT, SCREEN_HEIGHT - 64 - 44)];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44 + 300);
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (PMDetailsView *) pmContentView {
    if (!_pmContentView) {
        _pmContentView = [PMDetailsView instancePMDetailsView];
        _pmContentView.frame = CGRectMake(0, 300, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44);
        _pmContentView.backgroundColor = RGBA(0xec, 0xf0, 0xf1, 0.8);
    }
    return _pmContentView;
}

#pragma mark - JSAnimatedImagesViewDataSource Methods

- (NSUInteger)animatedImagesNumberOfImages:(JSAnimatedImagesView *)animatedImagesView
{
    return 4;
}

- (UIImage *)animatedImagesView:(JSAnimatedImagesView *)animatedImagesView imageAtIndex:(NSUInteger)index
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"tutorial_background_0%d.jpg", index]];
}

@end
