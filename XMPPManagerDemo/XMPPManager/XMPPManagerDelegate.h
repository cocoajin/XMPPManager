//
//  XMPPManagerDelegate.h
//  XMPPManager
//
//  Created by cocoajin on 14-4-17.
//  Copyright (c) 2014年 com.9ask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPP.h"

@protocol XMPPManagerDelegate <NSObject>

@optional

/**
 *  用户登录服务器成功
 *
 *  @param userJID 登录用户信息
 */
- (void)userLoginSuccess:(XMPPJID *)userJID;

/**
 *  新用户上线回调
 *
 *  @param presence 上线用户
 */
- (void)newUserOnline:(XMPPPresence *)presence;

/**
 *  用户离线回调
 *
 *  @param presence 离线用户
 */
- (void)hasUserOffline:(XMPPPresence *)presence;

/**
 *  收到新消息
 *
 *  @param message 新消息内容
 */
- (void)didReceiveMessage:(XMPPMessage *)message;



@end
