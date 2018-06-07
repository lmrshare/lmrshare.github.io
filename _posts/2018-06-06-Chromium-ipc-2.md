---
layout: post
title: "Notes of Chromium project-IPC(2)"
date: 2018-06-06 
description: "[Inter-process Communication(IPC)](https://www.chromium.org/developers/design-documents/inter-process-communication) 的笔记, 主要是翻译整理."
tag: Projs
---

### Wed Jun  6 15:17:49 CST 2018

Chromium利用异步管道(asynchronous pipe)来实现IPC, asynchronous的方式确保了两端不等待对端。

#### IPC in the browser

在Browser中,和Renderer的通信是通过一个单独的I/O线程完成的. 主线程发送到Renderer中的view的消息是通过ChannelProxy发出的，同样的从view发出的消息也要通过代理ChannelProxy发送到主线程. 这种由单独的一个I/O线程来捕获消息的方式主要是为了防止阻塞UI. 

Brower中的主线程通过RenderProcessHost在Channel中插入ChannelProxy:MessageFilter, 这个filter运行在I/O线程中可以拦截资源请求消息, 然后将其转发到ResourceDispatcherHost.

#### IPC in the renderer

每个Renderer也有一个专门负责通信的线程(主线程), 然后渲染和其他处理操作在另外一个线程. 从Browser发到Webkit的消息要经由Renderer中的主线程, 反之亦然.

#### Messages

两个主要的消息类型: routed、control.

eg:

>* control: 请求资源或修改剪贴板(与view无关的)
>* routed: 请求view渲染一块区域

简介几种消息:


>* ___View message___ : 发送给RenderView的消息(Browser ---> Renderer)
>* ___ViewHost message___ : 发送给RenderViewHost的消息(Renderer ---> Browser)
>* ___Frame message___ : 发送给RenderFrame的消息(Browser ---> Renderer)
>* ___FrameHost message___ : 发送给RenderFrameHost的消息(Renderer ---> Browser)
>* ___PluginProcess message___ : 发送给PluginProcess的消息(Browser ---> plugin process)
>* ___PluginProcessHost message___ : 发送给PluginProcessHost的消息(plugin process ---> Browser)

#### 消息声明、消息发送、消息捕获:

##### 1. 声明

>* 从Renderer到Browserer的routed消息:

    IPC_MESSAGE_ROUTED2(FrameHostMsg_MyMessage, GURL, int)

>* 从Browser到Renderer的control消息:

    IPC_MESSAGE_CONTROL0(FrameMsg_MyMessage)d

注意: `ipc_message_utils.h`,`navigation_params.h` `frame_messages.h`这是与消息序列化相关的文件.

##### 2. 发送

通过channel发送消息. 比如在RenderProcessHost中就包含channel, 这个channel可以把来自于Browser中的UI线程的消息发送给Renderer.

在RenderWidgetHost(为RenderViewHost的基类)中有更为方便的消息发送方式: 即通过Send函数.eg:

    Send(new ViewMsg_StopFinding(routing_id_));

这里之所以要routing id, 是因为只有这样才可以找到正确的View/ViewHost, 然而我的应用没这个需求.

##### 3. 捕获

通过实现IPC::Listener接口来捕获消息, 其中最重要的函数就是`OnMessageReceived`

#### Channels

IPC:Channel定义了基于pipe的交互方法:

>* IPC:SyncChannel: 同步等待对某些消息的相应(Browser不会用这个方法, Renderer会在"Synchronous messages"用到该方法)

#### synchronous messages

站在Renderer的角度,  有些消息是要同步的. 比如webkit中的拼写检查和js的cookies, 这些应用的特点是: "发出一个请求后是需要应答的".

eg:

webkit发出一个同步类型的IPC请求后, 该请求通过IPC:SyncChannel分发到Renderer中的主线程中的SyncChannel, (这个步骤发送异步消息也是如此), SyncChannel接到这个消息后会阻塞webkit直至SyncChannel接受到一个应答消息后再解除对webkit线程的阻塞.

在webkit阻塞过程中(也就是等待同步消息应答), renderer中的主线程会收到webkit需要处理的消息, 这个时候就需要把这些消息放到webkit的消息队列理, 在webkit线程unlock之后再以此处理这些消息, 可见同步消息的处理是无序的(out-of-order).

同步消息和异步消息使用同样的`IPC_MESSAGE_HANDLER`

### 小结

初步把Chromium的IPC理了一遍, 接下来回到[Chromium官方文档的开始部分](https://www.chromium.org/developers/design-documents)继续整理.


<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2018/06/today/) 
