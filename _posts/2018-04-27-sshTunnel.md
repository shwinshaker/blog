---
title: ssh Tunnel
author: Shwin
layout: post
category: Technique
---

### 外网ssh到内网服务器(ssh解决方案)
> 我的数据都部署在学校服务器上，而人又经常不在学校，所以有这个需求



# 硬件要求
* 位于内网、无外网连接的服务器(即ssh的连接目标) —— **Destination**
* 位于内网、有外网连接的任意主机(Windows,Linux) —— **Bridge**
* 位于外网的服务器(腾讯有很便宜的学生服务器，可以免费试用7天) —— **Server**
* 任一需要连接到内网服务器的主机(我的是Mbp) —— **Client**

# 基本原理
**使用ssh的正向和反向隧道连通内外网**
* 在**Bridge**上启用正向隧道连接到**Destination**
* 在**Bridge**上启用反向隧道，使得**Server**能够连接到**Bridge**
* **Client**通过连接到**Server**，再转由**Bridge**连接到**Destination**

# 基本操作
1. 在**Server**，**Bridge**和**Destination**上都启用sshd服务  
2. 在**Client**和**Bridge**上安装ssh  
3. 在**Bridge**上运行：  
`ssh -N -R Server-Port:localhost:Bridge-Port Server-User@Server-Address`  
其中`localhost`指的是**Bridge**。  
此时在**Server**上运行`netstat -tnl`，应能看到`Server-Port`被监听，且地址为`0.0.0.0`  
4. 在**Bridge**上运行：  
`ssh -N -L Bridge-Port:localhost:Destination-Port Destination-User@Destination-Address`  
其中`localhost`指的是**Destination**。  
注意这时在**Destination**上运行`netstat -tnl`并不会看到`Destination-Port`被打开，这可能要求`Destination-Port`为已有的端口，如`22`。  
同样在**Bridge**上也不会看到`Bridge-Port`被打开，这要求这里的`Bridge-Port`和反向隧道上的`Bridge-Port`完全一样
5. 在**Client**上连接  
`ssh -p Server-Port Destination-User@Server-Address`   
注意这里的`User`必须是**Destination**上的，因为已经做了端口转发，如果是**Server**上的，则会导致密码不正确，即错误1

# 常见报错
> User@Address's password: Permission denied, please try again.

* 可能是`User`不正确，要注意端口转发的顺序，连接已经转发的端口则相当于是其目标端口的`User`，虽然它的`Address`仍然是当前端口的

> ssh: connect to host \*.\*.\*.\* port **** : Connection refused

* 可能是端口没有打开，使用`netstat -tnl`确认端口打开
* 可能是`sshd`服务没有启用

> ssh_exchange_identification: Connection closed by remote host

* 可能是sshd服务没有打开
* 可能是端口没有打开，在**Destination**上可能需要22端口
* 可能是`hosts`中有屏蔽，请查看`/etc/hosts.deny`和`/etc/hosts.allow`
* 可能是端口权限问题，保证**Server**上端口地址为`0.0.0.0`，即对所有人开放，尝试在Server-Port前加 * 可以解决这个问题
*详见：[How to make ssh tunnel open to public?](https://superuser.com/questions/588591/how-to-make-ssh-tunnel-open-to-public)*
* /etc/ssh_config中的具体配置可能没有很重要

# 其他参考
> 关于命令参数  

* `-R` —— **Remote**，反向代理或远程转发   
* `-L` —— **Local**，正向代理或本地转发  
* `-N` —— 仅转发，不做任何操作，如果不加这个参数转发的时候就会直接登录了   
* `-f` —— 后台运行   
* `-C` —— **Compressed** 压缩数据  


> 关于系统  

* 如果**Bridge**是windows系统，可以安装`cygwin`来使用linux环境，安装时勾选ssh和sshd；或者可以使用`Putty`或`XShell`等三方软件，其中`XShell`还是很好做隧道的


> 关于免密登录  

* 将公钥`id_rsa.pub`添加到服务器`Authorized_key`中，或者使用`ssh-copy-id`命令，注意文件权限(见另一个gist)


> 一些有用的命令  

* `server sshd restart` —— 重启sshd服务(如果修改`/etc/sshd_config`则需重启sshd)
* `netstat -tnl` —— 查看端口监听情况
* `ssh -4 ...`可以指定为`tcp`端口，对应`ipv4`，而`tcp6`对应`ipv6`
* `ssh -v`可以开启`verbose`模式，用于调试(`ssh -vvv`会输出更多信息)


> 一些有用的知识

* `127.0.0.1`即`localhost`，`127.0.0.1:Port`只能被`localhost`使用; `0.0.0.0`表示所有连接，`0.0.0.0:Port`可以被任意Client使用

# 一些改进
* 使用`autossh`以增强连接稳定性  
上述命令改为  
`autossh -M Listening-Port -N -R Server-Port:localhost:Bridge-Port Server-User@Server-Address`   
`autossh -M Listening-Port -N -L Bridge-Port:localhost:Destination-Port Destination-User@Destination-Address`   
其中`Listening-Port`即`autossh`的监听端口，后面的一样

# 参考文章
* [SSH正向、反向代理与动态转发](https://www.codeboy.me/2015/11/12/ssh-proxy/)
* [sshd_config 中文手册](http://www.jinbuguo.com/openssh/sshd_config.html)
* [从外网 SSH 进局域网，反向代理+正向代理解决方案](https://segmentfault.com/a/1190000002718360)
* [使用Xshell部署ssh](http://blog.chinaunix.net/uid-21710354-id-5199179.html)