//
//  BinRFStore.m
//  GeneralProject
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BinRFStore.h"
#import "BinModel.h"

@interface BinRFStore ()
@property (nonatomic, strong) BinModel *mode;
@end

@implementation BinRFStore

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static BinRFStore *instance;
    dispatch_once(&onceToken, ^{
        instance = [[BinRFStore alloc] init];
    });
    return instance;
}

- (instancetype)init{
    if (self = [super init]){
        self.mode = [[BinModel alloc] init];
        self.mode.nickname = @"昵称";
        self.mode.money = 102.f;
    }
    return self;
}

- (NSString *)nickname{
    return self.mode.nickname;
}

//在Reflow里，我们建议所有的数据修改都要生成新的model对象并替换，而不是直接修改原model对象的属性。
- (void)actionChangeNickname:(NSString *)nick{
    BinModel *newModel = [[BinModel alloc] init];
    newModel.nickname = nick;
    newModel.money = self.mode.money;
    self.mode = newModel;
}

- (void)actionChangeMoney:(CGFloat)money{
    BinModel *newModel = [[BinModel alloc] init];
    newModel.money = money;
    newModel.nickname = self.mode.nickname;
    self.mode = newModel;
}

@end
