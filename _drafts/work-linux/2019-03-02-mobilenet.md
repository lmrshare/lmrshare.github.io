---
layout: post
title: <font color="ff0000">mobilenet notes</font>
date: 2019-03-02
description: "notes"
tag: Domain Knowledge
---

我在博文[deep learning tutorial notes](https://lmrshare.github.io/2019/01/deeplearningbooknotes/)提到深度可分离卷积(depthwise separable convolution)的应用较为普遍, 比如在MobileNet和Xception. 本文是针对mobilenet做的一篇笔记.

### 目录

* [Chapter 9. Convolutional Networks](#cnn)
* [Reference](#reference)

### <a name="cnn"></a>Chapter 9. Convolutional Networks

首先, 描述什么是卷积, 然后解释在神经网络里使用卷积的动机; 接着介绍pooling, 这是几乎所有卷积网络都会用到的操作, 通常情况下, 卷积网络中的pooling与工程或数学中的卷积定义是不一致的, 进而详细介绍卷积与pooling的关系;

#### ___1. xx是什么:___

卷积: 对其中一个函数做mirror, 然后平移t后与另一个函数相乘后做积分. 在实际应用场景, 我们处理的往往是离散信号, 因此积分要换成求和, 此外, filter往往是带限信号, 通过这种方式可以利用finite个元素的和实现infinite summation.

卷积定义中之所以要对其中一个函数翻转是为了使卷积具有 __交换律__. 这个性质可以通过画图来说明, 做法提醒: 分别翻转函数后又移, 与之做对比的做法为不翻转函数直接做右移. 另外, 与卷积相似的一个操作是互相关(cross-correlation), 该函数没有翻转而是直接右移(官方定义为左移第一个函数). 值得注意的是: 很多机器学习库将互相关叫做卷积. 在本文, 我们按照惯例也将卷积和互相关都称作卷积, 而在具体使用中明确声明是否对kernel进行翻转. 二者的区别如图所示:

<div align="center">
	<img src="/images/posts/deep-learning-booknotes/con-cros-corre.png" height="300" width="600">
</div>

$$Convolution\ and\ Cross-correlation(源于wiki\ convolution)$$

### <a name="reference"></a>Reference

- [1. deeplearning](http://www.deeplearningbook.org/)

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
