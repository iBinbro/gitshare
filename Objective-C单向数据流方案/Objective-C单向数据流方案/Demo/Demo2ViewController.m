//
//  Demo2ViewController.m
//  GeneralProject
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "Demo2ViewController.h"
#import "BinRFStore.h"

@interface Demo2ViewController ()

@property (nonatomic, strong) RFSubscription *subscription;

@property (weak, nonatomic) IBOutlet UITextField *inputTextF;

@end

@implementation Demo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    BinRFStore *binRFStore = [BinRFStore sharedInstance];
    
    self.inputTextF.text = binRFStore.nickname;
    
    //    RFAction
    //    @property (nonatomic, readonly) id object;
    //    @property (nonatomic, readonly) SEL selector;
    //    @property (nonatomic, readonly) NSArray *arguments;
    self.subscription = [binRFStore subscribe:^(RFAction *action) {
        NSLog(@"%@==%@==%@", NSStringFromSelector(action.selector), action.object, action.arguments);
        NSString *finalValue = action.arguments.firstObject;
        self.inputTextF.text = finalValue;
    }];
}

- (IBAction)changeValue:(id)sender {
    BinRFStore *binRFStore = [BinRFStore sharedInstance];
    [binRFStore actionChangeNickname:self.inputTextF.text];
}



- (void)dealloc{
    NSLog(@"Demo2ViewController释放掉了");
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
