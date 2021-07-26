//
//  BaseTableViewController.h
//  BLESDKDemo
//
//  Created by Deabel on 2021/7/14.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController : BaseViewController
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSrouce;
@end

NS_ASSUME_NONNULL_END
