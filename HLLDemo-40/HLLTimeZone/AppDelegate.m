//
//  AppDelegate.m
//  HLLTimeZone
//
//  Created by admin on 16/2/25.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

#import "HLLSortProtocol.h"
#import "HLLNormalDataSource.h"
#import "HLLSortRegionsDataSource.h"
#import "HLLSortA_ZDataSource.h"
#import "HLLSortLocalizedIndexedCollationDataSource.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    id<HLLSortProtocol, UITableViewDataSource> dataSource;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:3];
    
    
    //
    UINavigationController *navController = [storyboard instantiateViewControllerWithIdentifier:@"navForTableView"];
    ViewController *viewController =
    (ViewController *)[navController topViewController];
    dataSource = [[HLLNormalDataSource alloc] init];
    viewController.dataSource = dataSource;
    [viewControllers addObject:navController];
    
    //
    navController = [storyboard instantiateViewControllerWithIdentifier:@"navForTableView"];
    viewController = (ViewController *)[navController topViewController];
    dataSource = [[HLLSortRegionsDataSource alloc] init];
    viewController.dataSource = dataSource;
    [viewControllers addObject:navController];
    
    //
    navController = [storyboard instantiateViewControllerWithIdentifier:@"navForTableView"];
    viewController = (ViewController *)[navController topViewController];
    dataSource = [[HLLSortA_ZDataSource alloc] init];
    viewController.dataSource = dataSource;
    [viewControllers addObject:navController];
    
    //
    navController = [storyboard instantiateViewControllerWithIdentifier:@"navForTableView"];
    viewController = (ViewController *)[navController topViewController];
    dataSource = [[HLLSortLocalizedIndexedCollationDataSource alloc] init];
    viewController.dataSource = dataSource;
    [viewControllers addObject:navController];
    
    tabBarController.viewControllers = viewControllers;
    return YES;
}
@end
