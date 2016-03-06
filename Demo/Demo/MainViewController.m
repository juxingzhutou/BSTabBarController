//
//  MainViewController.m
//  Demo
//
//  Created by juxingzhutou on 16/3/2.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import "MainViewController.h"
#import "Masonry.h"
#import "ControllerManager.h"

#define REUSE_ID_FOR_CELL @"REUSE_ID_FOR_CELL"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"BSTabBarController Demo";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:REUSE_ID_FOR_CELL];
    
    tableView.delegate = self;
    tableView.dataSource = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSE_ID_FOR_CELL];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Normal";
            break;
        case 1:
            cell.textLabel.text = @"Custom Tab Bar";
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *target = nil;
    switch (indexPath.row) {
        case 0:
            target = [[ControllerManager defaultManager] createNormalTypeViewController];
            break;
        case 1:
            target = [[ControllerManager defaultManager] createCustomTabBarViewController];
            break;
            
        default:
            break;
    }
    
    [self presentViewController:target animated:YES completion:nil];
}

@end
