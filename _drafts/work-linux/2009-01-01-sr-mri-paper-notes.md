---
layout: post
title: <font color="ff0000">sr-mri-paper-notes</font>
date: 2009-01-01
description: "还没处理"
tag: Projs
---

* [inverse-problem](#ip)
* [传统的核磁共振成像方法---MRI](#review-mri)
* [深度级联CNN在动态核磁共振成像上的应用---DCCNN-DMRI](#dc-cnn-dmri)
* [传统的超分辨率方法---SR](#review-sr)
* [CNN在超分辨率上的应用---CNN=SR](#cnn-sr)
* [MRI与SR问题的异同](#mrisr-compare)
* [总结](#review)

### <a name="dc-cnn-dmri"></a>深度级联CNN在动态核磁共振成像上的应用---DCCNN-DMRI

&emsp;&emsp;记得在学校的时候听过一个关于深度学习的讲座, 我导师问了关于深度学习如何在小样本数据集上应用的问题, 那会听到的回答就是: 深度学习不太适用于小样本数据集, 所以当时就没深入思考深度学习如何应用于核磁共振成像(MRI). 最近无意间查到了几篇深度学习解决MRI问题的论文, 比较感兴趣, 就看了下, 顺带着把读书的时候做过的MRI问题涉及的经典方法复习一遍.

&emsp;&emsp;核磁共振成像领域里主要的挑战就是如何在不满足奈奎斯特香侬采样定理的情况下利用欠采样的k空间数据重建出没有aliasing现象的图像, 近些年, 无论是静态成像还是动态成像基本都围绕压缩感知缝缝补补建立模型. 这个方法牛逼在: 只要满足了
$可压缩性$, $非相干性$, 就可以使aliasing模式类似于噪声. 代表方法有CS-MRI, 这类方法的特点是: 稀疏变换是预定义的, 很自然的, 后面就出现了可以更好的适应数据学习得到的字典, 也就是DL-MRI.

&emsp;&emsp;DCCNN-DMRI使用CNN逐帧进行图像重建, 并且把重建问题看成是一个去aliasing的问题. DCCNN-DMRI与DL-MRI的迭代重建非常类似, 但它是端对端的.

#### Problem Formulation

&emsp;&emsp;初步读了下模型部分, 感觉没什么惊艳的, 初步判定: 在保真度的前提下, 把cnn作为一个约束. 为什么这么约束呢? 如果不解释的话, 那我可以认为只是跑了个实验用一下而已, 继续向后
看吧, 希望可以给出解释, 如果不解释的话, 那就应该着重关注作者的实验, 毕竟deep-learning应用在小数据集还是挺不容易的.

&emsp;&emsp;loss function是比较常规的element-wise squared loss.

#### Data consistency layer

仔细看下这段是怎样将其当作神经网络的一个layer的

>* Since the DC step has a simple expression, we can in fact treat it as a layer operation of the network, which we denote as a DC layer.

#### Cascading Network

>* 一个CNN接着一个CNN, 类似于将DLMRI展开
>* 每个CNN有$n_d - 1$个3D卷积层用以学习时频特征, 然后跟着一个ReLU用以添加非线性; 每个CNN的最后都有个$C_{rec}$用以将前面的feature投射回图像域
>* 对于3D 卷积层, kernel size = 3, number of filters is $n_f = 64$; 对于$C_{rec}$, kernel size = 3, number of filters is $n_f = 2$
>* 第一个CNN还有个data sharing layer

#### Data Sharing Layer

>* 取左右$n_{adj}$帧进行数据共享, 如果这些临域帧在相同的位置均具有采样线, 就取平均值
>* 利用3D卷积学习输入序列的时频特征
>* 训练的时候$n_{adj}$取$0, 1, 2, 3, 4, 5$ 
>* D5-C10(S): $n_d = 5, n_c = 10$, 并且有data sharing
>* D5-C10: $n_d = 5, n_c = 10$, 无data sharing

#### 实验结果

>* 笛卡尔采样
>* 对于核磁共振的小样本数据集问题, 作者是这样做的(Data augmentation): rigid transformation、elastic deformation.
>* 通过rigid transformation, 作者给每张图片扩充了0.3 million的数据.
>* 为了适应动态场景, 作者应用了eastic deformation.
>* 从数据集中抽出一部分作为validation set来进行early-stopping

作者开始做了3:2:5(train:test:validation), 但是发现validataion一点没动, 于是就把validation合到了train set里, 此外, 
为了做dynamic 实验, 作者做了7:3(train:test)的数据分割.

关于$n_d$和$n_c$的trade-off:

>* 作者做了D5-C2和D11-C1的对比实验
>* 前者的曲线里train set和test set的gap更加紧密且均小于后者, 说明前者的泛化能力更好.
>* 即使数据集扩充了, 但还是比较小, 因此神经网络比价容易的over-fit了.
>* 这个对比实验说明了DC的重要性.(回顾face alignment中遇到的问题)

实验中, D5-C2的gap还是比较大(泛化能力不是很好), 另外, 到了$3x10^5$, train set 的性能差不多了, 而test set的mse还在降, 
这说明训练数据集可能不够.


关于cascade参数$n_c$

从作者的实验可以看出: $n_c$越大, 重建性能越好. 这里作者的实验有一点值得讨论:

>* 在训练$n_c = 5$的网络时, 用$n_c = 4$的网络进行初始化.
>* 用一个网络的结果作为初始化可能导致局部最优(这是作者的解释, 我觉得未必, 这个后面试着给出更好的解释)

图7给出的信息:

>* $n_c$变大, 效果有改善
>* 改善率降低, 说明随着$n_c$变大, 网络有overfit的趋势

文中对于CNN和DLMRI的对比, 有一处存疑:

>* 对于6倍下采样, 使用3倍下采样数据训练的网络参数来初始化网络, 那么这样做：1) 还有意义吗 2) 对DLMRI公平吗
>* 从图9对比结果可看出, cnn可以比较好的解决DLMRI的block-like artefacts(over-smoothing)
>* DLMRI和CNN都suffer from significant loss of structures.
>* DLMRI created block-like artefact due to over-smoothing(我当时是从局部全局的角度看待这个问题的)
>* 相对的CNN就没这个问题, 这说明CNN的泛化能力比较好
>* 这也提醒我: 可以从泛化的角度来解释DLMRI的局部稀疏字典的泛化能力相对来说没那么好
>* 既然提到了泛化, 有一个引起我思考的问题: 对于小样本问题, 是否可以结合泛化能力比较好的迁移学习来做呢
>* CNN的训练时间长, 但是预测时间比DLMRI要短

重建速度:

>* inference的时候, cnn是23ms左右一帧(GPU), DLMRI

State of the art(2017):

>* Reconstructing dynamic sequence: DLTG, kt-SLR, L+S

关于本文的训练的一些关键事项:

>* weight decay一直执行到0而没有发生overfitting现象(我觉得数据量小也可能这样)
>* 每个网络的训练: 首先利用混合下采样数据训练出一个网络(这样的网络泛化能力比较好, 但重建肯定精细度不够)
>* 用特定倍数的下采样数据训练精细度比较高的网络

内存:

>* 由网络参数的规模决定
>* 对于2D重建, 且网络规模是D5-C5的情况下, 约有0.6 million个参数(对于单精度浮点数, 大概占据2.3MB的存储空间).
>* 对于动态重建, 且网络规模是D5-C10的情况下, 约有3.4million个参数(大概占据13.6MB的存储空间)

讨论与总结:

>* 尽管CS和low-rank在理论上可以保证信号的重建, 然鹅, 还是被CNN这个没有任何模型解释的约束打败了
>* 小数据集深度学习方法: a.)iterative architecture下, 每个子网都相对较小. b.)数据扩充
>* performed a cross-validation study to ensure that the network can handle unseen data

#### 疑问

这个是怎么推测出来的呢?

>* though we do not have a GPU implementation of DLMRI, it is expected to take longer than 23ms because DLMRI
requires dozens of iterations of dictionary learning and sparse coding steps

#### papers

>* [it has already been demonstrated that CNNs outperform sparsity-based methods in super-resolution in terms of both reconstruction quality and speed](https://arxiv.org/pdf/1501.00092.pdf)
>* [CNNs have already been applied to compressed sensing from random Gaussian measurements](http://www.public.asu.edu/~kkulkar1/reconnet.pdf)

深度学习在MRi上的一些应用:

>* [CNN-based MR image reconstruction1](https://papers.nips.cc/paper/6406-deep-admm-net-for-compressive-sensing-mri.pdf)
>* [CNN-based MR image reconstruction2](unfound:Accelerating magnetic resonance imaging via deep learning)
>* [DCCNN-DMRI](https://github.com/js3611/Deep-MRI-Reconstruction)
>* [mridata](http://mridata.org/)

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/)
