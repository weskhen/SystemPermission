//
//  SystemNetworkObject.h
//  SystemPermission
//
//  Created by wujian on 2018/6/19.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemPermissionObject.h"

@interface SystemNetworkObject : SystemPermissionObject

/** 权限受限(关闭、WLAN 两种情况) 网络可能可用 wifi下的WLAN可正常使用 **/
- (void)getSystemCellularDataAuth:(void (^)(SystemAuthStatus authStatus))authStatusBlock;

@end
