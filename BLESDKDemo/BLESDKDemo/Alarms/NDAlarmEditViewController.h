//
//  AlarmListViewController.m
//  BLESDKDemo
//
//  Created by Deabel on 2021/7/15.
//


#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NDAlarmEditViewController : BaseViewController

@property (nonatomic, strong) CFAlarmClockModel *am;
@property (nonatomic, assign) NSInteger indexToAdd;
@property (nonatomic, copy) void(^didEditAlarm)(void);
@end

NS_ASSUME_NONNULL_END
