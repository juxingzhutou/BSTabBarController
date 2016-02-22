//
//  BSTabItemView.h
//  Demo
//
//  Created by juxingzhutou on 16/2/19.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSCustomBadgeView.h"

@interface BSTabItemView : UIView

@property (nonatomic, assign) BOOL              highlighted;

@property (nonatomic, weak) UIImageView         *imageView;
@property (nonatomic, weak) UILabel             *titleLabel;
@property (nonatomic, weak) BSCustomBadgeView   *badgeView;

- (void)setupWithTabBarItem:(UITabBarItem *)tabBarItem;

@end