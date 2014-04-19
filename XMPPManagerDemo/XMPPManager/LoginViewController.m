//
//  LoginViewController.m
//  XMPPChat
//
//  Created by cocoajin on 14-4-16.
//  Copyright (c) 2014年 www.zhgu.net. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"请先登录";
    self.view.backgroundColor = [UIColor grayColor];
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelLogin)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    UIBarButtonItem *loginAction = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(doLoginAction)];
    
    self.navigationItem.rightBarButtonItem = loginAction;
    
    
    
    CGRect theFrame = CGRectMake(20, 20, 280, 20);
    [self createLabel:@"用户名" theFrame:theFrame];
    theFrame = CGRectMake(20, 45, 280, 30);
    userName = [self createTextWith:@"请输入用户名" theFrame:theFrame];
    
    theFrame = CGRectMake(20, 85, 280, 20);
    [self createLabel:@"密码" theFrame:theFrame];
    theFrame = CGRectMake(20, 110, 280, 30);
    userPassword = [self createTextWith:@"请输入密码" theFrame:theFrame];
    
    theFrame = CGRectMake(20, 150, 280, 20);
    [self createLabel:@"服务器IP" theFrame:theFrame];
    theFrame = CGRectMake(20, 175, 280, 30);
    serverIP = [self createTextWith:@"请输入服务器ip地址" theFrame:theFrame];
    serverIP.keyboardType = UIKeyboardTypeDecimalPad;
    
    userName.text = @"jkk@192.168.1.194";
    userPassword.text = @"123";
    serverIP.text = @"192.168.8.12";
    
    //取消键盘
    [self resignKeyBoard];
    
}

//login action
- (void)doLoginAction
{
    
    [self.delegate loginWith:userName.text pwd:userPassword.text serverIP:serverIP.text];
    [self cancelLogin];


}
- (void)cancelLogin
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



//Textfiled
- (UITextField *)createTextWith:(NSString *)text theFrame:(CGRect )frame
{
    UITextField *theTextField = [[UITextField alloc]initWithFrame:frame];
    theTextField.borderStyle = UITextBorderStyleRoundedRect;
    theTextField.placeholder = text;
    theTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    theTextField.clearButtonMode =UITextFieldViewModeAlways;
    theTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:theTextField];
    
    return theTextField;
    
}

//label
- (void)createLabel:(NSString *)text theFrame:(CGRect )frame
{
    UILabel *theLabel = [[UILabel alloc]initWithFrame:frame];
    theLabel.textColor = [UIColor whiteColor];
    theLabel.text = text;
    theLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:theLabel];
}

//取消键盘
- (void)resignKeyBoard
{
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doResignKeyBoard)];
    [self.view addGestureRecognizer:tapGest];
}

- (void)doResignKeyBoard
{
    [userName resignFirstResponder];
    [userPassword resignFirstResponder];
    [serverIP resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
