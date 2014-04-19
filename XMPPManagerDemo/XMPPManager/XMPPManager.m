//
//  XMPPManager.m
//  XMPPManager
//
//  Created by cocoajin on 14-4-17.
//  Copyright (c) 2014年 com.9ask. All rights reserved.
//

#import "XMPPManager.h"

static XMPPManager *theManager = nil;

@interface XMPPManager ()

{
    NSString *theHostIP;
    NSString *theUserName;
    NSString *thePasswrod;
}

@end

@implementation XMPPManager

#pragma mark public method

+ (id)managerWith:(NSString *)hostIP
{
    XMPPManager *manager = [[XMPPManager alloc]initWith:hostIP];
    theManager = manager;
    return manager;
}

- (id)initWith:(NSString *)hostIP
{
    self = [super init];
    if (self) {
        theHostIP = hostIP;
    }
    
    return self;
}

- (void)setUserName:(NSString *)userName password:(NSString *)pwd
{
    theUserName = userName;
    thePasswrod = pwd;
}

- (void)setUpStream
{
    self.xmppStream = [[XMPPStream alloc]init];
    [_xmppStream addDelegate:theManager delegateQueue:dispatch_get_main_queue()];
}

- (BOOL)connectServer
{
    [self setUpStream];
    
    if (![_xmppStream isDisconnected]) {
        return YES;
    }
    
    
    if (theHostIP==nil || thePasswrod==nil || theUserName==nil) {
        NSLog(@" -- 服务器连接错误：ip、用户名、密码 不能为空。");
        return NO;
    }
    
    [_xmppStream setMyJID:[XMPPJID jidWithString:theUserName]];
    [_xmppStream setHostName:theHostIP];

    NSError *connectError = nil;
    if (![_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&connectError]) {
        NSLog(@" -- 服务器连接错误：%@",connectError);
        
        return NO;
    }
    return YES;
}

- (void)disConnect
{
    [self goOffLine];
    [_xmppStream disconnect];
}

- (void)goOnLine
{
    XMPPPresence *presence = [XMPPPresence presence];
    NSString *domain = [_xmppStream.myJID domain];
    
    //Google set their presence priority to 24, so we do the same to be compatible.
    
    if([domain isEqualToString:@"gmail.com"]
       || [domain isEqualToString:@"gtalk.com"]
       || [domain isEqualToString:@"talk.google.com"])
    {
        NSXMLElement *priority = [NSXMLElement elementWithName:@"priority" stringValue:@"24"];
        [presence addChild:priority];
    }

    [_xmppStream sendElement:presence];
    
    if ([self.delegate respondsToSelector:@selector(userLoginSuccess:)]) {
        [self.delegate userLoginSuccess:_xmppStream.myJID];
    }
}

- (void)goOffLine
{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
	
	[_xmppStream sendElement:presence];
}

#pragma mark XMPPStream Delegate

//socket连接建立成功
- (void)xmppStream:(XMPPStream *)sender socketDidConnect:(GCDAsyncSocket *)socket
{
    
}

//连接成功到服务器
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSError *authError = nil;
    if (![_xmppStream authenticateWithPassword:thePasswrod error:&authError]) {
        if (authError) {
            NSLog(@" -- 服务器密码难证错误：%@",authError);
        }
    }
}

//登录验证成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    [self goOnLine];
    
}

//验证登录失败
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
    NSLog(@" -- 验证登录错误：%@",error);
}

//收到信息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    
    /*
    if ([message isChatMessageWithBody])
	{
		
		NSString *body = [[message elementForName:@"body"] stringValue];
		NSString *displayName = [[message from] user];
        
		if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive)
		{
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:displayName
                                                                message:body
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
			[alertView show];
		}
		else
		{
			// We are not active, so use a local notification instead
			UILocalNotification *localNotification = [[UILocalNotification alloc] init];
			localNotification.alertAction = @"Ok";
			localNotification.alertBody = [NSString stringWithFormat:@"From: %@\n\n%@",displayName,body];
            
			[[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
		}
	}
     
     */
    
    if ([self.delegate respondsToSelector:@selector(didReceiveMessage:)]) {
        [self.delegate didReceiveMessage:message];
    }
    
    

}

//好友在线状态
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    //取得好友状态
    NSString *presenceType = [presence type]; //online/offline
    NSString *userId = [[sender myJID] user];
    NSString *presenceFromUser = [[presence from] user];
    //NSLog(@" -- 用户状态：%@ %@",presenceFromUser,presenceType);
    
    if (![presenceFromUser isEqualToString:userId]) {
        
        //在线状态
        if ([presenceType isEqualToString:@"available"]) {
            
            if ([self.delegate respondsToSelector:@selector(newUserOnline:)]) {
                [self.delegate newUserOnline:presence];
            }
        }
        else if ([presenceType isEqualToString:@"unavailable"]) {
            
            if ([self.delegate respondsToSelector:@selector(hasUserOffline:)]) {
                [self.delegate hasUserOffline:presence];
            }
            
        }
        
        
    }
}

//收到连接错误
- (void)xmppStream:(XMPPStream *)sender didReceiveError:(id)error
{
    NSLog(@" ** 收到 Stream 错误 %@",error);
}

//断开连接发生错误
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    NSLog(@" ** 断开服务器连接 错误 %@",error);

}


@end
