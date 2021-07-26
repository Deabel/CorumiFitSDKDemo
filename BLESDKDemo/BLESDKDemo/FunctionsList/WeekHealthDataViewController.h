//
//  WeekHealthDataViewController.h
//  BLESDKDemo
//
//  Created by Deabel on 2021/7/16.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeekHealthDataViewController : BaseTableViewController

@end

@interface CFWeekDataCellModel : NSObject

@property (nonatomic, assign) CFWeekHealthDataType dataType;
@property (nonatomic, strong) NSArray *dataModels;
@property (nonatomic, copy, readonly) NSString *title;
@end

NS_ASSUME_NONNULL_END
