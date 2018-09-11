//
//  ViewController.m
//  ZJPayPassword修复用户输入过快回调多次和关闭输入框立即弹出UIAlertView解决方案
//
//  Created by apple on 2018/9/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "ZJPayPopupView.h"

@interface ViewController () <ZJPayPopupViewDelegate>

@property (nonatomic, strong) ZJPayPopupView *payPopupView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.payPopupView = [[ZJPayPopupView alloc] init];
        self.payPopupView.delegate = self;
        [self.payPopupView showPayPopView];
    });
}

#pragma mark - ZJPayPopupViewDelegate

- (void)didClickForgetPasswordButton
{
    NSLog(@"点击了忘记密码");
}


/// MBProgressHud 请自行导入
- (void)didPasswordInputFinished:(NSString *)password
{
    __weak __typeof(self) weakself = self;
    
    //code 调用网络接口...
    
    //    MBProgressHUD *hud = [MBProgressHUD showMessage:@"支付中..."];
    
    NSInteger status = 1;//0 是成功的情况关闭密码框 1是先关闭密码框然后弹出其他视图的情况 2是密码错误
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //        [hud hideAnimated:NO];
        
        //        [MBProgressHUD showSuccess:response.status.desc];
        
        if (status == 0) {//网络成功后的情况
            //            [hud hideAnimated:NO];
            
            //            [MBProgressHUD showSuccess:@"成功"];
        }else if (status == 1){//隐藏提示 关闭输入框 弹出其他视图 hidePayPopView有做修改，去掉了动画
            //            [hud hideAnimated:NO];
            
            //            [self.payPopupView hidePayPopView];
            
            //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //                [UIAlertView bk_showAlertViewWithTitle:nil message:@"您还有没设置密码，请前往设置!" cancelButtonTitle:@"取消" otherButtonTitles:@[@"是"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            //                    if (buttonIndex == 0) {
            //                    }else if (buttonIndex == 1){
            //                        NSLog(@"进入设置密码页面");
            //                        ForgotViewController *forgotViewController = [[ForgotViewController alloc] init];
            //                        forgotViewController.mobile = @"18321887512";
            //                        [self.navigationController pushViewController:forgotViewController animated:YES];
            //                    }
            //                }];
            //            });
        }else{
            //            [hud hideAnimated:NO];
            //            [self.payPopupView didInputPayPasswordError];
        }
        
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
