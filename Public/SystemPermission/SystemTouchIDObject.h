//
//  SystemTouchIDObject.h
//  SystemPermission
//
//  Created by wujian on 2018/6/15.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemPermissionObject.h"

@interface SystemTouchIDObject : SystemPermissionObject

/** 获取当前TouchID权限对app的授权**/
- (void)getSystemTouchIDAuth:(void (^)(SystemTouchIDStatus touchIDStatus))touchIDStatusBlock;


@end
