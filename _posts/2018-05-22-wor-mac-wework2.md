---
layout: post
title: "Work Experience 2"
date: 2018-04-30
description: "work experience2 "
tag: Projs
---

### 切分支:

    git checkout -b feature_xxx_demo remotes/origin/feature_xxx_demo
    git show 981734907213409712309847

### `@class`说明

    1. @class只是告诉编译器，其后面声明的名称是类的名称，至于这些类是如何定义的，暂时不用考虑，后面会再告诉你。
    2. 编译效率和循环引用的问题。

`NSTimeInterval _start = [[NSDate date] timeIntervalSinceReferenceDate];`

### git提交代码的时候出的问题:

场景描述：我提代码后把易办的部分代码冲掉了，回忆当时的操作：

    1. git add -u dir
    2. git commit -m '分包'
    3. git stash
    4. git pull --rebase
    5. git push

操作之前我看了下易办的提交，确定第一处改动没问题，我以为代码没冲突，就没管了。然而，事实表明：我的操作把易办第二处改动
冲掉了。至今没想明白这个问题，后面仔细查一下原因。(undone)

此外，提代码的注意事项：

    1. commit前diff一下，确定代码有没有冲突
    2. 如果commit之前没diff, 我一般会在push之后git log，然后git show

### 正确上网:

这次是通过可达的代理来正确上网的, 命令如下:

    $: ssh -L <localport>:remotehost:<remoteport> username@remotehost
    $: export https_proxy=socks4://127.0.0.1:8080
    $: export http_proxy=socks4://127.0.0.1:8080
    $: export ftp_proxy=socks4://127.0.0.1:8080
    $: export ssl_proxy=socks4://127.0.0.1:8080

设置完`https_proxy`后, 浏览器选择socks4之后就可以正确上网了.

### opencv:

>* calib3d: 相机校准，和3D内容相关
>* core: 非常重要, 矩阵操作, 基础数据类型
>* dnn: 神经网络相关
>* feature2d: 图像脚点检测、图像匹配
>* flann: 和聚类相关的、一些临域算法
>* highgui: 界面操作相关的
>* imgcodecs, imgproc: 图像处理相关的
>* ml: 机器学习模块
>* photo:  图片的处理
>* stitching: 图片的拼接
>* position_cyoutubevideo_v1

### tensorflow:

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
