//
//  FunctionListModel.h
//  BLESDKDemo
//
//  Created by Deabel on 2021/7/16.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FunctionListType) {
    reminder,
    alarmClock,
    systemInfo,
    systemSetting,
    hardwareUsage,
    weekHealthData,
    dataSync
};

NS_ASSUME_NONNULL_BEGIN

@interface FunctionListModel : NSObject

@property (nonatomic, assign) FunctionListType funcType;

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *clsName;
@end

NS_ASSUME_NONNULL_END
