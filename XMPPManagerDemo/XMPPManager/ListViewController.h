//
//  ListViewController.h
//  XMPPManager
//
//  Created by cocoajin on 14-4-17.
//  Copyright (c) 2014年 com.9ask. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XMPPManager.h"

#import "LoginViewController.h"


@interface ListViewController : UITableViewController<XMPPManagerDelegate,LoginViewControllerDelegate>

{
    NSMutableArray *onlineUsers;        //在线用户
    NSMutableArray *offlineUsers;       //离线用户
    BOOL pushToChatPage;                //是否push到聊天页面
    NSString *lastChatMessage;          //接收的最后一次信息
    
    XMPPManager *manager;
}



@end
