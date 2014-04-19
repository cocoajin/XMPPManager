//
//  A.h
//  XMPPManager
//
//  Created by cocoajin on 14-4-17.
//  Copyright (c) 2014年 com.9ask. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ADelegate <NSObject>

- (void)testA;

@end

@interface A : NSObject

@property (nonatomic,assign)id<ADelegate>delegate;

- (void)aAction;

@end
