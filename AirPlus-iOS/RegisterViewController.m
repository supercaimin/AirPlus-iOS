//
//  RegisterViewController.m
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/15.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import "RegisterViewController.h"

#import "Constants.h"

@interface RegisterViewController ()


@property (weak, nonatomic) IBOutlet FUITextField *emailTextField;


@property (weak, nonatomic) IBOutlet FUITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet FUITextField *confirmPasswordTextField;



@property (weak, nonatomic) IBOutlet FUIButton *registerButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Register";
    
    self.view.backgroundColor = [UIColor cloudsColor];
    
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
    
    self.emailTextField.font = [UIFont flatFontOfSize:20];
    [self.emailTextField setTextFieldColor:[UIColor cloudsColor]];
    [ self.emailTextField setBorderColor:[UIColor asbestosColor]];
    [ self.emailTextField setCornerRadius:4];
    [ self.emailTextField setFont:[UIFont flatFontOfSize:14]];
    [ self.emailTextField setTextColor:[UIColor midnightBlueColor]];
    
    self.passwordTextField.font = [UIFont flatFontOfSize:20];
    [self.passwordTextField setTextFieldColor:[UIColor cloudsColor]];
    [ self.passwordTextField setBorderColor:[UIColor asbestosColor]];
    [ self.passwordTextField setCornerRadius:4];
    [ self.passwordTextField setFont:[UIFont flatFontOfSize:14]];
    [ self.passwordTextField setTextColor:[UIColor midnightBlueColor]];
    
    self.confirmPasswordTextField.font = [UIFont flatFontOfSize:20];
    [self.confirmPasswordTextField setTextFieldColor:[UIColor cloudsColor]];
    [ self.confirmPasswordTextField setBorderColor:[UIColor asbestosColor]];
    [ self.confirmPasswordTextField setCornerRadius:4];
    [ self.confirmPasswordTextField setFont:[UIFont flatFontOfSize:14]];
    [ self.confirmPasswordTextField setTextColor:[UIColor midnightBlueColor]];
    
    self.registerButton.titleLabel.font = [UIFont flatFontOfSize:20];
    self.registerButton.buttonColor = [UIColor turquoiseColor];
    self.registerButton.shadowColor = [UIColor greenSeaColor];
    self.registerButton.shadowHeight = 3.0f;
    self.registerButton.cornerRadius = 6.0f;
    
    [self.registerButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.registerButton addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) loginButtonPressed:(id) sender
{
}

- (IBAction)finishButtonPressed:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationController.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.navigationController.view removeFromSuperview];
    }];
    
}


@end
