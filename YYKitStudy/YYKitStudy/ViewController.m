//
//  ViewController.m
//  YYKitStudy
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "YYImageDemoViewController.h"

#import <GYHttpMock.h>
#import <AFNetworking.h>

@interface ViewController (){
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //YYImageDemo
//    [self presentVC];
    
    //httpMockDemo
    [self httpMock];
}

- (void)presentVC{
    YYImageDemoViewController *yyImageDemoViewController = [[YYImageDemoViewController alloc] init];
    [self presentViewController:yyImageDemoViewController animated:YES completion:nil];
}

- (void)httpMock{
    
    
//    mockRequest(@"", <#id url#>)
//
//
//    [[AFHTTPSessionManager manager] POST:@"http://www.weread.com" parameters:@{@"name":@"abc"} progress:^(NSProgress * _Nonnull uploadProgress) {
//        ;
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        ;
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        ;
//    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
