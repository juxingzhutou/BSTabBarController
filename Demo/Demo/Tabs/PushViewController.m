//
//  PushViewController.m
//  Demo
//
//  Created by juxingzhutou on 16/3/6.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)pushAViewController:(id)sender {
    UIViewController *vc = [[PushViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
