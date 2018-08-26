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

### network basises

>* mac addr: decide next step
>* 路由器：在不同网段之间转发数据

OSI

>* 应用层：是否产生网络流量
>* 表示层: 传输前是否进行加秘，压缩（开发人员决定）
>* 表示层的trick: 比如发送端、接收端的编码不一致导致的乱码问题就属于表示层的问题
>* 会话层: 可以查木马（后台进行），命令：netstat -nb
>* 传输层: 可靠传输、流量控制、不可靠传输
>* 网络层: 选择最佳路径，也可通过静态路由实现人工选择
>* 数据链路层: 定义数据帧的“开始”和“结束”，交换机看到“开始”和“结束”后可以正确的接收数据
>* 数据链路层: 透明传输、差错校验(不纠错，错了直接扔掉)
>* 物理层: 定义了网路设备的接口标准, 规定了电器标准
>* IPv4与IPv6的使用只是影响网络层的变化，每一层的变化不会影响其他层
>* MAC地址冲突, ADSL欠费, 网速没办法协商一致都属于数据链路层的问题
>* 网络排错：由底层到高层
>* ping，确定网络层有没有问题

网络安全

>* 数据链路层安全：ADSL，帐号密码，VLAN，交换机端口绑定MAC地址
>* 网络层安全：在路由器上使用ACL控制数据包流量
>* 应用层安全：开发的应用程序没漏洞

TCP/IP协议

>* 对OSI进行了简化

性能指标

>* 速率/bit rate: 主机在数字信道上传输数据___位数___的速率, 衡量数据传输的速度
>* 每一个通信都有一个信道，不同的信道，不同的速率
>* 带宽: 信道所支持的最大传输速率
>* 吞吐量: 单位时间内通过某个网络的总的数据量
>* 延时/时延: 发送时延(这个数据离开计算机的时间), 传播时延, 排队时延(等待处理), 处理时延（选择出口）, 排队时延(出口处排队), 传播时延.
>* 有多少数据在线路上：带宽x时延
>* RTT: 从发送方发送数据开始到发送方收到接收方确认
>* 利用率: 利用率越高，时延越高

物理层

position_c: 物理层


### Review:

xxx

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2018/06/today/) 
