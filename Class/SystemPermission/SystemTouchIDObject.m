//
//  SystemTouchIDObject.m
//  SystemPermission
//
//  Created by wujian on 2018/6/15.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemTouchIDObject.h"
#import <LocalAuthentication/LocalAuthentication.h>


@implementation SystemTouchIDObject

- (void)getSystemTouchIDAuth:(void (^)(SystemTouchIDStatus touchIDStatus))touchIDStatusBlock
{
    LAContext *laContext = [[LAContext alloc] init];
    NSError *error;
    if ([laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        touchIDStatusBlock(SystemTouchIDStatusVisable);
    } else {
        WHLog(@"设备不支持Touch ID功能,原因:%@",error);
        touchIDStatusBlock(SystemTouchIDStatusDisable);
    }
}

@end
