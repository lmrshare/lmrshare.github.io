---
layout: post
title: "Effective TCP/IP Programming"
date: 2018-08-23 
description: "Notes about Effective TCP/IP Programming"
tag: Computer Basises
---

### Effective TCP/IP Programming

这本书是读中文版Effective TCP/IP Programming所做的读书笔记

#### Introduction

___一、基本的Socket API回顾___

1. 通过socket系统调用获得一个socket, 系统调用函数的参数如下:

___domain:___

>* AF_INET用于网络
>* AF_LOCAL用于IPC

___type(套接字类型):___

>* SOCK_STREAM: 可靠、全双工的面向连接的字节流. 在TCP/IP中指的是TCP
>* SOCK_DGRAM: 不可靠、高效率的数据服务. 在TCP/IP中指的是UDP
>* SOCK_RAW: 可以访问IP层中的一些数据报, 可用于坚挺ICMP消息

___protocol:___

>* 指示socket使用哪个协议, 对于TCP/IP, 通常设置成0. 而对于RAW类型socket则有几个可能的协议

2. 建立连接(connect), connect的参数如下:

___s:___

>* 系统调用获得的socket

___peer:___

>* 对端的地址和其他信息, 对于AF_INET, 这是一个sockaddr_in结构

___peer_len:___

>* peer指向的结构的大小

3. 连接建立成功后, 就可以传输数据了:

>* UNIX: 可使用read/write函数, 这两个函数的参数是一样的, 重点说下里面跟系统相关的参数flag
>* Windows: recv/send函数, 参数也是一样的

___flag:___

>* MSG_OOB: 发送或读取; 紧急数据
>* MSG_PEEK: 读取; 可以重复读的(因为缓冲区里不删除该标记的数据) 
>* MSG_DONTROUTE: 系统内核会忽略路由功能; 用于路由程序或诊断

在UDP中, 用于收发数据的函数是recfrom, sendto. 注意: 从函数名可知, UDP里的收发数据函数是可指定地址的.

#### confuse me



### Review:

xxx

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2018/06/today/) 
