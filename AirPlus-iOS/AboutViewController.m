//
//  AboutViewController.m
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/17.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import "AboutViewController.h"

#import "Constants.h"

@interface AboutViewController ()


@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;


@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"About";
    
    self.view.backgroundColor = [UIColor cloudsColor];
    
    self.aboutLabel.textColor = [UIColor greenSeaColor];
    
    FUIButton *closeButton = [[FUIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 16)];
    closeButton.titleLabel.font = [UIFont iconFontWithSize:20];
    //menuButton.buttonColor = [UIColor turquoiseColor];
    //menuButton.shadowColor = [UIColor greenSeaColor];
    //menuButton.shadowHeight = 3.0f;
    //menuButton.cornerRadius = 6.0f;
    [closeButton setTitle:[NSString iconStringForEnum:FUIArrowLeft] forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    
    [closeButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
