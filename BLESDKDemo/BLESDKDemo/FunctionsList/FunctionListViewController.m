//
//  FunctionListViewController.m
//  BLESDKDemo
//
//  Created by Deabel on 2021/7/14.
//

#import "FunctionListViewController.h"
#import "FunctionListModel.h"

@interface FunctionListViewController ()    <CFDeviceDelegate>

@end

@implementation FunctionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"功能列表";
    
    [self loadData];
    
    [CFBLEManager.shared addDeviceDelegate:self];
}

- (void)loadData {
    NSArray *funcTypes = @[@(reminder),
                           @(alarmClock),
                           @(systemInfo),
                           @(systemSetting),
                           @(hardwareUsage),
                           @(weekHealthData),
                           @(dataSync)];
    for (NSNumber *num in funcTypes) {
        FunctionListModel *listModel = [[FunctionListModel alloc] init];
        listModel.funcType = num.integerValue;
        [self.dataSrouce addObject:listModel];
    }
    
    [self.tableView reloadData];
}

#pragma mark - CFDeviceDelegate

- (void)connectionStateDidChangeWithDeviceModel:(CFDeviceModel *)deviceModel newState:(enum CFConnectionState)newState {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (newState == CFConnectionStateDisconnected) {
            [SVProgressHUD showErrorWithStatus:@"断开连接"];
            [SVProgressHUD dismissWithDelay:2 completion:^{
                        [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    });
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSrouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    FunctionListModel *model = self.dataSrouce[indexPath.row];
    cell.textLabel.text = model.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    FunctionListModel *model = self.dataSrouce[indexPath.row];
    UIViewController *vc = [[NSClassFromString(model.clsName) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
