//
//  SelectViewController.m
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/15.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import "SelectViewController.h"

#import "Constants.h"

#import "ICETutorialController.h"

#import "RegisterViewController.h"

static NSString * const FUITableViewControllerCellReuseIdentifier = @"FUITableViewControllerCellReuseIdentifier";


@interface SelectViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *citys;
@property (nonatomic, strong) NSArray *schools;
@property (nonatomic, strong) NSArray *devices;

@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.level == APSelectCityLevel) {
        self.title = @"Select City";
    }else if(self.level == APSelectSchoolLevel){
        self.title = @"Select School";
    }else{
        self.title = @"Select a Device";
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
    
    self.citys = @[@"Nanjing"];
    
    self.schools = @[@"Nanjing International School"];
    
    self.devices = @[@"NIS Design Center", @"NIS Gym", @"ABCCDDD"];
    
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
    if (self.level == APSelectCityLevel) {
        return self.citys.count;
    }
    
    if (self.level == APSelectLocationLevel) {
        return self.devices.count;
    }
    
    if (self.level == APSelectSchoolLevel) {
        return self.schools.count;
    }
    return 0;
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
    UIRectCorner corners = 0;
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:FUITableViewControllerCellReuseIdentifier];
    [cell configureFlatCellWithColor:[UIColor cloudsColor]
                       selectedColor:[UIColor greenSeaColor]
                     roundingCorners:corners];
    cell.textLabel.textColor = [UIColor blackColor];
    
    cell.textLabel.font = [UIFont flatFontOfSize:17.0];
    cell.cornerRadius = 0.f;
    
    if (self.level == APSelectCityLevel) {
        cell.textLabel.text = [self.citys objectAtIndex:indexPath.section];
    }else if(self.level == APSelectSchoolLevel){
        cell.textLabel.text = [self.schools objectAtIndex:indexPath.section];
    }else{
 
        
        if(indexPath.section == 3 ){
            cell.textLabel.text = [self.devices objectAtIndex:indexPath.section];
            cell.textLabel.textColor = [UIColor darkGrayColor];
        }else{
            NSString *text = [NSString stringWithFormat:@"%@%@", [NSString iconStringForEnum:FUIEye], [self.devices objectAtIndex:indexPath.section]];
            cell.textLabel.font = [UIFont iconFontWithSize:17.0];
            cell.textLabel.text = text;
            cell.textLabel.textColor = [UIColor greenSeaColor];
        }

    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.level == APSelectCityLevel) {
        SelectViewController *sVc = [[SelectViewController alloc] init];
        sVc.level = APSelectSchoolLevel;
        sVc.type = self.type;
        [self.navigationController pushViewController:sVc animated:YES];
    }else{
        if (self.type == APSelectRegisterType) {
            
            RegisterViewController *rVc = [[RegisterViewController alloc] init];
            [self.navigationController pushViewController:rVc animated:YES];
        }else{
            if (self.level == APSelectSchoolLevel) {
                SelectViewController *sVc = [[SelectViewController alloc] init];
                sVc.level = APSelectLocationLevel;
                sVc.type = self.type;
                [self.navigationController pushViewController:sVc animated:YES];
            }else if(self.level == APSelectLocationLevel){
                if(indexPath.section % 2 == 0 ){
                }else{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }
        }
    }
}


@end
