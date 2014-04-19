//
//  B.h
//  XMPPManager
//
//  Created by cocoajin on 14-4-17.
//  Copyright (c) 2014年 com.9ask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "A.h"

@interface B : NSObject<ADelegate>

+(id)shareB;

- (void)testB;

@end
