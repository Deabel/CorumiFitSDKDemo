//
//  ReminderViewController.m
//  BLESDKDemo
//
//  Created by Deabel on 2021/7/14.
//

#import "ReminderViewController.h"

@interface ReminderViewController ()

@property (weak, nonatomic) IBOutlet UITextField *reminderIntervalTF;
@property (weak, nonatomic) IBOutlet UILabel *reminderIntervalLabel;

@property (nonatomic, strong) CFReminderIntervalModel *intervalModel;
@property (nonatomic, strong) CFReminderModel *reminderModel;
@property (weak, nonatomic) IBOutlet UISwitch *callSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *othersSwitch;
@end

@implementation ReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"提醒";
    self.intervalModel = [[CFReminderIntervalModel alloc] initWithInterval:0];
    self.reminderModel = [[CFReminderModel alloc] initWithCall:false others:false];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)reminderIntervalEditingChanged:(UITextField *)sender {
    self.intervalModel.interval = sender.text.integerValue;
}

- (IBAction)setReminderInterval:(id)sender {
    [SVProgressHUD showWithStatus:@"请稍后"];
    [CFBLEManager.shared.currentDevice.communicatinHandler setReminderIntervalWithModel:self.intervalModel
                                                                             completion:^(enum CFCommandState state) {
        if (state != CFCommandStateReceivedSucceed) {
            [SVProgressHUD showErrorWithStatus:@"失败"];
            [SVProgressHUD dismissWithDelay:1.5];
        }
    }];
}

- (IBAction)getReminderInterval:(id)sender {
    [SVProgressHUD showWithStatus:@"请稍后"];
    WeakObj(self);
    [CFBLEManager.shared.currentDevice.communicatinHandler getReminderIntervalWithCompletion:^(enum CFCommandState state, CFReminderIntervalModel * _Nullable model) {
        if (state != CFCommandStateReceivedSucceed) {
            [SVProgressHUD showErrorWithStatus:@"失败"];
            [SVProgressHUD dismissWithDelay:1.5];
        }
        selfWeak.intervalModel = model;
        selfWeak.reminderIntervalTF.text = [NSString stringWithFormat:@"%@", @(model.interval)];
    }];
}

- (IBAction)setReminder:(id)sender {
    [SVProgressHUD showWithStatus:@"请稍后"];
    [CFBLEManager.shared.currentDevice.communicatinHandler setReminderWithModel:self.reminderModel completion:^(enum CFCommandState state) {
        if (state != CFCommandStateReceivedSucceed) {
            [SVProgressHUD showErrorWithStatus:@"失败"];
            [SVProgressHUD dismissWithDelay:1.5];
        }
    }];
}

- (IBAction)getReminder:(id)sender {
    [SVProgressHUD showWithStatus:@"请稍后"];
    WeakObj(self);
    [CFBLEManager.shared.currentDevice.communicatinHandler getReminderWithCompletion:^(enum CFCommandState state, CFReminderModel * _Nullable model) {
        if (state != CFCommandStateReceivedSucceed) {
            [SVProgressHUD showErrorWithStatus:@"失败"];
            [SVProgressHUD dismissWithDelay:1.5];
        }
        selfWeak.reminderModel = model;
        selfWeak.callSwitch.on = model.call;
        selfWeak.othersSwitch.on = model.others;
    }];
}

- (IBAction)callSwitch:(UISwitch *)sender {
    self.reminderModel.call = sender.isOn;
}

- (IBAction)othersSwitch:(UISwitch *)sender {
    self.reminderModel.others = sender.isOn;
}

@end
