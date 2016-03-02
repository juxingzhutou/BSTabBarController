//
//  ControllerManager.m
//  Demo
//
//  Created by juxingzhutou on 16/2/19.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import "ControllerManager.h"
#import "BSTabBarController.h"
#import "FirstTabController.h"
#import "SecondTabViewController.h"
#import "ThirdTabViewController.h"
#import "FourthTabViewController.h"
#import "MainViewController.h"
#import "CustomTabBar.h"

@implementation ControllerManager

+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    static ControllerManager *singleton = nil;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    
    return singleton;
}

- (UIViewController *)loadRootViewController {
    MainViewController *mainViewController = [[MainViewController alloc] init];
    
    return [[UINavigationController alloc] initWithRootViewController:mainViewController];
}

- (UIViewController *)createNormalTypeViewController {
    BSTabBarController *tabBarController = [[BSTabBarController alloc] init];
    tabBarController.tabBar.translucent = NO;
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    FirstTabController *firstTabController = [[FirstTabController alloc] init];
    firstTabController.tabBarItem.image = [UIImage imageNamed:@"icon_tab0"];
    firstTabController.title = @"First Tab";
    [viewControllers addObject:firstTabController];
    
    SecondTabViewController *secondTabController = [[SecondTabViewController alloc] init];
    secondTabController.tabBarItem.image = [UIImage imageNamed:@"icon_tab1"];
    secondTabController.title = @"Second Tab";
    [viewControllers addObject:secondTabController];
    
    ThirdTabViewController *thirdTabController = [[ThirdTabViewController alloc] init];
    thirdTabController.tabBarItem.image = [UIImage imageNamed:@"icon_tab2"];
    thirdTabController.title = @"Third Tab";
    [viewControllers addObject:thirdTabController];
    
    FourthTabViewController *fourthTabController = [[FourthTabViewController alloc] init];
    fourthTabController.tabBarItem.image = [UIImage imageNamed:@"icon_tab3"];
    fourthTabController.title = @"Fourth Tab";
    [viewControllers addObject:fourthTabController];
    
    tabBarController.viewControllers = viewControllers;
    
    return tabBarController;
}

- (UIViewController *)createCustomTabBarViewController {
    BSTabBarController *tabBarController = [[BSTabBarController alloc] initWithCustomTabBar:[[CustomTabBar alloc] init]];
    tabBarController.tabBarHeight = 40;
    tabBarController.tabBar.translucent = NO;
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    FirstTabController *firstTabController = [[FirstTabController alloc] init];
    firstTabController.tabBarItem.image = [UIImage imageNamed:@"icon_tab0"];
    firstTabController.title = @"First Tab";
    [viewControllers addObject:firstTabController];
    
    SecondTabViewController *secondTabController = [[SecondTabViewController alloc] init];
    secondTabController.tabBarItem.image = [UIImage imageNamed:@"icon_tab1"];
    secondTabController.title = @"Second Tab";
    [viewControllers addObject:secondTabController];
    
    ThirdTabViewController *thirdTabController = [[ThirdTabViewController alloc] init];
    thirdTabController.tabBarItem.image = [UIImage imageNamed:@"icon_tab2"];
    thirdTabController.title = @"Third Tab";
    [viewControllers addObject:thirdTabController];
    
    FourthTabViewController *fourthTabController = [[FourthTabViewController alloc] init];
    fourthTabController.tabBarItem.image = [UIImage imageNamed:@"icon_tab3"];
    fourthTabController.title = @"Fourth Tab";
    [viewControllers addObject:fourthTabController];
    
    tabBarController.viewControllers = viewControllers;
    
    return tabBarController;
}

@end
