//
//  SystemSettingViewController.m
//  BLESDKDemo
//
//  Created by Deabel on 2021/7/14.
//

#import "SystemSettingViewController.h"

@interface SystemSettingViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UISwitch *raiseOnWakeSwitch;
@end

@implementation SystemSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"系统设置";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)setScreenText:(id)sender {
    CFScreenTextModel *textModel = [[CFScreenTextModel alloc] initWithText:self.textField.text];
    [CFBLEManager.shared.currentDevice.communicatinHandler showTextOnScreenWithModel:textModel completion:^(enum CFCommandState state) {
        if (state == CFCommandStateReceivedSucceed) {
            [SVProgressHUD showSuccessWithStatus:@"设置成功"];
        }
    }];
}

- (IBAction)setRaiseToWake:(id)sender {
    CFSystemSettingsModel *settingsModel = [[CFSystemSettingsModel alloc] init];
    settingsModel.raiseToWake = self.raiseOnWakeSwitch.isOn;
    [CFBLEManager.shared.currentDevice.communicatinHandler setSystemSettingsWithModel:settingsModel completion:^(enum CFCommandState state) {
        if (state == CFCommandStateReceivedSucceed) {
            [SVProgressHUD showSuccessWithStatus:@"设置成功"];
        }
    }];
}

- (IBAction)getRaiseOnWake:(id)sender {
    WeakObj(self);
    [CFBLEManager.shared.currentDevice.communicatinHandler getSystemSettingsWithCompletion:^(enum CFCommandState state, CFSystemSettingsModel * _Nullable model) {
        selfWeak.raiseOnWakeSwitch.on = model.raiseToWake;
    }];
}

- (IBAction)factoryTest1:(id)sender {
    [CFBLEManager.shared.currentDevice.communicatinHandler systemOperationWithOperationType:CFDeviceOperationTypeFactoryTest1 completion:^(enum CFCommandState state) {
        if (state == CFCommandStateReceivedSucceed) {
            [SVProgressHUD showSuccessWithStatus:@"设置成功"];
        }
    }];
}
- (IBAction)facotryText2:(id)sender {
    [CFBLEManager.shared.currentDevice.communicatinHandler systemOperationWithOperationType:CFDeviceOperationTypeFactoryTest2 completion:^(enum CFCommandState state) {
        if (state == CFCommandStateReceivedSucceed) {
            [SVProgressHUD showSuccessWithStatus:@"设置成功"];
        }
    }];
}
- (IBAction)reboot:(id)sender {
    [CFBLEManager.shared.currentDevice.communicatinHandler systemOperationWithOperationType:CFDeviceOperationTypeReboot completion:^(enum CFCommandState state) {
        if (state == CFCommandStateReceivedSucceed) {
            [SVProgressHUD showSuccessWithStatus:@"设置成功"];
        }
    }];
}
- (IBAction)shutDown:(id)sender {
    [CFBLEManager.shared.currentDevice.communicatinHandler systemOperationWithOperationType:CFDeviceOperationTypeShutdown completion:^(enum CFCommandState state) {
        if (state == CFCommandStateReceivedSucceed) {
            [SVProgressHUD showSuccessWithStatus:@"设置成功"];
        }
    }];
}

@end
