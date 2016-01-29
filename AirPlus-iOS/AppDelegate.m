//
//  AppDelegate.m
//  AirPlus-iOS
//
//  Created by 蔡 敏 on 16/1/15.
//  Copyright © 2016年 Appbees.net. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"

#import "Constants.h"

@interface AppDelegate ()

@property (strong, nonatomic) MainViewController *mainViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupAppance];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.mainViewController = [[MainViewController alloc] init];
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:self.mainViewController];
    self.window.rootViewController = navVC;
    [self.window makeKeyAndVisible];
    
    [[AFHttpTool pmDataSyncMananger] start];
    return YES;
}

- (void) setupAppance{
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor],
                                                          NSForegroundColorAttributeName,
                                                          [UIFont flatFontOfSize:17.0],
                                                          NSFontAttributeName,
                                                          nil]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    NSDictionary *attrs = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [[UIBarItem appearance] setTitleTextAttributes:attrs
                                          forState:UIControlStateNormal];
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor peterRiverColor]
                                  highlightedColor:[UIColor belizeHoleColor]
                                      cornerRadius:3
                                   whenContainedIn:[UINavigationBar class], nil];
    
    [[UINavigationBar appearance] configureFlatNavigationBarWithColor:[UIColor peterRiverColor]];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [UINavigationBar appearance].titleTextAttributes = @{NSFontAttributeName:[UIFont boldFlatFontOfSize:18],
                                                                        NSForegroundColorAttributeName: [UIColor whiteColor]};
    } else {
        // Pre-iOS7 methods
        [UINavigationBar appearance].titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
                                                                        UITextAttributeTextColor: [UIColor whiteColor]};
    }
    
    [[UINavigationBar appearance] configureFlatNavigationBarWithColor:[UIColor peterRiverColor]];

    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
