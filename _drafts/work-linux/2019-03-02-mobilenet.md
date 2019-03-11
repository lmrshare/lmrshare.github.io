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

#### ___3. MobileNet Architecture___

首先介绍MobileNet的核心layer, 即深度可分离卷积(depth separable convolution), 然后介绍MobileNet的网络结构, 最后介绍MobileNet的两个超参数: width multiplier和resolution multiplier.

__3.1 Depthwise Separable Convolution(DSC)__

+ DSC: 将标准的卷积分解成, 深度卷积和1x1的pointwise卷积. 具体的工作原理为, 先对input的每一个通道单独进行卷积(depthwise卷积), 然后对这些通道输出做1x1的pointwise卷积, 得到最终的卷积结果. DSC的这种工作方式可以有效的减少计算量以及模型大小
+ Figure 2显示了DSC的工作原理: 2(a)是标准卷积, 2(b)是depthwise卷积, 2(c)是1x1pointwise卷积

<div align="center">
	<img src="/images/drafts/mobilenet/figure2.png" height="500" width="300">
</div>

$$Figure2\ DSC的工作原理(图片源自MobileNet论文)$$

__3.2 Network Structure and Training__

网络结构

+ Network Structure: 第一层是full convolution, 然后接batchnorm[13]和ReLU; 中间层是, depthwise卷积+BN+ReLU+1x1卷积+BN+ReLU; 最后是, average pooling+全连接层+softmax层
+ 在第一层的full卷积和其他层的深度可分离中的depthwise卷积, 通过stride为2实现下采样
+ average pooling使空间分辨率为1

MobileNest的计算特点

+ MobileNets中几乎所有的计算时间都集中在1x1卷积(差不多95%的计算时间), 而1x1卷积可以通过高效的矩阵乘法(general matrix multiply, GEMM)实现.
+ 通常为了用GEMM, 首先要在内存中做im2col(caffe就是这样做的), 而1x1卷积不需要im2col, 直接可以用GEMM
+ MobileNets的参数中, 差不多75%的参数是1x1卷积参数, 剩余的参数差不多都是全连接层的

训练

+ MobileNets与Inception V3类似使用RMSprop来训练
+ 与训练大模型相反, 训练MobileNets这样的小模型比较少的使用正则化和数据扩充技术, 因为小模型比较不容易出现overfitting

__3.3 Width Multiplier: Thinner Models__

+ 这个参数就是调节输入和输出通道个数的, $\alpha$. 比如, 原来的input有M个通道, 超参控制后为$\alpha M$, 同样的output的通道变成$\alpha N$.$\alpha = 1$就是baseline MobileNet, $\alpha < 1$是reduced MobileNet

__3.4 Resolution Multiplier: Reduced Representation__

+ 将该超参数$\rho$设置在输入图像上, 这样网络每一层输出的空间分辨率都会降低. 通过设置输入图像的分辨率而隐式设置$\rho$(简单理解就是图像弄小点)

#### ___4. Experiments___

+ a. 深度可分离卷积同常规卷积的对比
+ b. 参数实验: width multiplier和Resolution multiplier
+ c. MobileNets同popular models的对比
+ d. MobileNets在不同applications上的应用

__4.1 Model Choices__

+ Table4为常规卷积MobileNet和深度可分离卷积MobileNet的对比实验, 结果表明: 在精度损失一个百分点的前提下, 参数量以及乘加运算次数都减少了很多
+ Table5为width参数控制的瘦模型和浅层模型的对比, 结果表明: 在相似的计算量以及参数的前提下, 瘦网络表现的比浅层网络好

__4.2. Model Shrinking Hyperparameters__

+ Table 6为width multiplier$\alpha$参数实验, 具体显示了模型压缩与参数量和计算量的关系
+ Table 7为resolution multiplier参数实验, 具体显示了由不同分辨率图像训练的不同大小的模型与参数量和计算量的关系
+ 图4显示了计算量与精度之间的关系, 有一点要注意: 这里用到的16个模型由两个参数控制: width multiplier和resolution multiplier, 并遵循单变量控制原则
+ 图5显示了参数量与精度之间的关系, 有一点要注意: 该实验用到的模型同图4的模型获取方式是一样的, 另外, 不能说模型就是一样的
+ <font color="ff0000">对于图4和图5我有一个疑问, 为什么图4的结果没有呈现出图5的特点</font>
+ Table 8为full MobileNet与GoogleNet和VGG16的对比实验, MobileNet的精度与VGG16精度相当, 但参数量与计算量均呈现1个数量级的减小; 对比GoogleNet优势更为明显, 无论参数、参数量还是计算量均有提升. 当然, 这只是作者的说法, 从表中精度数据来看并没有他说的那样
+ Table 9为reduced MobileNet同Squeezenet和AlexNet的对比实验, 从表中数据来看, 结果确实明显好于对比模型

__4.3. Fine Grained Recognition__

+ 基于Stanford Dogs Datasets的细粒度识别实验, 实验结果如Table 10. 训练: 根据一定的方法构造一个数据集, 根据该数据集预训练一个模型, 然后, 利用Stanford Dogs对模型进行fine tune

__4.4. Large Scale Geolocalizaton__

+ 定位图片地理位置的任务, 对比方法为PlaNet(基于Inception V3体系结构)和Im2GPS, 作者根据MobileNet体系结构训练了PlaNet

__4.5. Face Attributes__

+ [9]阐述了MobileNet同distillation之间的关系
+ 用MobileNet压缩人脸属性分类任务中的大模型, 即: 用MobileNet结构来蒸馏一个人脸分类器
+ Distillation是这样工作的: 训练一个模型以模拟仿真目标大模型, 也就是说ground-truth是目标大模型的输出

__4.6. Object Detection__

+ 用MobileNet做目标检测, 目标数据集为COCO dataset, 对比方法为: VGG, 基于Faster-RCNN和SSD框架的Inception V2

__4.7. Face Embeddings__

+ 目前[25]的FaceNet是state of the art的人脸识别模型, FaceNet使用trplet loss来构建face embeddings
+ 作者使用distilation来训练MobileNet(minimizing同FaceNet之间的loss)

#### ___5. Conclusion___

作者基于深度可分离卷积提出了新的模型体系, MobileNet. 在经过对现有的一些重要设计原则后, 作者阐述了如何通过width multipier和resolution multipiler在牺牲一定精度的前提下来训练又小又快的模型. 然后, 作者同popular model做了对比实验, 此外, 又展示了MobileNets在众多应用中的表现. 作者的下一步工作是在tensorflow中将MobileNet发布出来.

#### ___6. 待办___

+ <font color="ff0000">3节里的模型部分仔细看一下, 在算一下, 把超参数部分也算一下</font>

### <a name="reference"></a>Reference

Preparing the datasets, Downloading and converting to TFRecord format, Pre-trained Models, Training a model from scratch, Fine-tuning a model from an existing checkpoint(undone, 下次从An automated script for processing ImageNet data开始)

- [[1] TensorFlow-Slim image classification model library](https://github.com/tensorflow/models/tree/master/research/slim)


<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
