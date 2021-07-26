//
//  HardwareUsageViewController.m
//  BLESDKDemo
//
//  Created by Deabel on 2021/7/16.
//

#import "HardwareUsageViewController.h"

@interface HardwareUsageViewController ()

@property (weak, nonatomic) IBOutlet UILabel *vibrationDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *reminderVibrationDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *reminderVibrationCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *screenOnLabel;
@property (weak, nonatomic) IBOutlet UILabel *wakeTimesLabel;
@property (weak, nonatomic) IBOutlet UILabel *wakeDurationLabel;

@property (weak, nonatomic) IBOutlet UILabel *measureDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *measureTimesCount;

@property (weak, nonatomic) IBOutlet UILabel *bcDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *connectionDurationLabel;

@end

@implementation HardwareUsageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"硬件使用情况";
}

#pragma mark - Motor Usage
- (IBAction)getMotorUsage:(id)sender {
    WeakObj(self);
    [CFBLEManager.shared.currentDevice.communicatinHandler getMotorUsageDataWithCompletion:^(enum CFCommandState state, CFMotorUsageModel * _Nullable model) {
        if (state == CFCommandStateReceivedSucceed) {
            selfWeak.vibrationDurationLabel.text = [NSString stringWithFormat:@"%@ms", @(model.vibratedDuration)];
            selfWeak.reminderVibrationDurationLabel.text = [NSString stringWithFormat:@"%@ms", @(model.vibratedDurationForReminder)];
            selfWeak.reminderVibrationCountLabel.text = [NSString stringWithFormat:@"%@", @(model.vibratedTimesForReminder)];
        }
    }];
}

#pragma mark - Screen Usage

- (IBAction)getScreenUsage:(id)sender {
    WeakObj(self);
    [CFBLEManager.shared.currentDevice.communicatinHandler getScreenUsageDataWithCompletion:^(enum CFCommandState state, CFScreenUsageModel * _Nullable model) {
        if (state == CFCommandStateReceivedSucceed) {
            selfWeak.screenOnLabel.text = [NSString stringWithFormat:@"%@ms", @(model.screenOnDuration)];
            selfWeak.wakeTimesLabel.text = [NSString stringWithFormat:@"%@", @(model.wakeTimesOnRaise)];
            selfWeak.wakeDurationLabel.text = [NSString stringWithFormat:@"%@ms", @(model.wakeDurationOnRaise)];
        }
    }];
}

#pragma mark - Heart Rate Usage

- (IBAction)getHeartUsage:(id)sender {
    WeakObj(self);
    [CFBLEManager.shared.currentDevice.communicatinHandler getHeartRateUsageDataWithCompletion:^(enum CFCommandState state, CFHeartRateUsageModel * _Nullable model) {
        if (state == CFCommandStateReceivedSucceed) {
            selfWeak.measureDurationLabel.text = [NSString stringWithFormat:@"%@s", @(model.measureDuration)];
            selfWeak.measureTimesCount.text = [NSString stringWithFormat:@"%@", @(model.measureTimes)];
        }
    }];
}

#pragma mark - Broadcast Usage

- (IBAction)getBleUsage:(id)sender {
    WeakObj(self);
    [CFBLEManager.shared.currentDevice.communicatinHandler getBluetoothUsageDataWithCompletion:^(enum CFCommandState state, CFBluetoothUsageModel * _Nullable model) {
        if (state == CFCommandStateReceivedSucceed) {
            selfWeak.bcDurationLabel.text = [NSString stringWithFormat:@"%@s", @(model.broadcastDuration)];
            selfWeak.connectionDurationLabel.text = [NSString stringWithFormat:@"%@s", @(model.connectionDuration)];
        }
    }];
}

@end
