---
title: auto login
author: Shwin
layout: post
tag: Python
---

### 编写一个自动登陆校园网的程序

# 1
首先先安装一个`fiddler`软件，用来抓包的。主要抓取你登录验证的时候的post的内容，这个可以用到后面代码里面去。

剩余部分参考这篇博文: [python脚本实现自动登陆校园网 - CSDN博客](https://blog.csdn.net/abitch/article/details/51939879)  
> 我就说这个一路下来的，用python写登录，然后C#写了一个心跳程序判断是否连接外网，断网了就调用python登录。  

# 2
然后使用windows的`任务计划`使这个脚本开机自动启动、或者定时启动（设置里增加支持唤醒）  
**参考**: [python脚本随机启动](http://www.cnblogs.com/nju2014/p/5496367.html)  
**其他参考**: [校园网自动登陆（主要是检测断网方式不同）](http://www.cnblogs.com/bbbbbq/p/5474912.html)  

# 代码块
```
import os
import requests
import time

# 检测是否断网
def check():
	os.system('date/t > C:\Users\shwin\Desktop\log.txt')
	os.system('time/t >> C:\Users\shwin\Desktop\log.txt')
	if os.system('ping -n 1 8.8.8.8 >> C:\Users\shwin\Desktop\log.txt'): # 8.8.8.8: google dns 服务器
		return False
	else:
		return True
		
def login():
  	# Fiddler抓包得到的登陆地址
	url='http://p.nju.edu.cn/portal_io/login'
    
    # 报文内容：用户名和密码
	dat={
		'username': 'MG1626012',
		'password': '***********' # 匿名== 
	}
    
    # 发给服务器的头域内容（必要性不大），由Fiddler抓包得到
	head={
		'Connection': 'keep-alive',
		'Accept': 'application/json, text/javascript, */*; q=0.01',
		'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36'
	}
    
    # post操作以登陆
	requests.post(url,data=dat,headers=head)
	
def main():
  	# 心跳程序
	while(True):
		if not check():
			print '----------------offline------------------'
			login()
			if check():
				print '> Reconnect success!'
			else:
				print '> Reconnect failed!'
		# else:
			# print '> online'
		time.sleep(60)
		
if __name__=='__main__':
	main()
```