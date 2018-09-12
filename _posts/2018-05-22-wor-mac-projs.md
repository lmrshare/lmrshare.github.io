---
layout: post
title: "还没处理完-工程相关"
date: 2018-05-01
description: "有空学一下自己列的这些项目"
tag: Projs
---

### 1. GCDAsyncSocket 源码(undone)

source code dir=`/Users/linmengran/work/ios/xuyaohui/CocoaAsyncSocketTip-master/CocoaSyncSocket/Pods/Pods.xcodeproj`

黏包、断包处理实例=`/Users/linmengran/work/ios/xuyaohui/IM_PacketHandle-master`

testReplayKit2/GCDAsyncSocketManager-master---我的ipc层主要参考了这个, 这是对AsyncSocket proj的一个封装

先练习一下抓包技能:

先关联设备:

    rvictl -s uuid

再启动wireshark:

    sudo su
    wireshark &
此外, 显示设备：

    rvictl -l

关闭设备：

    rvictl -x uuid

退出超级管理员：

    exit

直接关掉wireshark重来会出问题，所以我就用了下面的命令来管理wireshark

查看进程(linux):

    linmengran$: ps -ef | grep wireshark
    0 37696 13351   0  9:38下午 ttys004    0:00.02 sudo wireshark
    0 37702 37696   0  9:38下午 ttys004    0:08.11 /Applications/Wireshark.app/Contents/Resources/bin/wireshark-bin
    501 39068 13351   0  9:41下午 ttys004    0:00.00 grep wireshark

kill掉这些进程:

    linmengran$: sudo kill -9 37696 37702 39068

上面这些命令可以保证我正常的使用工具

position: 接下来的任务就是google"wireshark 微信抓包"

### 2. Web_rtc proj 源码(undone)

P2P连接的特点：数据通道一旦形成，中间是不经过服务端的，数据直接从一个客户端流向另一个客户端。

    注意：WebRTC虽然提供了P2P的通信，但并不意味着WebRTC不需要服务器。至少有两件事必须要要用到服务器：
    1. 浏览器之间交换建立通信的元数据(信令)必须要通过服务器。
    2. 为了穿越NAT和防火墙。

NAT:

    关于这部分内容先说下结论吧："主动发包的一方被知晓(包括IP/Port，发送方的NAT), 主动方可收包(突破主动方的NAT)"

WebRTC就是根据这一结论，突破的NAT限制，做法是：

    两端同时向一个公网服务器发包，然后公网向这两端发对端的IP/port, 这样这两端就突破了NAT限制

position

task:

>* 1. IOS下WebRTC环境搭建：
>* 2. NAT实现
>* 3. ICE协议框架
>* 4. [WebRTC protocols](https://developer.mozilla.org/zh-CN/docs/Web/API/WebRTC_API/Protocols)
>* 5. google "wireshark抓VoIP"

#### ref

- [1. 下载源码、编译](https://www.jianshu.com/p/64bd7f5b18b1)
- [2. WebRTC protocols](https://developer.mozilla.org/zh-CN/docs/Web/API/WebRTC_API/Protocols)
- [3. ios下音视频通信-基于WebRTC](https://www.jianshu.com/p/c49da1d93df4)

### 3. 多线程(undone)

在项目`/Users/linmengran/work/ios/code_backup/delegate_test/delegate_test.xcodeproj` 练习。我把`NSoperation`之前的撸完了。

#### ref

- [1. 多线程调试技巧](https://www.jianshu.com/p/35a3181aa1f8)

### 4. TCP、心跳(undone)

心跳：客户端每隔一段时间向服务端发送自定义指令，以判断双方是否存活。(undone)

position

>* 1. google: "TCP的KeepAlive无法替代应用层的心跳保活机制--连接活着但业务已死"

### 6. MRC与ARC(undone)

position 

>* 1. 引用计数器操作

#### ref

- [1. MRC and ARC](https://www.jianshu.com/p/48665652e4e4)

### 7. 堆对象、栈对象(undone)

>* 1. 代码区-就是可执行文件的内存镜像，白话来说就是把二进制码怼到内存里
>* 2. 数据区、BSS区-两者的区别就是初始化和未初始化, 我的疑问就是：既然都是全局变量和静态变量为什么还要单独区分？是为了检索效率
>* 3. 常量区-和代码区、数据区的区别就是：常和变的区别。注意：static标识的放在数据区
>* 4. 堆-动态分配的
>* 5. 栈-局部变量、函数参数。注意：函数被调用时再把参数压入调用的进程栈中，白话来说就是谁调用了谁就再压一遍。

position

>* 6. 为什么用栈，因为方便恢复现场。那么为什么栈容易恢复现场？(undone)

#### ref

- [1. 堆和栈](https://www.jianshu.com/p/746c747e7e00)

### 8. GCD(undone)

#### ref

-[1. GCD](https://github.com/ming1016/study/wiki/%E7%BB%86%E8%AF%B4GCD%EF%BC%88Grand-Central-Dispatch%EF%BC%89%E5%A6%82%E4%BD%95%E7%94%A8)[undone]

### 9. The Chromium Projects(undone)

position

>* 1. 成功编译ios工程

#### ref

- [1. chromium](https://www.chromium.org/developers/design-documents)
- [2. Checking out and building Chromium for iOS](https://chromium.googlesource.com/chromium/src/+/master/docs/ios/build_instructions.md)
- [3. High-level architecture Chromium](https://www.chromium.org/developers/design-documents/multi-process-architecture)
- [4. Chromium基础库说明](https://www.zybuluo.com/rogeryi/note/56894)

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
