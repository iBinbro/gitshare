//
//  ViewController.m
//  语音识别 智能客服 Demo
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "VoiceTellDemoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    VoiceTellDemoViewController *voiceTellDemoViewController =[[VoiceTellDemoViewController alloc] init];
    [self presentViewController:voiceTellDemoViewController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
