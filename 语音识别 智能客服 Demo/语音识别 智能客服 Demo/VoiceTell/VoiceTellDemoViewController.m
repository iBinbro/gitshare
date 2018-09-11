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
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *errorStatusL;
@property (weak, nonatomic) IBOutlet UILabel *volmeL;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

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
    
    __weak __typeof(self) weakself = self;
    [self.iflyMgr setCallBackResult:^(BinError errorCode, NSString *errorDes, NSString *result) {
        if (errorCode == BinNoError) {
            weakself.contentTextView.text = result;
        }
        weakself.errorStatusL.text = [NSString stringWithFormat:@"状态码:%lu,描述:%@", (unsigned long)errorCode, errorDes];
    }];
    
    //以下两个只有在 iflyControl为NO才会有回调
    //回调状态 录音开始 结束 识别被取消
    [self.iflyMgr setCallRecordState:^(BinRecordState state) {
        switch (state) {
            case BinRecordBegin:
                weakself.startBtn.enabled = NO;
                weakself.cancelBtn.enabled = YES;
                break;
            case BinRecordEnd:
                weakself.startBtn.enabled = YES;
                weakself.cancelBtn.enabled = NO;
                break;
            case BinRecordCancel:
                weakself.startBtn.enabled = YES;
                weakself.cancelBtn.enabled = YES;
                break;
            default:
                break;
        };
    }];
    //回调音量
    [self.iflyMgr setCallVolumeValue:^(int volume) {
        weakself.volmeL.text = [NSString stringWithFormat:@"%d", volume];;
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
