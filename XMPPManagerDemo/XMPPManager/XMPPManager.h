//
//  XMPPManager.h
//  XMPPManager
//
//  Created by cocoajin on 14-4-17.
//  Copyright (c) 2014年 com.9ask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"

#import "XMPPManagerDelegate.h"

@interface XMPPManager : NSObject

@property (nonatomic,strong)XMPPStream *xmppStream;

@property (nonatomic,assign)id<XMPPManagerDelegate>delegate;

/**
 *  设置xmpp服务器的ip
 *
 *  @param hostIP 服务器ip
 *
 *  @return 返回一个xmpp服务器管理器
 */
+ (id)managerWith:(NSString *)hostIP;


/**
 *  设置登录用户名和密码
 *
 *  @param userName 用户名
 *  @param pwd      密码
 */
- (void)setUserName:(NSString *)userName password:(NSString *)pwd;

/**
 *  设置 xmppStrem;
 */
- (void)setUpStream;

/**
 *  连接服务器；
 *
 *  @return 是否连接成功
 */
- (BOOL)connectServer;

/**
 *  断开服务器连接；
 */
- (void)disConnect;

/**
 *  上线；
 */
- (void)goOnLine;

/**
 *  离线；
 */
- (void)goOffLine;

@end
