//
//  LoginViewController.m
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/15.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import "LoginViewController.h"

#import "Constants.h"

#import "ModelConst.h"

#import "Utility.h"
#import <AVOSCloud/AVOSCloud.h>


@interface LoginViewController ()


@property (weak, nonatomic) IBOutlet FUITextField *emailTextField;


@property (weak, nonatomic) IBOutlet FUITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet FUIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Sign in";
    
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
    
    self.loginButton.titleLabel.font = [UIFont flatFontOfSize:20];
    self.loginButton.buttonColor = [UIColor peterRiverColor];
    self.loginButton.shadowColor = [UIColor peterRiverColor];
    self.loginButton.shadowHeight = 3.0f;
    self.loginButton.cornerRadius = 6.0f;
    
    [self.loginButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    

    
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) loginButtonPressed:(id) sender
{

}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (IBAction)finishButtonPressed:(id)sender {
    if (![Utility isEmailAddress:self.emailTextField.text]) {
        [Utility showMessage:@"Mailbox is incorrect, please re-fill."];
        return;
    }
    
    if (self.passwordTextField.text.length < 6) {
        [Utility showMessage:@"The password length should not be less than 6."];
        return;
    }
    
    [UserModel login:self.emailTextField.text password:self.passwordTextField.text success:^(UserModel *user) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginDidFinished object:nil];
        [UIView animateWithDuration:0.3 animations:^{
            self.navigationController.view.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self.navigationController.view removeFromSuperview];
        }];
        
        [UserModel setInstallationId:[UserModel sharedLoginUser].uid installationId:[AVInstallation currentInstallation].objectId success:^(UserModel *user) {
        
        } failure:^(NSError *err) {
            
        }];
    } failure:^(NSError *err) {
        [Utility showMessage:@"Login Failed."];

    }];

    
}



@end
