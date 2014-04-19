//
//  ChatViewController.m
//  XMPPManager
//
//  Created by cocoajin on 14-4-18.
//  Copyright (c) 2014年 com.9ask. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        chatMessage = [[NSMutableString alloc]initWithCapacity:2];
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [chatMessage appendFormat:@"%@@192.168.1.194：%@\n",self.title,self.lastChatMessage];
    
    //初始化页面
    theTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    theTextView.editable = NO;
    theTextView.backgroundColor = [UIColor lightGrayColor];
    theTextView.textColor = [UIColor whiteColor];
    theTextView.font = [UIFont boldSystemFontOfSize:15];
    theTextView.text = chatMessage;
    [self.view addSubview:theTextView];
    
    theTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 205,300,30)];
    theTextField.backgroundColor = [UIColor lightGrayColor];
    theTextView.textColor = [UIColor whiteColor];
    theTextField.returnKeyType = UIReturnKeySend;
    theTextField.delegate = self;
    theTextField.placeholder = @"请输入回复内容";
    [self.view addSubview:theTextField];
    
    //接收新消息通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessageChat:) name:@"RECEMESSAGE" object:nil];
    
    
}

- (void)receiveMessageChat:(NSNotification *)notice
{
    [chatMessage appendFormat:@"%@@192.168.1.194：%@\n",self.title,[notice object]];
    theTextView.text = chatMessage;

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text) {
        [chatMessage appendFormat:@"我的回复：%@\n",textField.text];
        theTextView.text = chatMessage;
        [self sendMessageToFriend];
    }
    
    
    [textField resignFirstResponder];
    return YES;
}

- (void)sendMessageToFriend
{
    NSString *toStr = [NSString stringWithFormat:@"%@@192.168.1.194",self.title];
    
    NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
    [body setStringValue:theTextField.text];
    NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
    [message addAttributeWithName:@"type" stringValue:@"chat"];
    [message addAttributeWithName:@"to" stringValue:toStr];
    [message addChild:body];
    
    NSLog(@"%@",message);
    
    [self.xmppStream sendElement:message];
        
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
