//
//  CustomTabBar.h
//  Demo
//
//  Created by juxingzhutou on 16/2/21.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import "BSTabBar.h"
#import "CustomTabItemView.h"

@interface CustomTabBar : BSTabBar

@property (nonatomic, strong) NSArray<CustomTabItemView *>    *itemViews;

@end
