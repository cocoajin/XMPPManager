//
//  LoginViewController.h
//  XMPPChat
//
//  Created by cocoajin on 14-4-16.
//  Copyright (c) 2014年 www.zhgu.net. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LoginViewControllerDelegate <NSObject>

@required

- (void)loginWith:(NSString *)userName pwd:(NSString *)pwd serverIP:(NSString *)ip;

@end

@interface LoginViewController : UIViewController

{
    UITextField *userName;
    UITextField *userPassword;
    UITextField *serverIP;
}

@property (nonatomic,assign)id <LoginViewControllerDelegate>delegate;

@end
