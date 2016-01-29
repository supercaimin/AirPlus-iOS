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

#import "ICETutorialController.h"

#import "RegisterViewController.h"

#import "PM25ViewController.h"

static NSString * const FUITableViewControllerCellReuseIdentifier = @"FUITableViewControllerCellReuseIdentifier";


@interface SelectViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *datas;

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
    UIRectCorner corners = 0;
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:FUITableViewControllerCellReuseIdentifier];
    [cell configureFlatCellWithColor:[UIColor cloudsColor]
                       selectedColor:[UIColor peterRiverColor]
                     roundingCorners:corners];
    cell.textLabel.textColor = [UIColor blackColor];
    
    cell.textLabel.font = [UIFont flatFontOfSize:17.0];
    cell.cornerRadius = 0.f;
    
    if (self.level == APSelectCityLevel) {
        CityModel *city = [self.datas objectAtIndex:indexPath.section];
        cell.textLabel.text = city.key;
    }else if(self.level == APSelectSchoolLevel){
        SchoolModel *school = [self.datas objectAtIndex:indexPath.section];
        cell.textLabel.text = school.name;
    }else{
        InstrumentModel *instrument = [self.datas objectAtIndex:indexPath.section];

        if(!instrument.isPublic &&![instrument.schoolId isEqualToString:[UserModel sharedLoginUser].uid]){
            cell.textLabel.text = instrument.name;
            cell.textLabel.textColor = [UIColor darkGrayColor];
        }else{
            cell.textLabel.text = instrument.name;
            NSString *text = [NSString stringWithFormat:@"%@%@", [NSString iconStringForEnum:FUIEye], instrument.name];
            cell.textLabel.font = [UIFont iconFontWithSize:17.0];
            cell.textLabel.text = text;
            cell.textLabel.textColor = [UIColor peterRiverColor];
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
        sVc.selectedObject = [self.datas objectAtIndex:indexPath.section];
        [self.navigationController pushViewController:sVc animated:YES];
    }else{
        if (self.type == APSelectRegisterType) {
            
            RegisterViewController *rVc = [[RegisterViewController alloc] init];
            rVc.school =  [self.datas objectAtIndex:indexPath.section];
            [self.navigationController pushViewController:rVc animated:YES];
        }else{
            if (self.level == APSelectSchoolLevel) {
                SelectViewController *sVc = [[SelectViewController alloc] init];
                sVc.level = APSelectLocationLevel;
                sVc.type = self.type;
                sVc.selectedObject = [self.datas objectAtIndex:indexPath.section];
                [self.navigationController pushViewController:sVc animated:YES];
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
