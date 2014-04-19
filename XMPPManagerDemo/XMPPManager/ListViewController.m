//
//  ListViewController.m
//  XMPPManager
//
//  Created by cocoajin on 14-4-17.
//  Copyright (c) 2014年 com.9ask. All rights reserved.
//

#import "ListViewController.h"
#import "XMPPFramework.h"
#import "TDBadgedCell.h"
#import "ChatViewController.h"



@interface ListViewController ()

@end

@implementation ListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        onlineUsers = [[NSMutableArray alloc]initWithCapacity:2];
        offlineUsers = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    pushToChatPage = NO;

    

}
- (void)viewWillDisappear:(BOOL)animated
{
    pushToChatPage = YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = YES;
    self.title = @"好友列表";
    
    //先登录
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    UINavigationController *loginNav = [[UINavigationController alloc]initWithRootViewController:loginVC];
    loginVC.delegate = self;
    loginNav.navigationBar.translucent = NO;
    [self.navigationController presentViewController:loginNav animated:YES completion:nil];
    

    

}

- (void)loginWith:(NSString *)userName pwd:(NSString *)pwd serverIP:(NSString *)ip
{
    //初始化服务器连接管理
    manager = [XMPPManager managerWith:ip];
    manager.delegate = self;
    
    [manager setUserName:userName password:pwd];
    BOOL coonect = [manager connectServer];
    if (coonect) {
        NSLog(@"连接成功");
    }
    else
    {
        NSLog(@"连接失败");
    }
}

#pragma mark XMPPManager 代理；

//收到消息
- (void)didReceiveMessage:(XMPPMessage *)message
{
    NSString *body = [[message elementForName:@"body"] stringValue];
    NSString *displayName = [[message from] user];
    NSLog(@"%@ %@",body,displayName);
    lastChatMessage = body;
    NSIndexPath *thePath = nil;
    if ([onlineUsers containsObject:displayName]&&(pushToChatPage==NO)) {
        
        thePath = [NSIndexPath indexPathForRow:[onlineUsers indexOfObject:displayName] inSection:0];
        TDBadgedCell *theCell = (TDBadgedCell *)[self.tableView cellForRowAtIndexPath:thePath];
        int nums = [theCell.badgeString intValue];
        nums +=1;
        theCell.badgeString = [NSString stringWithFormat:@"%d",nums];
        theCell.detailTextLabel.text = [NSString stringWithFormat:@"新消息: %@",body];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RECEMESSAGE" object:body];
    }
}

//用户登录
- (void)userLoginSuccess:(XMPPJID *)userJID
{
    NSLog(@"用户：%@ 登录成功",userJID.user);
    
}

//新用户在线
- (void)newUserOnline:(XMPPPresence *)presence
{
    NSLog(@"发现用户：%@ 上线",[[presence from] user]);
    NSString *user = [[presence from] user];
    if (![onlineUsers containsObject:user]) {
        [onlineUsers addObject:user];
    }
    
    if ([offlineUsers containsObject:user]) {
        [offlineUsers removeObject:user];
    }
    
    [self.tableView reloadData];

}

//用户下线
- (void)hasUserOffline:(XMPPPresence *)presence
{
    NSLog(@"发现用户：%@ 离线",[[presence from] user]);
    NSString *user = [[presence from] user];
    if (![offlineUsers containsObject:user]) {
        [offlineUsers addObject:user];
    }
    
    if ([onlineUsers containsObject:user]) {
        [onlineUsers removeObject:user];
    }
    
    [self.tableView reloadData];


}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
//    if (!lastChatMessage) {
//        return;
//    }
    
    TDBadgedCell *theCell = (TDBadgedCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    theCell.badgeString = nil;
    
    ChatViewController *chatVC = [[ChatViewController alloc]init];
    chatVC.xmppStream = manager.xmppStream;
    
    chatVC.title = indexPath.section==0?[onlineUsers objectAtIndex:indexPath.row]:[offlineUsers objectAtIndex:indexPath.row];
    chatVC.lastChatMessage = lastChatMessage;
    
    [self.navigationController pushViewController:chatVC animated:YES];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section==0?@"在线好友":@"离线好友";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?[onlineUsers count]:[offlineUsers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TDBadgedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[TDBadgedCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = indexPath.section==0?[onlineUsers objectAtIndex:indexPath.row]:[offlineUsers objectAtIndex:indexPath.row];
    cell.badgeColor = [UIColor redColor];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.text = @"无新消息";
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    cell.badge.fontSize = 15;
    cell.badge.boldFont = YES;
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

