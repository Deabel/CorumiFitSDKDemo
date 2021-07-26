//
//  AlarmListViewController.m
//  BLESDKDemo
//
//  Created by Deabel on 2021/7/15.
//

#import "AlarmListViewController.h"
#import "NDAlarmEditViewController.h"

@interface AlarmListViewController ()

@end

@implementation AlarmListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"闹钟列表";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加闹钟"
//                                                                              style:UIBarButtonItemStylePlain
//                                                                             target:self
//                                                                             action:@selector(onClickRightBarButton)];
    
    [SVProgressHUD showWithStatus:@"请稍后"];
    [self loadAlarmClock:0];
}

- (void)loadAlarmClock:(NSInteger)index {
    WeakObj(self);
    [CFBLEManager.shared.currentDevice.communicatinHandler getAlarmClockWithIndex:index
                                                                       completion:^(enum CFCommandState state, CFAlarmClockModel * _Nullable model) {
        if (model != nil) {
            [selfWeak.dataSrouce addObject:model];
        } else {
            [SVProgressHUD showErrorWithStatus:@"失败"];
            [SVProgressHUD dismissWithDelay:1.5];
            return;
        }
        
        if (model.index == 5 - 1) {
            [SVProgressHUD dismiss];
            [selfWeak.tableView reloadData];
        } else {
            [selfWeak loadAlarmClock:index + 1];
        }
    }];
}

- (void)onClickRightBarButton {
    NDAlarmEditViewController *vc = [[NDAlarmEditViewController alloc] init];
    vc.indexToAdd = self.dataSrouce.count;
    [self.navigationController pushViewController:vc animated:true];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSrouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    CFAlarmClockModel *alarmModel = self.dataSrouce[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", alarmModel.index];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld:%ld", alarmModel.hour, alarmModel.minute];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    NDAlarmEditViewController *vc = [[NDAlarmEditViewController alloc] init];
    vc.am = self.dataSrouce[indexPath.row];
    [self.navigationController pushViewController:vc animated:true];
}

@end
