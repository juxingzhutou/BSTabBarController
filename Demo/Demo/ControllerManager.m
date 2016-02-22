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
    BSTabBarController *tabBarController = [[BSTabBarController alloc] init];
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    FirstTabController *firstTabController = [[FirstTabController alloc] init];
    [viewControllers addObject:firstTabController];
    
    SecondTabViewController *secondTabController = [[SecondTabViewController alloc] init];
    [viewControllers addObject:secondTabController];
    
    ThirdTabViewController *thirdTabController = [[ThirdTabViewController alloc] init];
    [viewControllers addObject:thirdTabController];
    
    tabBarController.viewControllers = viewControllers;
    
    return tabBarController;
}

@end
