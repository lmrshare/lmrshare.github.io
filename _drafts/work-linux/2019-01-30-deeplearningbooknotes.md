---
layout: post
title: <font color="ff0000">deep learning tutorial notes</font>
date: 2019-01-30
description: "notes"
tag: Domain Knowledge
---

教材<<[deeplearning](http://www.deeplearningbook.org/)>>的读书笔记.

### 目录

* [Chapter 9. Convolutional Networks](#cnn)

### <a name="cnn"></a>Chapter 9. Convolutional Networks

首先, 描述什么是卷积, 然后解释在神经网络里使用卷积的动机; 接着介绍pooling, 这是几乎所有卷积网络都会用到的操作, 通常情况下, 卷积网络中的pooling与工程或数学中的卷积定义是不一致的, 进而详细介绍卷积与pooling的关系;
然后, 介绍卷积函数的几个变体以及怎样利用卷积来处理具有不同数据维度的数据; 最后, 介绍几个可以使卷积操作高效运行的几个算法以及卷积网络的神经系统解释和深度学习的一些历史. 另外, 本文没有介绍如何选择合适的卷积网络结构, 而是主要致力于介绍卷积网络所具备的能力.

#### ___1. 卷积是什么:___

卷积: 其中一个函数做mirror, 然后平移t后与另一个函数相乘后做积分. 在实际应用场景, 我们处理的往往是离散信号, 因此积分要换成求和, 此外, filter往往是带限信号, 通过这种方式可以利用finite个元素的和实现infinite summation.

卷积定义中之所以要对其中一个函数翻转是为了使卷积具有 __交换律__. 这个性质可以通过画图来说明, 做法提醒: 分别翻转函数后又移, 与之做对比的做法为不翻转函数直接做右移. 另外, 与卷积相似的一个操作是互相关(cross-correlation), 该函数没有翻转而是直接右移(官方定义为左移第一个函数). 值得注意的是: 很多机器学习库将互相关叫做卷积. 在本文, 我们按照惯例也将卷积和互相关都称作卷积, 而在具体使用中明确声明是否对kernel进行翻转.

离散卷积可以看成矩阵乘法, 只不过矩阵里的元素可以经变化而等于其他元素(shift). 以一维信号卷积为例, 由卷积核构成的矩阵的特点为: 上一行元素做一次shift后等于下一行元素(该矩阵叫做Toeplitz matrix).

#### ___2. 动机:___

卷积通过三个重要的idea来改变机器学习系统: sparse interactions, parameter sharing, equivariant representations.

sparse interactions描述的是每个output unit和所有的input units之间的关系, 这个关系又叫做sparse connectivity or sparse weights.
sparse interactions的好处是可以缩减模型的存储需求同时改善模型的统计有效性(statistic efficiency). 此外, sparse interactions也意味着
计算输出需要更少的操作.

#### ___3. pooling:___



#### ___4. 卷积和pooling:___



#### ___5. 卷积函数的几个变体:___



#### ___6. 利用卷积来处理具有不同数据维度的数据:___

+ structured outputs

+ data types

#### ___7. 几个高效的卷积算法:___

making convolution efficient

+ random or unsupervised features

#### ___8. cnn的神经系统解释:___



#### ___9. cnn与深度学习历史:___

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
