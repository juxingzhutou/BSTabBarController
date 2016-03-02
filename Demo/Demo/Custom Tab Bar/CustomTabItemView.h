//
//  CustomTabItemView.h
//  Demo
//
//  Created by juxingzhutou on 16/2/21.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import "BSTabItemView.h"

@interface CustomTabItemView : UIView

@property (nonatomic, assign) BOOL              highlighted;
@property (nonatomic, weak) UIImageView         *imageView;

- (void)setupWithTabBarItem:(UITabBarItem *)tabBarItem;

@end
