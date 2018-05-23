//
//  BiniFlyManager.m
//  语音识别 智能客服 Demo
//
//  Created by apple on 2018/5/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BiniFlyManager.h"

#import <iflyMSC/iflyMSC.h>
#import "IATConfig.h"

@interface BiniFlyManager() <IFlySpeechRecognizerDelegate,IFlyRecognizerViewDelegate>

//不带界面的识别对象
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;//遵循代理回调IFlySpeechRecognizerDelegate

//带界面的识别对象，语音波纹
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//遵循代理回调IFlyRecognizerViewDelegate


///< 识别结果.
@property (nonatomic, copy) NSString *result;

@end

@implementation BiniFlyManager

+ (instancetype)sharedInstance{
    static BiniFlyManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BiniFlyManager alloc] init];
        [BiniFlyManager setupLanguage:BinMandarin];
        [instance reSetupRecognizer];
    });
    return instance;
}

#pragma mark - 设置语言类别language(中文/英文/...)和方言accent
+ (void)setupLanguage:(BinLanguageType)languageVoice{
    IATConfig *instance = [IATConfig sharedInstance];
    if (languageVoice == BinCantonese) { //Cantonese粤语
        instance.language = [IFlySpeechConstant LANGUAGE_CHINESE];//语言类别
        instance.accent = [IFlySpeechConstant ACCENT_CANTONESE];//方言类型
    }else if (languageVoice == BinMandarin) {//Mandarin普通话
        instance.language = [IFlySpeechConstant LANGUAGE_CHINESE];
        instance.accent = [IFlySpeechConstant ACCENT_MANDARIN];
    }else if (languageVoice == BinSzechuan) {//Szechuan四川话
        instance.language = [IFlySpeechConstant LANGUAGE_CHINESE];
        instance.accent = [IFlySpeechConstant ACCENT_SICHUANESE];
    }else if (languageVoice == BinEnglish) {//English英语
        instance.language = [IFlySpeechConstant LANGUAGE_ENGLISH];
        instance.accent = @"";
    }
}

- (void)reSetupRecognizer{
    if (!iflyControl) {//是否显示自带的波形动画
        if (_iFlySpeechRecognizer == nil) {
            _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        }
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        _iFlySpeechRecognizer.delegate = self;
        if (_iFlySpeechRecognizer != nil) {
            IATConfig *instance = [IATConfig sharedInstance];
            //set timeout of recording
            [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
            //set VAD timeout of end of speech(EOS)
            [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
            //set VAD timeout of beginning of speech(BOS)
            [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
            //set network timeout
            [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
            
            //set sample rate, 16K as a recommended option
            [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
            
            //set language
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //set accent
            [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
            
            //set whether or not to show punctuation in recognition results
            [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
            
        }
        
        //        //Initialize recorder
        //        if (_pcmRecorder == nil)
        //        {
        //            _pcmRecorder = [IFlyPcmRecorder sharedInstance];
        //        }
        //
        //        _pcmRecorder.delegate = self;
        //
        //        [_pcmRecorder setSample:[IATConfig sharedInstance].sampleRate];
        //
        //        [_pcmRecorder setSaveAudioPath:nil];    //not save the audio file
    }else{
        //recognition singleton with view
        if (_iflyRecognizerView == nil) {
            if (self.iflyControlCenter.x!=0 || self.iflyControlCenter.y!=0){
                _iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.iflyControlCenter];
            }else{
                CGPoint centerTemp = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*0.5);
                _iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:centerTemp];
            }
        }
        
        [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //set recognition domain
        [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        
        
        _iflyRecognizerView.delegate = self;
        
        if (_iflyRecognizerView != nil) {
            IATConfig *instance = [IATConfig sharedInstance];
            //set timeout of recording
            [_iflyRecognizerView setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
            //set VAD timeout of end of speech(EOS)
            [_iflyRecognizerView setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
            //set VAD timeout of beginning of speech(BOS)
            [_iflyRecognizerView setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
            //set network timeout
            [_iflyRecognizerView setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
            
            //set sample rate, 16K as a recommended option
            [_iflyRecognizerView setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
            
            //set language
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //set accent
            [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
            //set whether or not to show punctuation in recognition results
            [_iflyRecognizerView setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
        }
    }
}

/**
 * @brief 开始识别.
 *
 * 开始识别方法.
 */
- (void)startWorkAction{
    if (!iflyControl) {
        if (_iFlySpeechRecognizer == nil) {
            [self reSetupRecognizer];
        }
        [_iFlySpeechRecognizer cancel];
        //Set microphone as audio source
        [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        
        //Set result type
        [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        //Set the audio name of saved recording file while is generated in the local storage path of SDK,by default in library/cache.
        [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
        [_iFlySpeechRecognizer setDelegate:self];
        
        BOOL runing = [_iFlySpeechRecognizer startListening];//是否启动
        if (!runing){
            NSLog(@"启动失败!");
        }
    }else{
        if (_iflyRecognizerView == nil) {
            [self reSetupRecognizer];
        }
        //Set microphone as audio source
        [_iflyRecognizerView setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        
        //Set result type
        [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        //Set the audio name of saved recording file while is generated in the local storage path of SDK,by default in library/cache.
        [_iflyRecognizerView setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
        BOOL runing = [_iflyRecognizerView start];//是否启动
        if (!runing){
            NSLog(@"启动失败!");
        }
    }
}

/**
 * @brief 结束识别.
 *
 * 结束识别方法.
 */
- (void)stopWorkAction{
    [_iFlySpeechRecognizer stopListening];
}

#pragma mark - 无UI识别代理方法，在代理方法获取音量等信息更新到UI上 IFlySpeechRecognizerDelegate

/*!
 *  识别结果回调
 *
 *  在进行语音识别过程中的任何时刻都有可能回调此函数，你可以根据errorCode进行相应的处理，当errorCode没有错误时，表示此次会话正常结束；否则，表示此次会话有错误发生。特别的当调用`cancel`函数时，引擎不会自动结束，需要等到回调此函数，才表示此次会话结束。在没有回调此函数之前如果重新调用了`startListenging`函数则会报错误。
 *
 *  @param error 错误描述
 */
- (void) xonError:(IFlySpeechError *) error{
    if (error.errorCode == 0) {
        if (self.result.length<=0) {
            NSLog(@"未识别到内容！");
        }else{
            NSLog(@"内容解析为：%@", self.result);
        }
    }else{
        NSLog(@"错误代码：%d错误描述：%@", error.errorCode, error.errorDesc);
    }
    if (self.callBackResult) {
        self.callBackResult(error.errorCode, error.errorDesc, nil);
    }
}

/*!
 *  识别结果回调
 *
 *  在识别过程中可能会多次回调此函数，你最好不要在此回调函数中进行界面的更改等操作，只需要将回调的结果保存起来。<br>
 *  使用results的示例如下：
 *  <pre><code>
 *  - (void) onResults:(NSArray *) results{
 *     NSMutableString *result = [[NSMutableString alloc] init];
 *     NSDictionary *dic = [results objectAtIndex:0];
 *     for (NSString *key in dic){
 *        [result appendFormat:@"%@",key];//合并结果
 *     }
 *   }
 *  </code></pre>
 *
 *  @param results  -[out] 识别结果，NSArray的第一个元素为NSDictionary，NSDictionary的key为识别结果，sc为识别结果的置信度。
 *  @param isLast   -[out] 是否最后一个结果
 */
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    
    NSString *tempString = [BiniFlyManager stringFromJson:resultString];
    
    self.result = tempString;
    NSLog(@"目前一共识别的结果!%@", self.result);
    __weak __typeof(self) weakself = self;
    if (self.callBackResult) {
        self.callBackResult(0, nil, weakself.result);
    }
}

/**
 parse JSON data
 params,for example：
 {"sn":1,"ls":true,"bg":0,"ed":0,"ws":[{"bg":0,"cw":[{"w":"白日","sc":0}]},{"bg":0,"cw":[{"w":"依山","sc":0}]},{"bg":0,"cw":[{"w":"尽","sc":0}]},{"bg":0,"cw":[{"w":"黄河入海流","sc":0}]},{"bg":0,"cw":[{"w":"。","sc":0}]}]}
 **/
+ (NSString *)stringFromJson:(NSString*)params
{
    if (params == NULL) {
        return nil;
    }
    
    NSMutableString *tempStr = [[NSMutableString alloc] init];
    NSDictionary *resultDic  = [NSJSONSerialization JSONObjectWithData:
                                [params dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    
    if (resultDic!= nil) {
        NSArray *wordArray = [resultDic objectForKey:@"ws"];
        
        for (int i = 0; i < [wordArray count]; i++) {
            NSDictionary *wsDic = [wordArray objectAtIndex: i];
            NSArray *cwArray = [wsDic objectForKey:@"cw"];
            
            for (int j = 0; j < [cwArray count]; j++) {
                NSDictionary *wDic = [cwArray objectAtIndex:j];
                NSString *str = [wDic objectForKey:@"w"];
                [tempStr appendString: str];
            }
        }
    }
    return tempStr;
}


/*!
 *  音量变化回调<br>
 *  在录音过程中，回调音频的音量。
 *
 *  @param volume -[out] 音量，范围从0-30
 */
- (void) onVolumeChanged: (int)volume{
    (self.callVolumeValue)?(self.callVolumeValue(volume)):(nil);
}

/*!
 *  开始录音回调<br>
 *  当调用了`startListening`函数之后，如果没有发生错误则会回调此函数。<br>
 *  如果发生错误则回调onError:函数
 */
- (void) onBeginOfSpeech{
    (self.callRecordState)?(self.callRecordState(BinRecordBegin)):(nil);
}

/*!
 *  停止录音回调<br>
 *  当调用了`stopListening`函数或者引擎内部自动检测到断点，如果没有发生错误则回调此函数。<br>
 *  如果发生错误则回调onError:函数
 */
- (void) onEndOfSpeech{
    (self.callRecordState)?(self.callRecordState(BinRecordEnd)):(nil);
}

/*!
 *  取消识别回调<br>
 *  当调用了`cancel`函数之后，会回调此函数，在调用了cancel函数和回调onError之前会有一个<br>
 *  短暂时间，您可以在此函数中实现对这段时间的界面显示。
 */
- (void) onCancel{
    (self.callRecordState)?(self.callRecordState(BinRecordCancel)):(nil);
}

/*!
 *  返回音频Key
 *
 *  @param key 音频Key
 */
- (void) getAudioKey:(NSString *)key{
    
}

/*!
 *  扩展事件回调<br>
 *  根据事件类型返回额外的数据
 *
 *  @param eventType 事件类型，具体参见IFlySpeechEventType的IFlySpeechEventTypeVoiceChangeResult枚举。
 *  @param arg0      arg0
 *  @param arg1      arg1
 *  @param eventData 事件数据
 */
- (void) onEvent:(int)eventType arg0:(int)arg0 arg1:(int)arg1 data:(NSData *)eventData{
    
}


#pragma mark - 使用自带波形视图的回调方法 IFlyRecognizerViewDelegate

/*!
 *  回调返回识别结果
 *
 *  @param resultArray 识别结果，NSArray的第一个元素为NSDictionary，NSDictionary的key为识别结果，sc为识别结果的置信度
 *  @param isLast      -[out] 是否最后一个结果
 */
- (void)onResult:(NSArray *)resultArray isLast:(BOOL) isLast{
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = resultArray[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    self.result = resultString;
    NSLog(@"目前一共识别的结果!%@", self.result);
    
    __weak __typeof(self) weakself = self;
    if (self.callBackResult) {
        self.callBackResult(0, nil, weakself.result);
    }
}

/*!
 *  识别结束回调
 *
 *  @param error 识别结束错误码
 */
- (void)onError: (IFlySpeechError *) error{
    if (error.errorCode == 0) {
        if (self.result.length<=0) {
            NSLog(@"未识别到内容！");
        }else{
            NSLog(@"内容解析为：%@", self.result);
        }
    }else{
        NSLog(@"错误代码：%d错误描述：%@", error.errorCode, error.errorDesc);
    }
    
    if (self.callBackResult) {
        self.callBackResult(error.errorCode, error.errorDesc, nil);
    }
}



@end
