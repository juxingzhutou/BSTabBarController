//
//  BSCustomBadgeView.m
//  Demo
//
//  Created by juxingzhutou on 16/2/19.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import "BSCustomBadgeView.h"

#define RED_COLOR_FOR_BADGE_VIEW (ColorWithHexValue(0xfe514d))

@interface BSCustomBadgeView ()

@property (weak, nonatomic) UIImageView *centerRedPoint;
@property (weak, nonatomic) UILabel *badgeValueLabel;

@end

@implementation BSCustomBadgeView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupSubviews];
}

- (void)setupSubviews {
    self.clipsToBounds = NO;
    self.backgroundColor = [UIColor clearColor];
    
    UILabel *badgeValueLabel = [[UILabel alloc] init];
    [self addSubview:badgeValueLabel];
    self.badgeValueLabel = badgeValueLabel;
    [badgeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 2, 0, 2));
        make.width.greaterThanOrEqualTo(badgeValueLabel.mas_height).offset(-4);
    }];
    [badgeValueLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [badgeValueLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [badgeValueLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [badgeValueLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    badgeValueLabel.textAlignment = NSTextAlignmentCenter;
    badgeValueLabel.font = [UIFont systemFontOfSize:13.0];
    badgeValueLabel.textColor = [UIColor whiteColor];
    badgeValueLabel.hidden = YES;
    
    UIImageView *redPoint = [[UIImageView alloc] init];
    [self addSubview:redPoint];
    self.centerRedPoint = redPoint;
    [redPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@8);
        make.height.equalTo(@8);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left);
    }];
    redPoint.layer.cornerRadius = 4;
    redPoint.backgroundColor = RED_COLOR_FOR_BADGE_VIEW;
    
    self.hideCenterRightPoint = YES;
    self.badgeValue = 0;
}

#pragma mark - Accessors

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.bounds.size.height / 2;
}

- (void)setHideCenterRightPoint:(BOOL)hideCenterRightPoint {
    _hideCenterRightPoint = hideCenterRightPoint;
    self.centerRedPoint.hidden = hideCenterRightPoint;
}

- (void)setBadgeValue:(NSString *)badgeValue {
    _badgeValue = badgeValue;
    
    if (badgeValue.length == 0) {
        self.backgroundColor = [UIColor clearColor];
        self.badgeValueLabel.hidden = YES;
        self.centerRedPoint.hidden = NO || self.hideCenterRightPoint;
    } else {
        self.badgeValueLabel.text = badgeValue;
        self.backgroundColor = RED_COLOR_FOR_BADGE_VIEW;
        self.badgeValueLabel.hidden = NO;
        self.centerRedPoint.hidden = YES;
    }
}

@end
