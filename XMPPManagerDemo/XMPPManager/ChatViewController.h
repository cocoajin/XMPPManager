//
//  ChatViewController.h
//  XMPPManager
//
//  Created by cocoajin on 14-4-18.
//  Copyright (c) 2014年 com.9ask. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XMPPFramework.h"


@interface ChatViewController : UIViewController<UITextFieldDelegate>

{
    UITextView *theTextView;            //聊天窗口
    NSMutableString *chatMessage;       //聊天信息
    UITextField *theTextField;          //输入框
}

@property (nonatomic,strong)NSString *lastChatMessage;

@property (nonatomic,strong)XMPPStream *xmppStream;



@end
