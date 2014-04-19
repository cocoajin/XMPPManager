XMPPManager
===========

基于XMPPFramework的 ios端聊天程序

### 配置环境
`XMPPManager`是基于 XMPPFramework的，请先下载配置 ；[https://github.com/robbiehanson/XMPPFramework](https://github.com/robbiehanson/XMPPFramework)			
`XMPPFramework`环境配置 [http://www.cnblogs.com/cocoajin/p/3668373.html](http://www.cnblogs.com/cocoajin/p/3668373.html)

### XMPPManager使用
1. 在 AppDelegate.h 里面导入 `XMPPManager.h`,添加代理 `XMPPManagerDelegate`
2. 在 AppDelegate.m 里面 连接服务器，并实现相应代理即可
	```objective-c
	    //初始化服务器连接管理
    XMPPManager  *manager = [XMPPManager managerWith:ip];
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
	```
	ip: 服务器IP地址，默认端口为 `5222`
	userName:登录用户名；
	pwd:密码
3.实现相应的代理方法即可
### XMPPManager 可以代理方法

查看 `XMPPManagerDelegate.h`
- 用户登录成功代理
- 新用户上线代理
- 用户离线代理
- 收到新消息代理


### 反馈
`dev.keke@gmail.com`

