//
//  B.m
//  XMPPManager
//
//  Created by cocoajin on 14-4-17.
//  Copyright (c) 2014年 com.9ask. All rights reserved.
//

#import "B.h"

@implementation B

+(id)shareB
{
    static B *bShare = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bShare = [B new];
    });
    
    return bShare;
}

- (void)testB
{
    NSLog(@"line<%d> %s",__LINE__,__func__);
    
    A *aV = [A new];
    aV.delegate = self;
    
    //有时，如果代理方法不走，就要用 单例方法实现了；

    [aV aAction];
    
    
}

- (void)testA
{
    NSLog(@"line<%d> %s",__LINE__,__func__);
}


@end
