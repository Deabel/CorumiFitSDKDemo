//
//  DataSyncViewController.m
//  BLESDKDemo
//
//  Created by Deabel on 2021/7/16.
//

#import "DataSyncViewController.h"

@interface DataSyncViewController ()

@property (weak, nonatomic) IBOutlet UITextField *stepTargetTF;
@end

@implementation DataSyncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"同步数据相关";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)syncData:(NSArray <NSNumber *> *)dataTypes {
    [CFBLEManager.shared.currentDevice.dataSyncHandler syncDataWith:dataTypes beginning:^{
        [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"开始请求数据 %@", dataTypes]];
    } progress:^(CGFloat progress) {
        [SVProgressHUD showProgress:progress status:@"正在请求数据"];
    } result:^(NSDictionary<NSString *,id> * _Nullable json, NSError * _Nullable error) {
        if (json != nil) {
            [SVProgressHUD showSuccessWithStatus:@"请求完成"];
            NSLog(@"请求结果%@", json);
        } else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请求失败, %@", @(error.code)]];
        }
    }];
}

- (IBAction)setStepTarget:(id)sender {
    CFStepTargetModel *model = [[CFStepTargetModel alloc] init];
    model.stepTarget = self.stepTargetTF.text.integerValue;
    [SVProgressHUD showWithStatus:@"正在设置"];
    [CFBLEManager.shared.currentDevice.communicatinHandler setStepTargetWithModel:model completion:^(enum CFCommandState state) {
        [SVProgressHUD showSuccessWithStatus:@"完成"];
    }];
}
- (IBAction)getStepTarget:(id)sender {
    WeakObj(self);
    [CFBLEManager.shared.currentDevice.communicatinHandler getStepTargetWithCompletion:^(enum CFCommandState state, CFStepTargetModel * _Nullable model) {
        selfWeak.stepTargetTF.text = [NSString stringWithFormat:@"%@", @(model.stepTarget)];
    }];
}

- (IBAction)SyncSteps:(id)sender {
    [self syncData:@[@(CFSyncDataTypeStep)]];
}
- (IBAction)syncHeartRate:(id)sender {
    [self syncData:@[@(CFSyncDataTypeHr)]];
}
- (IBAction)syncSleeps:(id)sender {
    [self syncData:@[@(CFSyncDataTypeSleep)]];
}
- (IBAction)syncAll:(id)sender {
    [self syncData:@[@(CFSyncDataTypeStep),
                     @(CFSyncDataTypeHr),
                     @(CFSyncDataTypeSleep)]];
}

@end
