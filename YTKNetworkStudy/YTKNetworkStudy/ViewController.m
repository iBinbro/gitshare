//
//  ViewController.m
//  YTKNetworkStudy
//
//  Created by apple on 2018/5/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "TestApiDemo.h"
#import "YTKBaseRequest+AnimatingAccessory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    TestApiDemo *testapi = [[TestApiDemo alloc] initWithName:@"wocao"];
    testapi.animatingView = self.view;
    testapi.animatingText = @"hehehe";
    [testapi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        NSLog(@"success=%@", dict);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"fail");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
