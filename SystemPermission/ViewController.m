//
//  ViewController.m
//  SystemPermission
//
//  Created by wujian on 2018/6/13.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "ViewController.h"
#import "SystemPermissionServer.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataList = @[@"相机权限",@"相册权限",@"录音权限",@"定位权限",@"通讯录权限",@"通知权限",@"注册系统通知",@"蓝牙权限",@"日历权限",@"Sir权限",@"语音识别权限",@"Apple Pay",@"Touch ID",@"媒体资料库",@"健康权限",@"网络权限"];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - privateMethod
- (void)handleCellDidSelected:(NSInteger)row
{
    switch (row) {
        case 0:
            [SystemPermission judgeSystemCameraPermissionsSuccess:^{
                WHLog(@"judgeSystemCameraPermissionsSuccess judgeSystem");
            } withFailedHandel:^(SystemPermissionType permissionType) {
                if (permissionType == SystemPermissionTypeFailedSetting) {
                    [SystemPermission jumpSystemAppSetting];
                }
                else
                {
                    WHLog(@"get faild judgeSystem");
                }
            }];
            break;
        case 1:
            [SystemPermission judgeSystemAlbumPermissionsSuccess:^{
                WHLog(@"judgeSystemAlbumPermissionsSuccess judgeSystem");
            } withFailedHandel:^(SystemPermissionType permissionType) {
                if (permissionType == SystemPermissionTypeFailedSetting) {
                    [SystemPermission jumpSystemAppSetting];
                }
                else
                {
                    WHLog(@"get faild judgeSystem");
                }

            }];
            break;
        case 2:
            [SystemPermission judgeSystemRecordPermissionsSuccess:^{
                WHLog(@"judgeSystemRecordPermissionsSuccess judgeSystem");
            } withFailedHandel:^(SystemPermissionType permissionType) {
                if (permissionType == SystemPermissionTypeFailedSetting) {
                    [SystemPermission jumpSystemAppSetting];
                }
                else
                {
                    WHLog(@"get faild judgeSystem");
                }

            }];
            break;
        case 3:
            [SystemPermission judgeSystemLocationPermissionsSuccess:^{
                WHLog(@"judgeSystemLocationPermissionsSuccess judgeSystem");
            } withFailedHandel:^(SystemPermissionType permissionType) {
                if (permissionType == SystemPermissionTypeFailedSetting) {
                    [SystemPermission jumpSystemAppSetting];
                }
                else
                {
                    WHLog(@"get faild judgeSystem");
                }

            }];
            break;
        case 4:
            [SystemPermission judgeSystemAddressBookPermissionsSuccess:^{
                WHLog(@"judgeSystemAddressBookPermissionsSuccess judgeSystem");
            } withFailedHandel:^(SystemPermissionType permissionType) {
                if (permissionType == SystemPermissionTypeFailedSetting) {
                    [SystemPermission jumpSystemAppSetting];
                }
                else
                {
                    WHLog(@"get faild judgeSystem");
                }
            }];
            break;
        case 5:
            [SystemPermission judgeSystemNotificationPermissionsSuccess:^{
                WHLog(@"judgeSystemNotificationPermissionsSuccess judgeSystem");
            } withFailedHandel:^(SystemPermissionType permissionType) {
                if (permissionType == SystemPermissionTypeFailedSetting) {
                    [SystemPermission jumpSystemAppSetting];
                }
                else
                {
                    WHLog(@"get faild judgeSystem");
                }
            }];
            break;
        case 6:
            [SystemPermission registerNotificationSettings];
            break;
        case 7:
            [SystemPermission judgeSystemBluetoothPeripheralPermissionsSuccess:^{
                WHLog(@"judgeSystemBluetoothPermissionsSuccess judgeSystem");
            } withFailedHandel:^(SystemPermissionType permissionType) {
                if (permissionType == SystemPermissionTypeFailedSetting) {
                    [SystemPermission jumpSystemAppSetting];
                }
                else
                {
                    WHLog(@"get faild judgeSystem");
                }
            } notDetermined:^{
                WHLog(@"未触发过蓝牙共享权限获取");
            }];
            break;
        case 8:
            [SystemPermission judgeSystemCalendarPermissionsSuccess:^{
                WHLog(@"judgeSystemCalendarPermissionsSuccess judgeSystem");
            } withFailedHandel:^(SystemPermissionType permissionType) {
                if (permissionType == SystemPermissionTypeFailedSetting) {
                    [SystemPermission jumpSystemAppSetting];
                }
                else
                {
                    WHLog(@"get faild judgeSystem");
                }
            }];
            break;
        case 9:
            [SystemPermission judgeSystemSirPermissionsSuccess:^{
                WHLog(@"judgeSystemSirPermissionsSuccess judgeSystem");
            } withFailedHandel:^(SystemPermissionType permissionType) {
                if (permissionType == SystemPermissionTypeFailedSetting) {
                    [SystemPermission jumpSystemAppSetting];
                }
                else
                {
                    WHLog(@"get faild judgeSystem");
                }
            }];
            break;
        case 10:
            [SystemPermission judgeSystemSpeechPermissionsSuccess:^{
                WHLog(@"judgeSystemSpeechPermissionsSuccess judgeSystem");
            } withFailedHandel:^(SystemPermissionType permissionType) {
                if (permissionType == SystemPermissionTypeFailedSetting) {
                    [SystemPermission jumpSystemAppSetting];
                }
                else
                {
                    WHLog(@"get faild judgeSystem");
                }
            }];
            break;
        case 11:
            [SystemPermission currentSystemApplePayStatus:^(SystemApplePayStatus status) {
                
            }];
            break;
        case 12:
        {
            [SystemPermission currentSystemTouchIDStatus:^(SystemTouchIDStatus touchIDStatus) {
                WHLog(@"%ld",touchIDStatus);
            }];
        }
            break;
        case 13:
        {
            [SystemPermission judgeSystemMediaPlayerPermissionsSuccess:^{
                WHLog(@"judgeSystemMediaPlayerPermissionsSuccess judgeSystem");
            } withFailedHandel:^(SystemPermissionType permissionType) {
                if (permissionType == SystemPermissionTypeFailedSetting) {
                    [SystemPermission jumpSystemAppSetting];
                }
                else
                {
                    WHLog(@"get faild judgeSystem");
                }
            }];
        }
            break;
        case 14:
        {
            [SystemPermission currentSystemHealthAuthStatus:^(SystemAuthStatus authStatus) {
                WHLog(@"%ld",authStatus);

            } quantityTypeIdentifier:HKQuantityTypeIdentifierStepCount];
        }
            break;
        case 15:
        {
            [SystemPermission currentSystemNetworkAuthStatus:^(SystemAuthStatus authStatus) {
                WHLog(@"%ld",authStatus);
                
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self handleCellDidSelected:indexPath.row];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = [NSString stringWithFormat:@"cell_%ld",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text = [self.dataList objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

#pragma mark - setter/getter
- (UITableView *)tableView
{
    if (!_tableView) {
        CGRect rect = [UIScreen mainScreen].bounds;
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
