//
//  FunctionListModel.m
//  BLESDKDemo
//
//  Created by Deabel on 2021/7/16.
//

#import "FunctionListModel.h"

@implementation FunctionListModel

/**
 typedef NS_ENUM(NSUInteger, FunctionListType) {
     reminder,
     alarmClock,
     systemInfo,
     systemSetting,
     hardwareUsage,
     weekHealthData,
     dataSync
 };
 */
- (NSString *)title {
    switch (self.funcType) {
        case reminder: return @"消息提醒"; break;
        case alarmClock: return @"闹钟";  break;
        case systemInfo: return @"系统信息"; break;
        case systemSetting: return @"系统设置";  break;
        case hardwareUsage: return @"硬件使用情况"; break;
        case weekHealthData: return @"周健康数据";  break;
        case dataSync: return @"数据同步"; break;
        default:
            break;
    }
    
    return @"";
}

- (NSString *)clsName {
    switch (self.funcType) {
        case reminder: return @"ReminderViewController"; break;
        case alarmClock: return @"AlarmListViewController";  break;
        case systemInfo: return @"SystemInfoViewController"; break;
        case systemSetting: return @"SystemSettingViewController";  break;
        case hardwareUsage: return @"HardwareUsageViewController"; break;
        case weekHealthData: return @"WeekHealthDataViewController";  break;
        case dataSync: return @"DataSyncViewController"; break;
        default:
            break;
    }
    
    return @"";
}
@end
