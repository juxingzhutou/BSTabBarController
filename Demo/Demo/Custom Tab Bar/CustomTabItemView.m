//
//  CustomTabItemView.m
//  Demo
//
//  Created by juxingzhutou on 16/2/21.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import "CustomTabItemView.h"

@implementation CustomTabItemView

- (instancetype)init {
    self = [super init];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        self.imageView = imageView;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.height.equalTo(@(30));
        }];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.highlighted = NO;
    }
    
    return self;
}

- (void)setupWithTabBarItem:(UITabBarItem *)tabBarItem {
    self.imageView.image = [tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.imageView.highlightedImage = [tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

#pragma mark - Accessors

- (void)setHighlighted:(BOOL)highlighted {
    _highlighted = highlighted;
    
    self.imageView.highlighted = highlighted;
    
    if (highlighted) {
        self.imageView.tintColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor blackColor];
    } else {
        self.imageView.tintColor = [UIColor lightGrayColor];
        self.backgroundColor = [UIColor darkGrayColor];
    }
}

@end
