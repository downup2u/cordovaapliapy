//
//  AlipayPlugin.m
//  Wangxiaoqing
//
//  Created by wangxiaoqing on 11/09/15.
//
//

#import "AlipayPlugin.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation AlipayPlugin

@synthesize appScheme;
@synthesize currentCallbackId;


-(void)handleOpenURL:(NSNotification *)notification{
    NSURL* url = [notification object];
    //跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    if (url!=nil && [url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService]
         processOrderWithPaymentResult:url
         standbyCallback:^(NSDictionary *resultDic) {
             NSLog(@"result = %@", resultDic);
             CDVPluginResult* result = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString:[NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]]];
             [self.commandDelegate sendPluginResult:result callbackId:self.currentCallbackId];
             self.currentCallbackId = nil;
         }];
    }
}

- (void) initAppScheme:(CDVInvokedUrlCommand*) command {
    CDVPluginResult* pluginResult = nil;

    NSString* scheme = [command.arguments objectAtIndex:0];
    if (scheme != nil) {
        self.appScheme = scheme;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Arg was null"];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


- (void) callAlipaySDK:(CDVInvokedUrlCommand*) command {
    self.currentCallbackId = command.callbackId;
    NSString* orderStr = [command.arguments objectAtIndex:0];
    if (orderStr != nil) {
        [[AlipaySDK defaultService] payOrder:orderStr fromScheme:self.appScheme callback:^(NSDictionary *resultDic) {
          NSLog(@"AlipayResult = %@",resultDic);
          CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString:[NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]]];
          [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
           self.currentCallbackId = nil;
        }];

    }
}


@end
