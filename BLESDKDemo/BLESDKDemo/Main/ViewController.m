//
//  ViewController.m
//  BLESDKDemo
//
//  Created by Deabel on 2021/7/13.
//

#import "ViewController.h"
#import "DeviceListViewController.h"
#import "FunctionListViewController.h"
#import "AlarmListViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()    <CFDeviceDelegate>

@property (nonatomic, strong) UIButton *connectionButton;
@property (nonatomic, strong) UIButton *funcListButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.connectionButton];
    [self.connectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    self.funcListButton.hidden = YES;
    [self.view addSubview:self.funcListButton];
    [self.funcListButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.connectionButton);
        make.bottom.equalTo(self.connectionButton.mas_top).offset(-10);
    }];
    
    [CFBLEManager.shared addDeviceDelegate:self];
    
    if ([CBCentralManager supportsFeatures:CBCentralManagerFeatureExtendedScanAndConnect]) {
                NSLog(@"YES");
           } else {
                NSLog(@"NO");
           }
}

- (void)onClickConnectionButton:(UIButton *)sender {
    if (sender.isSelected) {
        // 断开连接
        [CFBLEManager.shared.connectionHandler disconnect];
    } else {
        DeviceListViewController *vc = [[DeviceListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:true];
    }
}

- (void)onClickFuncListButton:(UIButton *)sender {
    FunctionListViewController *vc = [[FunctionListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

#pragma mark - CFDeviceDelegate

- (void)connectionStateDidChangeWithDeviceModel:(CFDeviceModel *)deviceModel
                                       newState:(enum CFConnectionState)newState {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.connectionButton.selected = newState == CFConnectionStateReadyForUse;
        self.funcListButton.hidden = newState != CFConnectionStateReadyForUse;
    });
}

#pragma mark - Lazy loads

- (UIButton *)connectionButton {
    if (_connectionButton == nil) {
        _connectionButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_connectionButton setTitle:@"连接设备" forState:UIControlStateNormal];
        [_connectionButton setTitle:@"断开连接" forState:UIControlStateSelected];
        [_connectionButton setTitleColor:UIColor.redColor forState:UIControlStateSelected];
        [_connectionButton addTarget:self
                               action:@selector(onClickConnectionButton:)
                     forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _connectionButton;
}

- (UIButton *)funcListButton {
    if (_funcListButton == nil) {
        _funcListButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_funcListButton setTitle:@"功能列表" forState:UIControlStateNormal];
        [_funcListButton addTarget:self
                            action:@selector(onClickFuncListButton:)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _funcListButton;
}

@end
