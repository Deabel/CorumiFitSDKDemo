//
//  WeekHealthDataViewController.m
//  BLESDKDemo
//
//  Created by Deabel on 2021/7/16.
//

#import "WeekHealthDataViewController.h"

@interface WeekHealthDataViewController ()

@end

@implementation WeekHealthDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
}

- (void)loadData {
    [SVProgressHUD showWithStatus:@"加载中"];
    NSArray *dataTypes = @[@(CFWeekHealthDataTypeStep),
                           @(CFWeekHealthDataTypeHeartRate),
                           @(CFWeekHealthDataTypeBloodOxygen),
                           @(CFWeekHealthDataTypeBloodPressure),
                           @(CFWeekHealthDataTypeBodyTemperature)];
    WeakObj(self);
    for (NSNumber *number in dataTypes) {
        [CFBLEManager.shared.currentDevice.communicatinHandler getWeekHealthDataWithDataType:number.integerValue completion:^(enum CFCommandState state, NSArray<CFWeekHealthDataModel *> * _Nullable model) {
            if (state == CFCommandStateReceivedSucceed) {
                CFWeekDataCellModel *dataModel = [[CFWeekDataCellModel alloc] init];
                dataModel.dataType = number.integerValue;
                dataModel.dataModels = model;
                [selfWeak.dataSrouce addObject:dataModel];
            }
            
            if (number.integerValue == [dataTypes.lastObject integerValue]) {
                [SVProgressHUD dismiss];
                [selfWeak.tableView reloadData];
            }
        }];
    }
}

#pragma mark - UITableView Datasouce

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSrouce.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CFWeekDataCellModel *cellModel = self.dataSrouce[section];
    return cellModel.dataModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    CFWeekDataCellModel *cellModel = self.dataSrouce[indexPath.section];
    CFWeekHealthDataModel *model = cellModel.dataModels[indexPath.row];
    
    cell.textLabel.text = NSDate.date.description;
    switch (model.dataType) {
        case CFWeekHealthDataTypeStep: {
            CFWeekStepsModel *stepModel = (CFWeekStepsModel *)model;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", @(stepModel.daySteps)];
        } break;
        case CFWeekHealthDataTypeHeartRate: {
            CFWeekHeartRateModel *hrModel = (CFWeekHeartRateModel *)model;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", @(hrModel.hrValue)];
        } break;
        case CFWeekHealthDataTypeBloodOxygen: {
            CFWeekBloodOxygenModel *oxygenModel = (CFWeekBloodOxygenModel *)model;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", @(oxygenModel.boValue)];
        } break;
        case CFWeekHealthDataTypeBloodPressure: {
            CFWeekBloodPresureModel *pressureModel = (CFWeekBloodPresureModel *)model;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"收缩压:%@mmhg, 舒张压:%@mmhg",
                                         @(pressureModel.sbpValue), @(pressureModel.dbpValue)];
        } break;
        case CFWeekHealthDataTypeBodyTemperature: {
            CFWeekBodyTemperatureModel *temperatureModel = (CFWeekBodyTemperatureModel *)model;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@摄氏度", @(temperatureModel.btValue)];
        } break;
            
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CFWeekDataCellModel *cellModel = self.dataSrouce[section];
    return cellModel.title;
}

@end

@implementation CFWeekDataCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)title {
    switch (_dataType) {
        case CFWeekHealthDataTypeStep: return @"七天步数"; break;
        case CFWeekHealthDataTypeHeartRate: return @"七天心率"; break;
        case CFWeekHealthDataTypeBloodOxygen: return @"七天血氧"; break;
        case CFWeekHealthDataTypeBloodPressure: return @"七天血压"; break;
        case CFWeekHealthDataTypeBodyTemperature: return @"七天体温"; break;
        default:
            break;
    }
    
    return @"";
}

@end
