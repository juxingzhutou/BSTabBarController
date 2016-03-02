//
//  CustomTabBar.m
//  Demo
//
//  Created by juxingzhutou on 16/2/21.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import "CustomTabBar.h"

@interface CustomTabBar ()

@property (nonatomic, weak, readonly) UIView *contentView;
@property (nonatomic, weak) NSArray<UITabBarItem *>     *tabBarItems;

@property (nonatomic, weak) UIButton *centerButton;

@end

@implementation CustomTabBar

@dynamic itemViews;
@synthesize selectedIndex = _selectedIndex;

- (void)initializer {
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _contentView = contentView;
    
    UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.centerButton = centerButton;
    [self.contentView addSubview:centerButton];
    [centerButton setImage:[UIImage imageNamed:@"icon_center"] forState:UIControlStateNormal];
    [centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.bottom.equalTo(self);
    }];
    [centerButton.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(centerButton);
        make.width.height.equalTo(@30);
    }];
    centerButton.backgroundColor = [UIColor orangeColor];
    centerButton.tintColor = [UIColor whiteColor];
}

#pragma - mark Actions

- (void)tapedOnItemView:(UITapGestureRecognizer *)tapGR {
    NSUInteger index = tapGR.view.tag;
    
    if ([self.delegate respondsToSelector:@selector(tabBar:shouldSelectItem:atIndex:)]
        && ![self.delegate tabBar:self shouldSelectItem:self.tabBarItems[index] atIndex:index]) {
        return;
    }
    
    self.selectedIndex = index;
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItem:atIndex:)]) {
        [self.delegate tabBar:self didSelectItem:self.tabBarItems[index] atIndex:index];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    self.itemViews[_selectedIndex].highlighted = NO;
    self.itemViews[selectedIndex].highlighted = YES;
    
    _selectedIndex = selectedIndex;
}

#pragma - mark Accessors

- (void)setTabBarItems:(NSArray<UITabBarItem *> *)tabBarItems {
    for (UIView *oldItemView in self.itemViews) {
        [oldItemView removeFromSuperview];
    }
    
    _tabBarItems = tabBarItems;
    
    NSMutableArray<CustomTabItemView *> *itemViews = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < tabBarItems.count; ++i) {
        CustomTabItemView *itemView = [[CustomTabItemView alloc] init];
        [self.contentView addSubview:itemView];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            switch (i) {
                case 0:
                    make.left.equalTo(self.contentView);
                    break;
                case 1:
                    make.left.equalTo(itemViews.lastObject.mas_right);
                    make.right.equalTo(self.centerButton.mas_left);
                    break;
                case 2:
                    make.left.equalTo(self.centerButton.mas_right);
                    break;
                case 3:
                    make.left.equalTo(itemViews.lastObject.mas_right);
                    make.right.equalTo(self.contentView.mas_right);
                    break;
                default:
                    break;
            }
            
            make.width.equalTo(self.centerButton);
            make.top.bottom.equalTo(self.contentView);
        }];
        
        itemView.tag = i;
        itemView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] init];
        [tapGR addTarget:self action:@selector(tapedOnItemView:)];
        [itemView addGestureRecognizer:tapGR];
        
        [itemViews addObject:itemView];
        [itemView setupWithTabBarItem:tabBarItems[i]];
    }
    
    _selectedIndex = 0;
    self.itemViews = itemViews;
}

@end
