//
//  AppDelegate+IFlyMSC.m
//  语音识别 智能客服 Demo
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AppDelegate+IFlyMSC.h"
#import <iflyMSC/iflyMSC.h>

#define APPID_VALUE @"5b038e6e"//讯飞的appid

@implementation AppDelegate (IFlyMSC)

- (void)registerIFlyMSC{
    //Set log level 日志打印
    [IFlySetting setLogFile:LVL_NONE];

    //Set whether to output log messages in Xcode console
    [IFlySetting showLogcat:YES];

    //Set the local storage path of SDK
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    [IFlySetting setLogFilePath:cachePath];

    //Set APPID
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];

    //Configure and initialize iflytek services.(This interface must been invoked in application:didFinishLaunchingWithOptions:)
    [IFlySpeechUtility createUtility:initString];
}

@end
