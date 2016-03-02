//
//  BSTabBarController.m
//  Demo
//
//  Created by juxingzhutou on 16/2/19.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import "BSTabBarController.h"
#import <objc/runtime.h>
#import "Masonry.h"


@interface UINavigationController (BSTabBarControllerExtension)

@property (strong, nonatomic) BSTabBar *catchedTabBar;

@end

@interface UIView (BSTabBarControllerExtension)

@property (nonatomic, weak) BSTabBar *catchedTabBar;

@end



@interface BSTabBarController () <BSTabBarDelegate>
{
    __strong BSTabBar *_tabBar;
}

@property (nonatomic, strong) MASConstraint *contentViewBottomSpace;

@property (nonatomic, strong) NSArray<__kindof UIView*> *viewControllerItemViews;

@end

@implementation BSTabBarController

- (instancetype)init {
    self = [super init];
    if (self) {
        _tabBarHeight = 50;
        _selectedIndex = 0;
    }
    return self;
}

- (instancetype)initWithCustomTabBar:(BSTabBar *)tabBar {
    self = [super init];
    if (self) {
        _tabBarHeight = 50;
        _selectedIndex = 0;
        
        _tabBar = tabBar;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BSTabBar *tabBar = _tabBar?: [[BSTabBar alloc] init];
    tabBar.delegate = self;
    [self setTabBar:tabBar];
    if (self.viewControllers) {
        self.viewControllers = self.viewControllers;
    }
}

#pragma - mark BSTabBarDelegate

- (BOOL)tabBar:(BSTabBar *)tabBar shouldSelectItem:(UITabBarItem *)item atIndex:(NSUInteger)index {
    if (index == self.selectedIndex) {
        return NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]
        && ![self.delegate tabBarController:self shouldSelectViewController:self.viewControllers[index]]) {
        return NO;
    }
    
    return YES;
}

- (void)tabBar:(BSTabBar *)tabBar didSelectItem:(UITabBarItem *)item atIndex:(NSUInteger)index {
    if ([self.delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]
        && ![self.delegate tabBarController:self shouldSelectViewController:self.viewControllers[index]]) {
        return;
    }
    
    [self setSelectedIndex:index];
}

#pragma - mark Accessors

- (void)setTabBar:(BSTabBar *)tabBar {
    [_tabBar removeFromSuperview];
    _tabBar = tabBar;
    
    [self.view addSubview:tabBar];
    
    [tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(self.tabBarHeight));
    }];
    
    if (tabBar) {
        [self.contentViewBottomSpace install];
    } else {
        [self.contentViewBottomSpace uninstall];
    }
}

- (BSTabBar *)tabBar {
    if (_tabBar == nil
        && [self.selectedViewController isKindOfClass:UINavigationController.class]
        && ((UINavigationController *)self.selectedViewController).catchedTabBar != nil) {
        return ((UINavigationController *)self.selectedViewController).catchedTabBar;
    }
    
    return _tabBar;
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    for (UIViewController *vc in _viewControllers) {
        vc.bsTabBarController = nil;
        if (vc.isViewLoaded) {
            [vc.view removeFromSuperview];
        }
        [vc removeFromParentViewController];
    }
    self.contentViewBottomSpace = nil;
    
    _viewControllers = [viewControllers copy];
    
    NSMutableArray *tabBarItems = [NSMutableArray array];
    for (UIViewController *vc in _viewControllers) {
        vc.bsTabBarController = self;
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
        [tabBarItems addObject:vc.tabBarItem];
    }
    self.tabBar.tabBarItems = tabBarItems;
    
    if (self.selectedIndex > _viewControllers.count - 1) {
        self.selectedIndex = MAX(0, _viewControllers.count - 1);
    }
    
    self.selectedIndex = self.selectedIndex;
}

- (void)setSelectedViewController:(__kindof UIViewController *)selectedViewController {
    for (NSUInteger i = 0; i < self.viewControllers.count; ++i) {
        if (self.viewControllers[i] == selectedViewController) {
            [self setSelectedIndex:i];
            break;
        }
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    if (self.selectedViewController != self.viewControllers[selectedIndex]) {
        [self extractTabBarFromSelectedViewController];
    }
    
    self.tabBar.selectedIndex = selectedIndex;
    [self.selectedViewController.view removeFromSuperview];
    
    _selectedViewController = self.viewControllers[selectedIndex];
    _selectedIndex = selectedIndex;
    
    UIViewController *targetVC = _selectedViewController;
    [self.view addSubview:targetVC.view];
    [targetVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).priorityHigh();
        self.contentViewBottomSpace = make.bottom.equalTo(self.view).offset(-_tabBarHeight);
    }];
    
    if (_tabBar == nil) {
        [self.contentViewBottomSpace uninstall];
    }
}

- (void)setTabBarHeight:(CGFloat)tabBarHeight {
    _tabBarHeight = tabBarHeight;
    
    self.contentViewBottomSpace.offset = -self.tabBarHeight;
}

#pragma - mark Actions

- (void)extractTabBarFromSelectedViewController {
    if ([self.selectedViewController isKindOfClass:UINavigationController.class]
        && ((UINavigationController *)self.selectedViewController).catchedTabBar != nil) {
        
        UINavigationController *selectedNC = (UINavigationController *)self.selectedViewController;
        BSTabBar *tabBar = selectedNC.catchedTabBar;
        selectedNC.catchedTabBar = nil;
        [tabBar removeFromSuperview];
        
        [self setTabBar:tabBar];
    }
}

@end

@implementation UIViewController (BSTabBarControllerExtension)

- (void)setBsTabBarController:(BSTabBarController *)bsTabBarController {
    objc_setAssociatedObject(self, @selector(bsTabBarController), bsTabBarController, OBJC_ASSOCIATION_ASSIGN);
}

- (BSTabBarController *)bsTabBarController {
    BSTabBarController *tabBarController = objc_getAssociatedObject(self, _cmd);
    if (tabBarController == nil) {
        tabBarController = self.navigationController.bsTabBarController;
    }
    
    return tabBarController;
}

@end

@implementation UIView (BSTabBarControllerExtension)

- (void)setCatchedTabBar:(BSTabBar *)catchedTabBar {
    objc_setAssociatedObject(self, @selector(catchedTabBar), catchedTabBar, OBJC_ASSOCIATION_ASSIGN);
}

- (BSTabBar *)catchedTabBar {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)mySetFrame:(CGRect)frame {
    if (self.catchedTabBar.superview == self) {
        frame.size.height -= self.catchedTabBar.bounds.size.height;
    }
    
    [self mySetFrame:frame];
}

- (UIView *)myHitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.catchedTabBar) {
        return [self myHitTest:point withEvent:event];
    }
    
    CGPoint pointForTargetView = [self.catchedTabBar convertPoint:point fromView:self];
    
    if (CGRectContainsPoint(self.catchedTabBar.bounds, pointForTargetView)) {
        return [self.catchedTabBar hitTest:pointForTargetView withEvent:event];
    }
    
    return [self myHitTest:point withEvent:event];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod(self, @selector(setFrame:));
        Method swizzledMethod = class_getInstanceMethod(self, @selector(mySetFrame:));
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
        originalMethod = class_getInstanceMethod(self, @selector(hitTest:withEvent:));
        swizzledMethod = class_getInstanceMethod(self, @selector(myHitTest:withEvent:));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

@end


@implementation UINavigationController (BSTabBarControllerExtension)

- (void)BSTabBarControllerExtensionPushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController.hidesBottomBarWhenPushed
        && self.bsTabBarController) {
        BSTabBarController *tabBarController = self.bsTabBarController;
        BSTabBar *tabBar = tabBarController.tabBar;
        if (tabBar && tabBar.superview == tabBarController.view) {
            tabBarController.tabBar = nil;
            [self.topViewController.view addSubview:tabBar];
            [tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.topViewController.view);
                make.top.equalTo(self.topViewController.view.mas_bottom);
            }];
            self.catchedTabBar = tabBar;
            self.topViewController.view.catchedTabBar = tabBar;
        }
    }
    
    [self BSTabBarControllerExtensionPushViewController:viewController animated:animated];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod(self, @selector(pushViewController:animated:));
        Method swizzledMethod = class_getInstanceMethod(self, @selector(BSTabBarControllerExtensionPushViewController:animated:));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

#pragma - mark Accessors

- (void)setCatchedTabBar:(BSTabBar *)catchedTabBar {
    objc_setAssociatedObject(self, @selector(catchedTabBar), catchedTabBar, OBJC_ASSOCIATION_RETAIN);
}

- (BSTabBar *)catchedTabBar {
    return objc_getAssociatedObject(self, _cmd);
}

@end