//
//  BinRFStore.h
//  GeneralProject
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RFStore.h"
#import <UIKit/UIKit.h>

@interface BinRFStore : RFStore

+ (instancetype)sharedInstance;

#pragma mark - getter 获取数据
- (NSString *)nickname;

#pragma mark - action 修改数据
- (void)actionChangeNickname:(NSString *)nick;
- (void)actionChangeMoney:(CGFloat)money;

@end
