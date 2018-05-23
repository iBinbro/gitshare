//
//  BiniFlyManager.h
//  语音识别 智能客服 Demo
//
//  Created by apple on 2018/5/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define iflyControl NO//是否显示讯飞提供的波形图


typedef NS_ENUM(NSUInteger, BinLanguageType){
    BinCantonese = 0,//Cantonese粤语
    BinMandarin,//Mandarin普通话
    BinEnglish,//English英语
    BinSzechuan//Szechuan四川话
};

typedef NS_ENUM(NSUInteger, BinError){
    BinNoError = 0,//无错
};

typedef NS_ENUM(NSUInteger, BinRecordState){
    BinRecordBegin = 0,//开始录音
    BinRecordEnd,//结束录音
    BinRecordCancel//取消识别
};

@interface BiniFlyManager : NSObject

///< 识别结果回调.
@property (nonatomic, copy) void(^callBackResult)(BinError errorCode, NSString *errorDes, NSString *result);

///< 非自带UI回调录音和识别状态.
@property (nonatomic, copy) void(^callRecordState)(BinRecordState state);

///< 非自带UI回调录音的音量变化 范围从0-30
@property (nonatomic, copy) void(^callVolumeValue)(int volume);


///< 讯飞波形视图的中心位置 x=0&&y==0默认取中心点位置.
@property (nonatomic, assign) CGPoint iflyControlCenter;

+ (instancetype)sharedInstance;

#pragma mark - 设置语言类别 通过类方法对IATConfig单例操作实现，该方法紧接着要调用reSetupRecognizer才能生效
+ (void)setupLanguage:(BinLanguageType)languageVoice;

/**
 * @brief 再度初始化识别参数,.
 *
 * 再度初始化识别参数.
 */
- (void)reSetupRecognizer;

/**
 * @brief 开始识别.
 *
 * 开始识别方法.
 */
- (void)startWorkAction;

/**
 * @brief 结束识别.
 *
 * 结束识别方法.
 */
- (void)stopWorkAction;

@end
