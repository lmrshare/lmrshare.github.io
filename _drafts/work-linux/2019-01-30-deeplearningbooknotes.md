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

卷积: 对其中一个函数做mirror, 然后平移t后与另一个函数相乘后做积分. 在实际应用场景, 我们处理的往往是离散信号, 因此积分要换成求和, 此外, filter往往是带限信号, 通过这种方式可以利用finite个元素的和实现infinite summation.

卷积定义中之所以要对其中一个函数翻转是为了使卷积具有 __交换律__. 这个性质可以通过画图来说明, 做法提醒: 分别翻转函数后又移, 与之做对比的做法为不翻转函数直接做右移. 另外, 与卷积相似的一个操作是互相关(cross-correlation), 该函数没有翻转而是直接右移(官方定义为左移第一个函数). 值得注意的是: 很多机器学习库将互相关叫做卷积. 在本文, 我们按照惯例也将卷积和互相关都称作卷积, 而在具体使用中明确声明是否对kernel进行翻转.

离散卷积可以看成矩阵乘法, 只不过矩阵里的元素可以经变化而等于其他元素(shift). 以一维信号卷积为例, 由卷积核构成的矩阵的特点为: 上一行元素做一次shift后等于下一行元素(该矩阵叫做Toeplitz matrix).

#### ___2. 动机:___

卷积通过三个重要的idea来改变机器学习系统: sparse interactions, parameter sharing, equivariant representations.

sparse interactions描述的是每个output unit和所有的input units之间的关系, 这个关系又叫做sparse connectivity or sparse weights.
sparse interactions的好处是可以缩减模型的存储需求同时改善模型的统计有效性(statistic efficiency). 此外, sparse interactions也意味着
计算输出需要更少的操作. sparse connectivity与matrix-multiplication connectivity的区别: 1). 前者的每一个input unit会影响部分output units(稀疏度决定或者说kernel size决定), 后者的每一个input unit会影响所有的output units;
2). 前者的每一个output unit(ou)受部分iunput units(这部分units叫做ou的感受域--receptive field)的影响, 后者的output unit受到所有input units的影响;
3). 在卷积网络中深层的感受域要比浅层的感受域大, 这意味着, 在卷积网络中即使direct连接是sparse的, 但是深层次的in-direct却具有很大的覆盖范围.

在传统的神经网络中, 参数矩阵中的每一个参数都只用了一次; 在卷积网络中, 使用了parameter sharing, 也称作tied weights(即同一个weight paramter在使用时值是相同的). 对于描述同一个线性关系, 由于卷积的parameter sharing性质, 相较于传统的矩阵相乘会非常的节省空间以及减少计算量.
卷积的参数共享使层具有平移同变性的特点(equivariance to translation). 所谓的同变意味着: 输入改变, 输出以同样的方式改变. 具体来说, 如果满足$f(g(.)) = g(f(.))$, 那么函数$f(.)$对于另一个函数$g(.)$是同变的. 以卷积为例, 让$g(.)$代表对变量的shift, 那么卷积函数对于$g(.)$来说是同变的. 套用同变的定义的解释可以这样描述:
对input先做shift后做卷积, 等价于对input先做卷积再做shift. 参数共享的好处之一是可以检测同一模式(eg: 同样的边缘可能在一副图像上出现多次, 而parameter sharing可以保证这个边缘特征多次同变出现). 卷积对于尺度获旋转不具有同变性.

#### ___3. pooling:___

卷积层主要包含三个阶段: 阶段一: 并行的执行几个卷积; 阶段二: 非线性化, 即每个output unit经过activation function, 这个阶段也叫做detector stage; 阶段三: 使用pooling函数修改输出, 如: max pooling.
pooling的作用是: 对于小的input变化具有不变性(invariant), 换句话说, 对input做一个小的平移, pooling后的结果保持不变. 如果我们关心的是某些特征是否存在而不是它的确切位置, 那么不变性这个性质就尤为重要.
从另一个角度来看, 不变性在一定程度上可以维持特征的位置.

使用pooling相当于使用了这样的先验知识: 如果layer学到的function对于small translation具有不变性. 假如这个假设成立, 那么pooling可以改善网络的统计有效性(statistic efficiency).
除了直接在空间域使用pooling, 还可以在多通道之间使用pooling, 从而学习对输入的其他变换的不变性(如: 旋转不变性). 另外, pooling的好处还可以减小计算量.

pooling对解决许多任务中的尺寸各异的input问题都是必要的, 以分类尺寸各异的图片为例: 在分类层, 我们一定要提供一个固定尺寸的input以供分类, 这通常要通过动态pooling的方式做到(调节pooling region之间的offset). 这就涉及到了如下几个话题:

+ 在不同的情形如何选择不同的pooling(<font color="ff0000">Boureau et al., 2010</font>)
+ 如何动态的pool feature together, eg: 将聚类算法应用在感兴趣的特征(<font color="ff0000">Boureau et al., 2011</font>), 学习一个单一的pool 结构, 然后应用到所有图像上(<font color="ff0000">Jia et al., 2012</font>)

pooling可以使一些利用了top-down信息的神经网络结构(如: Boltzmann machines或autoencoders)变得复杂, 这些话题会在 <font color="ff0000">part III中讨论, 在20.6中讨论如何poolingconvolutional Boltzmann machines; 20.10.6讨论了一些可微网络所需要的逆pooling操作(在pooling unit上执行inverse-like operation).</font>
图9.11讨论了几个使用了卷积和pooling的卷积网络结构.

<div align="center">
	<img src="/images/drafts/deep-learning-booknotes/3cnn-structures.png" height="300" width="600">
</div>

$$图9.11 几个cnn结构(源于deep\ learning教材)$$

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
