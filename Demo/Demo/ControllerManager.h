//
//  ControllerManager.h
//  Demo
//
//  Created by juxingzhutou on 16/2/19.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControllerManager : NSObject

+ (instancetype)defaultManager;

- (UIViewController *)loadRootViewController;

@end
