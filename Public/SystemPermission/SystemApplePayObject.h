//
//  SystemApplePayObject.h
//  SystemPermission
//
//  Created by wujian on 2018/6/15.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemPermissionObject.h"

@interface SystemApplePayObject : SystemPermissionObject

/** 获取当前Apple Pay权限对app的授权**/
- (void)getSystemApplePayStatus:(void (^)(SystemApplePayStatus payStatus))statusBlock;

@end
