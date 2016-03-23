//
//  SelectViewController.m
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/15.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import "SelectViewController.h"

#import "Constants.h"

#import "ModelConst.h"

#import "Utility.h"

#import <SDWebImage/UIImageView+WebCache.h>


#import "ICETutorialController.h"

#import "RegisterViewController.h"

#import "PM25ViewController.h"

#import "SelectCell.h"

static NSString * const FUITableViewControllerCellReuseIdentifier = @"FUITableViewControllerCellReuseIdentifier";


@interface SelectViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) NSArray *datas;

@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    
    if (self.level == APSelectCityLevel) {
        self.title = @"Select City";
        self.tipLabel.text = @"  Please choose your city.";
    }else if(self.level == APSelectSchoolLevel){
        self.title = @"Select School";
        self.tipLabel.text = @"  Please choose your school.";
    }else{
        self.title = @"Select Device";
        self.tipLabel.text = @"  Please choose one or all locations for PM2.5 datas.";
    }
    
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
    
    [self.tableView reloadData];
    
    
    if (self.level == APSelectCityLevel) {
        
        [CityModel getAll:^(NSArray *citys) {
            self.datas = citys;
            [self.tableView reloadData];
        } failure:^(NSError *err) {
            
        }];
    }else if (self.level == APSelectSchoolLevel){
        CityModel *city = (CityModel *)self.selectedObject;
        [SchoolModel getSchoolsWithCityId:city.uid success:^(NSArray *schools) {
            self.datas = schools;
            [self.tableView reloadData];
        } failure:^(NSError *err) {
            
        }];
    }else{
            SchoolModel *school = (SchoolModel *)self.selectedObject;
            [InstrumentModel getInstrumentsWithSchoolId:school.uid success:^(NSArray *instruments) {
                self.datas = instruments;
                [self.tableView reloadData];
            } failure:^(NSError *err) {
                
            }];
    }
    
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.type == APSelectRegisterType) {
        [Utility showMessage:@"Welcome to sign up with AirPlus."];
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.level == APSelectCityLevel) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.level == APSelectCityLevel && [self.navigationController.topViewController isKindOfClass:[ICETutorialController class]]) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}


- (UITableView *) tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        _tipLabel.font = [UIFont systemFontOfSize:12.0];
        _tipLabel.textColor = [UIColor grayColor];
        _tableView.tableHeaderView = _tipLabel;
        //Set the background color
        _tableView.backgroundColor = [UIColor cloudsColor];
        _tableView.backgroundView = nil;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FUITableViewControllerCellReuseIdentifier];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectCell *cell = [SelectCell selectCellWithTableView:tableView];
    
    if (self.level == APSelectCityLevel) {
        CityModel *city = [self.datas objectAtIndex:indexPath.section];
        [cell configure:city.logo name:city.key];
    }else if(self.level == APSelectSchoolLevel){
        SchoolModel *school = [self.datas objectAtIndex:indexPath.section];
        [cell configure:school.logo name:school.name];

    }else{
        InstrumentModel *instrument = [self.datas objectAtIndex:indexPath.section];
        [cell configure:nil name:instrument.name];
        
    }
    
    return cell;
}

- (void)showAlert {
    FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"The school is not allowed to access." message:@"Please contact the admin to get the account." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    alertView.alertViewStyle = FUIAlertViewStyleDefault;
    alertView.tag = 100;
    
    alertView.delegate = nil;
    alertView.titleLabel.textColor = [UIColor cloudsColor];
    alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    alertView.messageLabel.textColor = [UIColor cloudsColor];
    alertView.messageLabel.font = [UIFont flatFontOfSize:14];
    alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
    alertView.alertContainer.backgroundColor = [UIColor peterRiverColor];
    alertView.defaultButtonColor = [UIColor cloudsColor];
    alertView.defaultButtonShadowColor = [UIColor asbestosColor];
    alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
    alertView.defaultButtonTitleColor = [UIColor asbestosColor];
    [alertView show];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.level == APSelectCityLevel) {
        SelectViewController *sVc = [[SelectViewController alloc] init];
        sVc.level = APSelectSchoolLevel;
        sVc.type = self.type;
        sVc.selectedObject = [self.datas objectAtIndex:indexPath.section];
        [self.navigationController pushViewController:sVc animated:YES];
    }else{
        if (self.type == APSelectRegisterType) {
            SchoolModel *school = [self.datas objectAtIndex:indexPath.section];
            if ([school.isOpen isEqualToString:@"1"]) {
                RegisterViewController *rVc = [[RegisterViewController alloc] init];
                rVc.school =  [self.datas objectAtIndex:indexPath.section];
                [self.navigationController pushViewController:rVc animated:YES];
            }else{
                [self showAlert];
            }
        }else{
            if (self.level == APSelectSchoolLevel) {
                SchoolModel *school = [self.datas objectAtIndex:indexPath.section];
                
                if ([school.isOpen isEqualToString:@"1"]) {
                    SelectViewController *sVc = [[SelectViewController alloc] init];
                    sVc.level = APSelectLocationLevel;
                    sVc.type = self.type;
                    sVc.selectedObject = school;
                    [self.navigationController pushViewController:sVc animated:YES];
                }else{
                    if ([[UserModel sharedLoginUser].schoolId isEqualToString:school.uid]) {
                        SelectViewController *sVc = [[SelectViewController alloc] init];
                        sVc.level = APSelectLocationLevel;
                        sVc.type = self.type;
                        sVc.selectedObject = school;
                        [self.navigationController pushViewController:sVc animated:YES];
                    }else{
                        [self showAlert];

                    }
                    
                }
            }else if(self.level == APSelectLocationLevel){
                InstrumentModel *instrument = [self.datas objectAtIndex:indexPath.section];
                
                if(instrument.isPublic || [instrument.schoolId isEqualToString:[UserModel sharedLoginUser].uid]){
                    PM25ViewController *pVc = [[PM25ViewController alloc] init];
                    pVc.instrument = instrument;
                    [self.navigationController pushViewController:pVc animated:YES];
                }
            }
        }
    }
}


@end
