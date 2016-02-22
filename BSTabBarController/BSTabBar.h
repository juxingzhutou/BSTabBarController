//
//  BSTabBar.h
//  Demo
//
//  Created by juxingzhutou on 16/2/19.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTabItemView.h"

@class BSTabBar;

@protocol BSTabBarDelegate <NSObject>

- (BOOL)tabBar:(BSTabBar *)tabBar shouldSelectItem:(UITabBarItem *)item atIndex:(NSUInteger)index;
- (void)tabBar:(BSTabBar *)tabBar didSelectItem:(UITabBarItem *)item atIndex:(NSUInteger)index;

@end

@interface BSTabBar : UIView

@property (nonatomic, assign) NSUInteger                selectedIndex;
@property (nonatomic, weak) id<BSTabBarDelegate>        delegate;
@property (nonatomic, strong) NSArray<BSTabItemView *>  *itemViews;

- (void)setTabBarItems:(NSArray<UITabBarItem *> *)tabBarItems;

@end