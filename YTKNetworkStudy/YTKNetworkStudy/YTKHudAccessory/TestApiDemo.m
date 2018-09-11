//
//  TestApiDemo.m
//  YTKNetworkStudy
//
//  Created by apple on 2018/5/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "TestApiDemo.h"

@interface TestApiDemo ()
@property (nonatomic, copy) NSString *name;

@end

@implementation TestApiDemo

- (instancetype)initWithName:(NSString *)name{
    if (self = [super init]){
        _name = name;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/auth/token";
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

- (id)requestArgument{
    return @{@"name": _name};
}

@end
