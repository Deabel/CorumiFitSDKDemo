//
//  DeviceListViewController.m
//  BLESDKDemo
//
//  Created by Deabel on 2021/7/14.
//

#import "DeviceListViewController.h"

@interface DeviceListViewController ()  <CFDeviceDelegate>

@end

@implementation DeviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"扫描设备";
    [CFBLEManager.shared addDeviceDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [CFBLEManager.shared.connectionHandler scanDeviceWith:CFDeviceTypeWatch];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [CFBLEManager.shared.connectionHandler stopScan];
}

#pragma mark - CFDeviceDelegate

- (void)didDiscoverDeviceWithDeviceModels:(NSArray<CFDeviceModel *> *)deviceModels {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.tableView.isDragging) {
            self.dataSrouce = deviceModels.mutableCopy;
            [self.tableView reloadData];
        }
    });
}

- (void)connectionStateDidChangeWithDeviceModel:(CFDeviceModel *)deviceModel
                                       newState:(enum CFConnectionState)newState {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (newState == CFConnectionStateReadyForUse) {
            [SVProgressHUD showSuccessWithStatus:@"连接成功"];
            [SVProgressHUD dismissWithDelay:1.5 completion:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        } else if (newState == CFConnectionStateFailed) {
            [SVProgressHUD showErrorWithStatus:@"连接失败"];
            [SVProgressHUD dismissWithDelay:1.5];
        }
    });
}

#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSrouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    
    CFDeviceModel *deviceModel = [self.dataSrouce objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", deviceModel.name, deviceModel.macAddress];
    cell.detailTextLabel.text = deviceModel.rssiValue;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    [CFBLEManager.shared.connectionHandler stopScan];
    [SVProgressHUD showWithStatus:@"连接中..."];
    
    CFDeviceModel *deviceModel = [self.dataSrouce objectAtIndex:indexPath.row];
    [CFBLEManager.shared.connectionHandler connectWithDeviceModel:deviceModel];
}

@end
