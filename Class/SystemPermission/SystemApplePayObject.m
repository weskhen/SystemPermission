//
//  SystemApplePayObject.m
//  SystemPermission
//
//  Created by wujian on 2018/6/15.
//  Copyright © 2018年 wujian. All rights reserved.
//

#import "SystemApplePayObject.h"
#import <PassKit/PassKit.h>

@implementation SystemApplePayObject

- (void)getSystemApplePayStatus:(void (^)(SystemApplePayStatus payStatus))statusBlock
{
    //检查当前设备是否可以支付
    if (![PKPaymentAuthorizationViewController class] || ![PKPaymentAuthorizationViewController canMakePayments]) {
        //PKPaymentAuthorizationViewController需iOS8.0以上支持 操作系统不支持ApplePay，请升级至9.0以上版本，且iPhone6以上设备才支持
        statusBlock(SystemApplePayStatusNotSupport);
    }
    else{
        //检查用户是否可进行某种卡的支付，是否支持Amex、MasterCard、Visa与银联四种卡，根据自己项目的需要进行检测
        if (@available(iOS 9.2, *)) {
            NSArray *supportedNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkMasterCard,PKPaymentNetworkVisa,PKPaymentNetworkChinaUnionPay];
            if (![PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:supportedNetworks]) {
                statusBlock(SystemApplePayStatusNoCard);
            }
            else{
                statusBlock(SystemApplePayStatusCanPay);
            }
        } else {
            // Fallback on earlier versions
            if (@available(iOS 9.0, *)) {
                NSArray *supportedNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkMasterCard,PKPaymentNetworkVisa];
                if (![PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:supportedNetworks]) {
                    statusBlock(SystemApplePayStatusNoCard);
                }
                else{
                    statusBlock(SystemApplePayStatusCanPay);
                }
            }
            else{
                statusBlock(SystemApplePayStatusNotSupport);
            }
        }
    }

}

@end
