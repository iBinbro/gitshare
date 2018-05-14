//
//  ViewController.m
//  Objective-C单向数据流方案
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "ReflowDemoViewController.h"
#import <Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@100);
        make.center.equalTo(self.view);
    }];
    
}
- (IBAction)pushReflowDemoVC:(id)sender {
    ReflowDemoViewController *reflowDemoViewController = [[ReflowDemoViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:reflowDemoViewController];
    [self presentViewController:nav animated:YES completion:^{
        ;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
