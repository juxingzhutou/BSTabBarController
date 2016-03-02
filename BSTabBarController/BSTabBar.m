//
//  BSTabBar.m
//  Demo
//
//  Created by juxingzhutou on 16/2/19.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import "BSTabBar.h"
#import "BSTabItemView.h"

@interface BSTabBar ()

@property (nonatomic, weak, readonly) UIView *contentView;
@property (nonatomic, weak) NSArray<UITabBarItem *>     *tabBarItems;

@end

@implementation BSTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _translucent = YES;
        [self initializer];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _translucent = YES;
        [self initializer];
    }
    
    return self;
}

- (void)initializer {
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _contentView = contentView;
    
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@0.5);
    }];
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
    [self.itemViews[_selectedIndex] setHighlighted:NO];
    [self.itemViews[selectedIndex] setHighlighted:YES];
    
    _selectedIndex = selectedIndex;
}

#pragma - mark Accessors

- (void)setTabBarItems:(NSArray<UITabBarItem *> *)tabBarItems {
    for (UIView *oldItemView in self.itemViews) {
        [oldItemView removeFromSuperview];
    }
    
    _tabBarItems = tabBarItems;
    
    NSMutableArray<BSTabItemView *> *itemViews = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < tabBarItems.count; ++i) {
        BSTabItemView *itemView = [[BSTabItemView alloc] init];
        [self.contentView addSubview:itemView];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.equalTo(self.contentView.mas_left);
            } else {
                make.left.equalTo(itemViews.lastObject.mas_right);
                make.width.equalTo(itemViews.lastObject);
            }
            
            make.top.bottom.equalTo(self.contentView);
            
            if (i == tabBarItems.count - 1) {
                make.right.equalTo(self.contentView.mas_right);
            }
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