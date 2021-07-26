//
//  SystemInfoViewController.m
//  BLESDKDemo
//
//  Created by Deabel on 2021/7/14.
//

#import "SystemInfoViewController.h"

@interface SystemInfoViewController ()

@property (nonatomic, strong) CFCommunicationHandler *communicationHandler;

@property (weak, nonatomic) IBOutlet UILabel*mcuDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *udidLabel;
@property (weak, nonatomic) IBOutlet UILabel *otaProjectNmaeLabel;
@property (weak, nonatomic) IBOutlet UILabel *otaBranchNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fwVersionLabel;
@property (weak, nonatomic) IBOutlet UILabel *compilingDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *compilingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *compilingBatchNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *systemTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *broadcastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *macAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *bindStateLabel;
@end

@implementation SystemInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"系统信息";
}

- (CFCommunicationHandler *)communicationHandler {
    return CFBLEManager.shared.currentDevice.communicatinHandler;
}

- (IBAction)syncMcuDate:(id)sender {
    CFMcuDateInfoModel *model = [[CFMcuDateInfoModel alloc] initWithDate:NSDate.date];
    [self.communicationHandler setMcuDateWithModel:model completion:^(enum CFCommandState state) {
        if (state == CFCommandStateReceivedSucceed) {
            [SVProgressHUD showSuccessWithStatus:@"设置成功"];
        } else {
            [SVProgressHUD showSuccessWithStatus:@"设置失败"];
        }
        [SVProgressHUD dismissWithDelay:1.5];
    }];
}

- (IBAction)getMcuDate:(id)sender {
    WeakObj(self);
    [self.communicationHandler getMcuDateWithCompletion:^(enum CFCommandState state, CFMcuDateInfoModel * _Nullable model) {
        selfWeak.mcuDateLabel.text = model.date.description;
    }];
}

- (IBAction)getCategoryId:(id)sender {
    WeakObj(self);
    [self.communicationHandler getSystemInfoWithInfoType:CFSystemInfoTypeCategory completion:^(enum CFCommandState state, CFSystemInfomationModel * _Nullable model) {
        selfWeak.categoryIdLabel.text = model.category;
    }];
}

- (IBAction)getUdid:(id)sender {
    WeakObj(self);
    [self.communicationHandler getSystemInfoWithInfoType:CFSystemInfoTypeUdid completion:^(enum CFCommandState state, CFSystemInfomationModel * _Nullable model) {
        selfWeak.udidLabel.text = model.udid;
    }];
}

- (IBAction)getOtaProjectName:(id)sender {
    WeakObj(self);
    [self.communicationHandler getSystemInfoWithInfoType:CFSystemInfoTypeOtaProjectName completion:^(enum CFCommandState state, CFSystemInfomationModel * _Nullable model) {
        selfWeak.otaProjectNmaeLabel.text = model.otaName;
    }];
}
- (IBAction)getOtaBranchName:(id)sender {
    WeakObj(self);
    [self.communicationHandler getSystemInfoWithInfoType:CFSystemInfoTypeOtaBranchName completion:^(enum CFCommandState state, CFSystemInfomationModel * _Nullable model) {
        selfWeak.otaBranchNameLabel.text = model.otaName;
    }];
}
- (IBAction)getFwVersion:(id)sender {
    WeakObj(self);
    [self.communicationHandler getSystemInfoWithInfoType:CFSystemInfoTypeFwVersion completion:^(enum CFCommandState state, CFSystemInfomationModel * _Nullable model) {
        selfWeak.fwVersionLabel.text = model.fwVersion;
    }];
}
- (IBAction)getCompilingDate:(id)sender {
    WeakObj(self);
    [self.communicationHandler getSystemInfoWithInfoType:CFSystemInfoTypeCompiledDate completion:^(enum CFCommandState state, CFSystemInfomationModel * _Nullable model) {
        selfWeak.compilingDateLabel.text = model.compiledDate;
    }];
}
- (IBAction)getCompilingTime:(id)sender {
    WeakObj(self);
    [self.communicationHandler getSystemInfoWithInfoType:CFSystemInfoTypeCompiledTime completion:^(enum CFCommandState state, CFSystemInfomationModel * _Nullable model) {
        selfWeak.compilingTimeLabel.text = model.compiledTime;
    }];
}
- (IBAction)getCompilingBatchNumber:(id)sender {
    WeakObj(self);
    [self.communicationHandler getSystemInfoWithInfoType:CFSystemInfoTypeCompiledBatchNum completion:^(enum CFCommandState state, CFSystemInfomationModel * _Nullable model) {
        selfWeak.compilingBatchNumLabel.text = model.compiledBatchNum;
    }];
}
- (IBAction)getSystemType:(id)sender {
    WeakObj(self);
    [self.communicationHandler getSystemInfoWithInfoType:CFSystemInfoTypeSystemType completion:^(enum CFCommandState state, CFSystemInfomationModel * _Nullable model) {
        selfWeak.systemTypeLabel.text = [NSString stringWithFormat:@"%@", @(model.systemType)];
    }];
}
- (IBAction)getBroadcastName:(id)sender {
    WeakObj(self);
    [self.communicationHandler getSystemInfoWithInfoType:CFSystemInfoTypeBroadcastName completion:^(enum CFCommandState state, CFSystemInfomationModel * _Nullable model) {
        selfWeak.broadcastNameLabel.text = model.broadcastName;
    }];
}
- (IBAction)getMacAddress:(id)sender {
    WeakObj(self);
    [self.communicationHandler getSystemInfoWithInfoType:CFSystemInfoTypeMacAddress completion:^(enum CFCommandState state, CFSystemInfomationModel * _Nullable model) {
        selfWeak.macAddressLabel.text = model.macAddress;
    }];
}
- (IBAction)getBindingState:(id)sender {
    WeakObj(self);
    [self.communicationHandler getSystemInfoWithInfoType:CFSystemInfoTypeBindingState completion:^(enum CFCommandState state, CFSystemInfomationModel * _Nullable model) {
        selfWeak.bindStateLabel.text = model.isBinded ? @"已绑定" : @"未绑定";
    }];
}






@end
