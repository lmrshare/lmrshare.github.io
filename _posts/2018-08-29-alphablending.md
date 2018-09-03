---
layout: post
title: "Alpha-blending"
date: 2018-08-29 
description: "工作中的一个需求, 顺便记下来."
tag: Projs
---

&emsp;&emsp;工作中需要Alpha-blending这个工作, 了解原理后顺便写个帖子加深印象. 

#### 问题描述

&emsp;&emsp;就是把具有透明背景的图片贴到另外一张图片上. alpha通道决定了透明度, 称之为alpha mask. 理论部分很简单, 即: $I = \alpha F +(1 - \lapha) B$. 所以这个没什么好研究的, 接下来我描述我的问题, 并用前面的理论来解决我的问题.


<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2018/06/today/) 
