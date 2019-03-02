---
layout: post
title: <font color="ff0000">mobilenet notes</font>
date: 2019-03-02
description: "notes"
tag: Domain Knowledge
---

我在博文[deep learning tutorial notes](https://lmrshare.github.io/2019/01/deeplearningbooknotes/)提到深度可分离卷积(depthwise separable convolution)的应用较为普遍, 比如在MobileNet和Xception. 本文是针对mobilenet做的一篇笔记.

### 目录

* [Paper notes](#paper-notes)
* [Reference](#reference)

### <a name="paper-notes"></a>Paper notes

#### ___Abstract___

+ 使用深度可分离卷积来建立轻量级深度神经网络
+ 引入两个全局超参: 使应用人员根据不同的问题而选择不同大小的模型
+ 通过大量的应用: object detection、 finegrain classification、 face attributes and large scale geo-localization来验证mobilenet的性能

#### ___Introduction___

+ 为了提高精度, 现在普遍的趋势是构建越来越复杂越来越深的网络
+ 本文提出一个有效的网络结构, 同时提出两个超参数来构建小模型, 从而使其更容易的应用到手机或者嵌入式视觉应用
+ section2回顾了关于构建小模型的历史工作; section3描述了本文的工作: 网络结构、两个超参: 宽度乘子和分辨率乘子; section4是对比实验; section5是总结和讨论

### <a name="reference"></a>Reference

- [1. deeplearning](http://www.deeplearningbook.org/)

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
