//
//  SystemHealthObject.h
//  SystemPermission
//
//  Created by wujian on 2018/6/19.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemPermissionObject.h"
#import <HealthKit/HKTypeIdentifiers.h>
/**
 发者账号的Bundle identifier需要能够使用healthKit.
 App services中 需要对HealthKit 选中
 对应的target->capabilties 需要设置开启HealthKit
 **/
@interface SystemHealthObject : SystemPermissionObject

/** 设备是否支持健康权限 **/
- (BOOL)isSupportHealthData;

/** 获取当前健康权限对app的授权**/
- (void)getSystemHealthAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock quantityTypeIdentifier:(HKQuantityTypeIdentifier)identifier;

@end
