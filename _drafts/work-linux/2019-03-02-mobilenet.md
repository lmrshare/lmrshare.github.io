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

#### ___1. Introduction___

+ 为了提高精度, 现在普遍的趋势是构建越来越复杂越来越深的网络
+ 本文提出一个有效的网络结构, 同时提出两个超参数来构建小模型, 从而使其更容易的应用到手机或者嵌入式视觉应用
+ section2回顾了关于构建小模型的历史工作; section3描述了本文的工作: 网络结构、两个超参: 宽度乘子和分辨率乘子; section4是对比实验; section5是总结和讨论

#### ___2. Prior Work___

+ [16, 34, 12, 36, 22]这是近几年构建小而有效神经网络模型的工作, 这些工作主要分为两类: 1. 压缩已有模型; 2. 直接训练小模型
+ 本文提出一类神经网络结构, 可以让开发人员专门为具体的应用选择小模型
+ MobileNets除了focus小网络外, 还focus应用的latency; 而其他小模型工作仅仅focus大小而不考虑速度
+ MobileNets主要是基于深度可分离卷积构建的模型, 深度可分离卷积最开始应用在工作[26], 接着应用在inception模型[13]减少了前几层的计算量.
+ Flattened网络[16]利用filter分解卷积构建网络; 后来, Xception网络[3]通过增加深度可分离卷积超过了Inception V3网络; 另外, Squeezenet[12]利用瓶颈策略设计了一个非常小的模型; 其他减小计算量的网络包括: structured transform networks[28]和deep fried convnets[37]
+ 另外, 一个不同的获取小模型的策略是: shrinking, factorizing或compressing pretrained网络; 压缩的方式常利用到: 乘机量化(product quantization)[36], hashing[2], pruning, 矢量量化和Huffman coding[5]
+ 利用各种factorization对pretrained 网络进行加速的工作有[14, 20];
+ 还有一个训练小模型的方法是蒸馏(distillation)[9], 蒸馏使用大昂落来训练小网络
+ 另外一个工程策略是low bit网络[4, 22, 11]

### <a name="reference"></a>Reference

Preparing the datasets, Downloading and converting to TFRecord format, Pre-trained Models, Training a model from scratch, Fine-tuning a model from an existing checkpoint(undone, 下次从An automated script for processing ImageNet data开始)

- [[1] TensorFlow-Slim image classification model library](https://github.com/tensorflow/models/tree/master/research/slim)


<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
