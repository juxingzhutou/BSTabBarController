//
//  FourthTabViewController.m
//  Demo
//
//  Created by juxingzhutou on 16/3/2.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import "FourthTabViewController.h"
#import "PushViewController.h"

@interface FourthTabViewController ()

@end

@implementation FourthTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)pushAViewController:(id)sender {
    UIViewController *vc = [[PushViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
