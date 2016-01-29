//
//  MainViewController.m
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/15.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import "MainViewController.h"

#import "Constants.h"
#import "ModelConst.h"

#import "RNFrostedSidebar.h"

#import "PMItemCell.h"

#import "ICETutorialController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "SelectViewController.h"
#import "AboutViewController.h"

#import "PM25ViewController.h"


@interface MainViewController ()<RNFrostedSidebarDelegate, ICETutorialControllerDelegate, FUIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (strong, nonatomic) UINavigationController *tutorialNavVC;

@property (strong, nonatomic) ICETutorialController *tutorialViewController;

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, strong) NSArray *instruments;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"Air Plus";
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:0];
    
    
    self.view.backgroundColor = [UIColor cloudsColor];
    
    
    FUIButton *menuButton = [[FUIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 16)];
    menuButton.titleLabel.font = [UIFont iconFontWithSize:20];
    //menuButton.buttonColor = [UIColor turquoiseColor];
    //menuButton.shadowColor = [UIColor greenSeaColor];
    //menuButton.shadowHeight = 3.0f;
    //menuButton.cornerRadius = 6.0f;
    [menuButton setTitle:[NSString iconStringForEnum:FUIListBulleted] forState:UIControlStateNormal];
    [menuButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];

    [menuButton addTarget:self action:@selector(listButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    if (![UserModel sharedLoginUser]) {
        [self showTutorialView];
    }else{
        [self reload];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sysdata) name:kPMDataSyncSuccessNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:kLoginDidFinished object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:kRegisterDidFinished object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:kReloadNeed object:nil];

}


- (void) reload
{
    [InstrumentModel getInstrumentsWithUserId:[UserModel sharedLoginUser].uid success:^(NSArray *instruments) {
        self.instruments = instruments;
        [UserModel sharedLoginUser].instruments = instruments;
        [self sysdata];
    } failure:^(NSError *err) {
        
    }];
}
- (void) sysdata
{
    [self.instruments enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        InstrumentModel *instrument = (InstrumentModel *)obj;
        
        for (NSDictionary *pm in [AFHttpTool pmDataSyncMananger].pmdatas) {
            if ([[pm objectForKey:@"serial"] isEqualToString:instrument.serial]) {
                instrument.pm = pm;
            }
        }
    }];
    if ([AFHttpTool pmDataSyncMananger].pmdatas.count != 0) {
        [self.tableView reloadData];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //self.navigationController.navigationBar.shadowImage = [UIImage new];
    //self.navigationController.navigationBar.translucent = YES;
    
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.navigationController.navigationBar setBackgroundImage:[UIColor imageWithColor:RGBA(53, 154, 234, 1.0)]
    //                                              forBarMetrics:UIBarMetricsDefault];
    //self.navigationController.navigationBar.translucent = NO;
    
    
}

- (void) listButtonPressed:(id)sender
{
    NSArray *images = @[
                        [UIImage imageNamed:@"home"],//首页
                        [UIImage imageNamed:@"globe"],//语言
                        [UIImage imageNamed:@"about"],//关于
                        [UIImage imageNamed:@"logout"],//注销
                        ];
    NSArray *colors = @[
                        [UIColor greenSeaColor],
                        [UIColor greenSeaColor],
                        [UIColor greenSeaColor],
                        [UIColor greenSeaColor],
                        ];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    callout.delegate = self;
    //    callout.showFromRight = YES;
    [callout show];
}

- (void)addButtonPressed:(id)sender
{
    SelectViewController *sVc = [[SelectViewController alloc] init];
    sVc.level = APSelectCityLevel;
    sVc.type = APSelectAddType;
    [self.navigationController pushViewController:sVc animated:YES];
}

#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    NSLog(@"Tapped item at index %lu",(unsigned long)index);
    [self.optionIndices removeAllIndexes];
    if (index != 1 && index != 3 && index != 0) {
        [self.optionIndices addIndex:index];
    }
    
    if(index == 1){
        [self showLangOptions];
    }
    if (index == 2) {
        AboutViewController *aVc = [[AboutViewController alloc] init];
        [self.navigationController pushViewController:aVc animated:YES];
    }
    if(index == 3){
        [self showLogoutConfirm];
    }
    [sidebar dismissAnimated:YES];
}


- (void) showTutorialView
{
    ICETutorialPage *layer1 = [[ICETutorialPage alloc] initWithTitle:@""
                                                            subTitle:@""
                                                         pictureName:@"tutorial_background_00@2x.jpg"
                                                            duration:3.0];
    ICETutorialPage *layer2 = [[ICETutorialPage alloc] initWithTitle:@""
                                                            subTitle:@""
                                                         pictureName:@"tutorial_background_01@2x.jpg"
                                                            duration:3.0];
    ICETutorialPage *layer3 = [[ICETutorialPage alloc] initWithTitle:@""
                                                            subTitle:@""
                                                         pictureName:@"tutorial_background_02@2x.jpg"
                                                            duration:3.0];
    ICETutorialPage *layer4 = [[ICETutorialPage alloc] initWithTitle:@""
                                                            subTitle:@""
                                                         pictureName:@"tutorial_background_03@2x.jpg"
                                                            duration:3.0];
    NSArray *tutorialLayers = @[layer1,layer2,layer3,layer4];
    
    // Set the common style for the title.
    ICETutorialLabelStyle *titleStyle = [[ICETutorialLabelStyle alloc] init];
    [titleStyle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17.0f]];
    [titleStyle setTextColor:[UIColor whiteColor]];
    [titleStyle setLinesNumber:1];
    [titleStyle setOffset:180];
    [[ICETutorialStyle sharedInstance] setTitleStyle:titleStyle];
    
    // Set the subTitles style with few properties and let the others by default.
    [[ICETutorialStyle sharedInstance] setSubTitleColor:[UIColor whiteColor]];
    [[ICETutorialStyle sharedInstance] setSubTitleOffset:150];
    
    // Init tutorial.
    self.tutorialViewController = [[ICETutorialController alloc] initWithPages:tutorialLayers
                                                              delegate:self];
    
    // Run it.
    [self.tutorialViewController startScrolling];
    
    self.tutorialNavVC = [[UINavigationController alloc] initWithRootViewController:self.tutorialViewController];
    
    [self.tutorialNavVC setNavigationBarHidden:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:self.tutorialNavVC.view];

}

- (UITableView *) tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        
        //Set the background color
        _tableView.backgroundColor = [UIColor cloudsColor];
        _tableView.backgroundView = nil;
        _tableView.showsVerticalScrollIndicator = NO;
        
        
        FUIButton *addButton = [[FUIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 90)];
        addButton.titleLabel.font = [UIFont iconFontWithSize:40];
        addButton.buttonColor = RGBA(0x16, 0xa0, 0x85, 0.8);
        addButton.shadowColor = RGBA(0x16, 0xa0, 0x85, 0.8);
        addButton.shadowHeight = 0.0f;
        addButton.cornerRadius = 0.0f;
        
        [addButton setTitle:[NSString iconStringForEnum:FUIPlus] forState:UIControlStateNormal];
        [addButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        
        [addButton addTarget:self action:@selector(addButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        _tableView.tableFooterView = addButton;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.instruments.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIRectCorner corners = 0;
    PMItemCell *cell = [PMItemCell PMItemCellWithTableView:tableView];
    [cell configureFlatCellWithColor:[UIColor cloudsColor]
                       selectedColor:[UIColor greenSeaColor]
                     roundingCorners:corners];
    InstrumentModel *instrument = [self.instruments objectAtIndex:indexPath.section];
    [cell configureWithData:instrument.pm location:instrument.name school:instrument.schoolName];
    
    cell.cornerRadius = 0.f; //Optional
    cell.separatorHeight = 2.f;

    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PM25ViewController *pVc = [[PM25ViewController alloc] init];
    pVc.instrument = [self.instruments objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:pVc animated:YES];
    
}


#pragma mark - ICETutorialController delegate
- (void)tutorialController:(ICETutorialController *)tutorialController scrollingFromPageIndex:(NSUInteger)fromIndex toPageIndex:(NSUInteger)toIndex {
}

- (void)tutorialControllerDidReachLastPage:(ICETutorialController *)tutorialController {
}

- (void)tutorialController:(ICETutorialController *)tutorialController didClickOnLeftButton:(UIButton *)sender {
    [self.tutorialViewController stopScrolling];

    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    [self.tutorialNavVC pushViewController:loginViewController animated:YES];
}

- (void)tutorialController:(ICETutorialController *)tutorialController didClickOnRightButton:(UIButton *)sender {
    
    [self.tutorialViewController stopScrolling];
    
    SelectViewController *selectViewController = [[SelectViewController alloc] init];
    [self.tutorialNavVC pushViewController:selectViewController animated:YES];
}

- (void)showLangOptions {
    FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Please select your language" message:@"You can change it later in settings" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:@"English", @"中文", nil];
    alertView.alertViewStyle = FUIAlertViewStyleDefault;
    alertView.tag = 100;
    
    alertView.delegate = self;
    alertView.titleLabel.textColor = [UIColor cloudsColor];
    alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    alertView.messageLabel.textColor = [UIColor cloudsColor];
    alertView.messageLabel.font = [UIFont flatFontOfSize:14];
    alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
    alertView.alertContainer.backgroundColor = [UIColor greenSeaColor];
    alertView.defaultButtonColor = [UIColor cloudsColor];
    alertView.defaultButtonShadowColor = [UIColor asbestosColor];
    alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
    alertView.defaultButtonTitleColor = [UIColor asbestosColor];
    [alertView show];
}

- (void) showLogoutConfirm
{
    FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Logout?" message:@"注销后以便重新登陆" delegate:nil cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    alertView.alertViewStyle = FUIAlertViewStyleDefault;
    alertView.tag = 101;

    alertView.delegate = self;
    alertView.titleLabel.textColor = [UIColor cloudsColor];
    alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    alertView.messageLabel.textColor = [UIColor cloudsColor];
    alertView.messageLabel.font = [UIFont flatFontOfSize:14];
    alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
    alertView.alertContainer.backgroundColor = [UIColor greenSeaColor];
    alertView.defaultButtonColor = [UIColor cloudsColor];
    alertView.defaultButtonShadowColor = [UIColor asbestosColor];
    alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
    alertView.defaultButtonTitleColor = [UIColor asbestosColor];
    [alertView show];
}

- (void)alertView:(FUIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            [[UserModel sharedLoginUser] setLangEn:YES];
        }
        
        if (buttonIndex == 2) {
            [[UserModel sharedLoginUser] setLangEn:NO];
        }
    }
    
    if (alertView.tag == 101) {
        if (buttonIndex == 1) {
            [DEFAULTS setObject:nil forKey:kUserLoginInfo];
            [self showTutorialView];
        }
    }
}
@end
