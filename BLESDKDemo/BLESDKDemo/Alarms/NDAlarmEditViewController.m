//
//  AlarmListViewController.m
//  BLESDKDemo
//
//  Created by Deabel on 2021/7/15.
//

#import "NDAlarmEditViewController.h"
#import "CGXPickerView.h"

@interface NDAlarmEditViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *alarmSwitch;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (nonatomic, assign) BOOL isEditing;
@end

@implementation NDAlarmEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
}

- (void)setupUI {
    if (!self.isEditing) {
        _am = [[CFAlarmClockModel alloc] init];
        _am.index = 1;  // 默认覆盖第一个闹钟
    } else {
        [self refreshUI];
    }
    
    self.navigationItem.title = self.isEditing ? @"闹钟编辑" : @"添加闹钟";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(onClickRightBarButtonItem)];
}

- (void)refreshUI {
    _alarmSwitch.on = _am.activated;
    _timeTextField.text = [NSString stringWithFormat:@"%02ld:%02ld", _am.hour, _am.minute];
    for (NSNumber *num in _am.repeatDaysWithNumbers) {
        UIButton *subView = [self.view viewWithTag:num.integerValue];
        if (![subView isKindOfClass:[UIButton class]]) { continue; }
        subView.selected = YES;
    }
}

- (IBAction)alarmSwitchAction:(id)sender {
    _am.activated = self.alarmSwitch.isOn;
}

- (void)onClickRightBarButtonItem {
    [CFBLEManager.shared.currentDevice.communicatinHandler setAlarmClockWithModel:self.am
                                                                       completion:^(enum CFCommandState state) {
        if (state == CFCommandStateReceivedSucceed) {
            [SVProgressHUD showSuccessWithStatus:@"成功"];
        } else {
            [SVProgressHUD showErrorWithStatus:@"失败"];
        }
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [CGXPickerView showDatePickerWithTitle:@"选择时间" DateType:UIDatePickerModeTime DefaultSelValue:nil MinDateStr:nil MaxDateStr:nil IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
        NSArray *arr = [selectValue componentsSeparatedByString:@":"];
        self.am.hour = [arr.firstObject integerValue];
        self.am.minute = [arr.lastObject integerValue];
        [self refreshUI];
    }];
    return NO;
}

- (IBAction)repeatDate:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    NSMutableArray *repeatDays = _am.repeatDaysWithNumbers.mutableCopy;
    switch (sender.tag) {
        case 0: { sender.selected ?
            [repeatDays addObject:@(CFAlarmRepeatDayMon)] :
            [repeatDays removeObject:@(CFAlarmRepeatDayMon)]; } break;
        case 1: { sender.selected ?
            [repeatDays addObject:@(CFAlarmRepeatDayTue)] :
            [repeatDays removeObject:@(CFAlarmRepeatDayTue)]; } break;
        case 2: { sender.selected ?
            [repeatDays addObject:@(CFAlarmRepeatDayWed)] :
            [repeatDays removeObject:@(CFAlarmRepeatDayWed)]; } break;
        case 3: { sender.selected ?
            [repeatDays addObject:@(CFAlarmRepeatDayThu)] :
            [repeatDays removeObject:@(CFAlarmRepeatDayThu)]; } break;
        case 4: { sender.selected ?
            [repeatDays addObject:@(CFAlarmRepeatDayFri)] :
            [repeatDays removeObject:@(CFAlarmRepeatDayFri)]; } break;
        case 5: { sender.selected ?
            [repeatDays addObject:@(CFAlarmRepeatDaySat)] :
            [repeatDays removeObject:@(CFAlarmRepeatDaySat)]; } break;
        case 6: { sender.selected ?
            [repeatDays addObject:@(CFAlarmRepeatDaySun)] :
            [repeatDays removeObject:@(CFAlarmRepeatDaySun)]; } break;
        default: break;
    }
    
    self.am.repeatDaysWithNumbers = repeatDays;
}

- (BOOL)isEditing {
    return _am ? YES : NO;
}
@end
