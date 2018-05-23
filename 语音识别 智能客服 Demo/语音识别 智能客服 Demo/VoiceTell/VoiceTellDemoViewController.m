//
//  VoiceTellDemoViewController.m
//  语音识别 智能客服 Demo
//
//  Created by apple on 2018/5/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "VoiceTellDemoViewController.h"
#import "BiniFlyManager.h"

@interface VoiceTellDemoViewController ()

@property (nonatomic, weak) BiniFlyManager *iflyMgr;

@end

@implementation VoiceTellDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.iflyMgr = [BiniFlyManager sharedInstance];//设置语言[BiniFlyManager setupLanguage:...];初始化识别参数[... reSetupRecognizer];
    
    ///设置完语言后 必须要调用reSetupRecognizer才能生效
    [BiniFlyManager setupLanguage:BinMandarin];
    [self.iflyMgr reSetupRecognizer];
    ///
    
    [self.iflyMgr setCallBackResult:^(BinError errorCode, NSString *errorDes, NSString *result) {
        ;
    }];
    
    //以下两个只有在 iflyControl为NO才会有回调
    [self.iflyMgr setCallRecordState:^(BinRecordState state) {
        ;
    }];
    [self.iflyMgr setCallVolumeValue:^(int volume) {
        ;
    }];
}

- (IBAction)startAction:(UIButton *)sender {
    [self.iflyMgr startWorkAction];
}

- (IBAction)endAction:(UIButton *)sender {
    [self.iflyMgr stopWorkAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
