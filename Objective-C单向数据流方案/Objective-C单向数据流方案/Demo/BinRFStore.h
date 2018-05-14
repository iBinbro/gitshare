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

#pragma mark - getter
- (NSString *)nickname;

#pragma mark - action
- (void)actionChangeNickname:(NSString *)nick;
- (void)actionChangeMoney:(CGFloat)money;

@end
