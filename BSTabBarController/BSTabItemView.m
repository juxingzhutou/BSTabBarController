//
//  BSTabItemView.m
//  Demo
//
//  Created by juxingzhutou on 16/2/19.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import "BSTabItemView.h"

#define NORMAL_STATE_TINT_COLOR [UIColor grayColor]
#define HIGHTLIGHTED_STATE_TINT_COLOR (ColorWithHexValue(0x007aff))

@implementation BSTabItemView

- (instancetype)init {
    self = [super init];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        self.imageView = imageView;
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(4);
            make.height.width.equalTo(@30);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        self.titleLabel = titleLabel;
        titleLabel.font = [UIFont systemFontOfSize:10.0];
        titleLabel.textColor = NORMAL_STATE_TINT_COLOR;
        titleLabel.highlightedTextColor = HIGHTLIGHTED_STATE_TINT_COLOR;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).offset(2);
            make.centerX.equalTo(self);
        }];
        
        BSCustomBadgeView *badgeView = [[BSCustomBadgeView alloc] init];
        self.badgeView = badgeView;
        [self addSubview:badgeView];
        [badgeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(-7);
            make.centerY.equalTo(imageView.mas_top).offset(4);
        }];
        
        self.highlighted = NO;
    }
    
    return self;
}

- (void)setupWithTabBarItem:(UITabBarItem *)tabBarItem {
    self.imageView.image = [tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.imageView.highlightedImage = [tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.titleLabel.text = tabBarItem.title;
}

#pragma mark - Accessors

- (void)setHighlighted:(BOOL)highlighted {
    _highlighted = highlighted;
    
    self.imageView.highlighted = highlighted;
    self.titleLabel.highlighted = highlighted;
    
    if (highlighted) {
        self.imageView.tintColor = HIGHTLIGHTED_STATE_TINT_COLOR;
    } else {
        self.imageView.tintColor = NORMAL_STATE_TINT_COLOR;
    }
}

@end