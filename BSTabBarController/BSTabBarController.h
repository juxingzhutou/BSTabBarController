//
//  BSTabBarController.h
//  Demo
//
//  Created by juxingzhutou on 16/2/19.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTabBar.h"

@class BSTabBarController;

@protocol BSTabBarControllerDelegate <NSObject>

- (BOOL)tabBarController:(BSTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;

@end

@interface BSTabBarController : UIViewController

@property (nonatomic, assign) CGFloat                               tabBarHeight;
@property (nonatomic, readonly, strong) BSTabBar                    *tabBar;
@property (nonatomic, weak) id<BSTabBarControllerDelegate>          delegate;
@property (nonatomic, copy) NSArray <__kindof UIViewController *>   *viewControllers;

@property(nonatomic, strong) __kindof UIViewController              *selectedViewController;
@property(nonatomic, assign) NSUInteger                             selectedIndex;

- (instancetype)initWithCustomTabBar:(BSTabBar *)tabBar;

@end

@interface UIViewController (BSTabBarControllerExtension)

@property (nonatomic, weak) BSTabBarController *bsTabBarController;

@end