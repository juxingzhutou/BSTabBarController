//
//  BSCustomBadgeView.h
//  Demo
//
//  Created by juxingzhutou on 16/2/19.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

#define ColorWithHexValue(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

@interface BSCustomBadgeView : UIView

@property (strong, nonatomic) NSString  *badgeValue;
@property (assign, nonatomic) BOOL      hideCenterRightPoint;

@end
