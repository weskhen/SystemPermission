//
//  SystemNetworkObject.m
//  SystemPermission
//
//  Created by wujian on 2018/6/19.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemNetworkObject.h"
#import <CoreTelephony/CTCellularData.h>
#import <SystemConfiguration/CaptiveNetwork.h>

typedef NS_ENUM(NSUInteger,NetworkStatus) {
    /** 网络权限未知 **/
    NetworkStatusUnknow = 0,
    /** 网络权限受限 **/
    NetworkStatusRestricrted,
    /** 网络可用 **/
    NetworkStatusVisable,
};

API_AVAILABLE(ios(9.0))
@interface SystemNetworkObject ()

@property (nonatomic, strong) CTCellularData *cellularData;

@property (nonatomic, assign) NetworkStatus networkStatus;//网络状态
@end
@implementation SystemNetworkObject

- (NSDictionary *)fetchSSIDInfo {
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    if (!ifs) {
        return nil;
    }

    NSDictionary *info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) { break; }
    }
    return info;
}



- (void)getSystemCellularDataAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock
{
    if (@available(iOS 9.0, *)) {
        CTCellularData *cellularData = [[CTCellularData alloc]init];
        CTCellularDataRestrictedState state = cellularData.restrictedState;
        switch (state) {
            case kCTCellularDataRestricted:
                WHLog(@"Restricrted");
                authStatusBlock(SystemAuthStatusRestricted);
                break;
            case kCTCellularDataNotRestricted:
                WHLog(@"Not Restricted");
                authStatusBlock(SystemAuthStatusAuthorized);
                break;
            case kCTCellularDataRestrictedStateUnknown:
                WHLog(@"Unknown");
                authStatusBlock(SystemAuthStatusRestricted);
                break;
            default:
                break;
        }
    } else {
        // Fallback on earlier versions
        authStatusBlock(SystemAuthStatusAuthorized);
    }
}
- (void)requestInfo {
    //调用接口 触发网络权限
    {
        NSURLSession *session = [NSURLSession sharedSession];
        //通过地址得到一个url
        NSString *urlStr = @"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx?date=20151101&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213";
        NSURL *url = [NSURL URLWithString:urlStr];
        //通过单例的session得到一个sessionTask，且通过URL初始化task 在block内部可以直接对返回的数据进行处理
        NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            //请求之后会调用这个block
            NSString *resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            WHLog(@"resultStr->%@",resultStr);
        }];
        //启动人物,让task开始之前执行
        [task resume];
    }
}

- (void)startcellularDataMonitoring
{
    WEAKSELF
    //初始化或权限改变会收到通知
    if (@available(iOS 9.0, *)) {
        self.cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
            // 获取应用联网授权状态
            STRONGSELF
            switch (state) {
                case kCTCellularDataRestricted:
                    strongSelf.networkStatus = NetworkStatusRestricrted;
                    WHLog(@"Restricrted"); // 权限受限(关闭、WLAN 两种情况) 网络可能可用 wifi下的WLAN可正常使用
                    [strongSelf checkCurrentNetSetting];
                    break;
                case kCTCellularDataNotRestricted:
                    strongSelf.networkStatus = NetworkStatusVisable;
                    WHLog(@"Not Restricted"); // 权限不受限
                    break;
                case kCTCellularDataRestrictedStateUnknown:
                    WHLog(@"Unknown"); // 未知，第一次请求
                    strongSelf.networkStatus = NetworkStatusUnknow;
                    break;
                default:
                    break;
            }
        };
    } else {
        // Fallback on earlier versions
    }
}
/** networkStatus改变 和ReachabilityStatus改变触发该函数  **/
- (void)checkCurrentNetSetting
{
    //外加网络ReachabilityStatusNotReachable
    if (self.networkStatus == NetworkStatusRestricrted && [self fetchSSIDInfo] && true/* ReachabilityStatusNotReachable */) {
        //用户关闭了应用访问 无线互联网 的权限 提示前往设置页修改网络权限
    }
}

#pragma mark - setter/getter
- (CTCellularData *)cellularData
API_AVAILABLE(ios(9.0)){
    if (!_cellularData) {
        _cellularData = [[CTCellularData alloc] init];
        _cellularData.cellularDataRestrictionDidUpdateNotifier = nil;
    }
    return _cellularData;
}
@end
