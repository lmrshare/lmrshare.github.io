---
layout: post
title: "前景提取调研(未完成)"
date: 2018-10-15
description: "Foreground Detection"
tag: Research
---

### 目录

* [简介](#abstract)
* [Image or $\alpha$ matting现状](#introduction)
* [图像语义分割方法](#similar)
* [技术方案](#technical)
* [参考文献](#reference)
* [资源](#resource)

### <a name="abstract"></a>简介

经过初步调研, 对于前景提取问题, 主要有两类方法可以解决:1)基于回归的传统方法(image matting);2)基于分类的图像语义分割方法.

#### 关键字

>* A Bayesian Approach to Digital Matting
>* Semantic Segmentation

### <a name="introduction"></a>Image or $\alpha$ matting现状

问题: 求解$\alpha$通道图像的过程, 边缘的透明程度直接反应了最终切割图像细节的丰富程度.

Summary:

|     类别                                  | 关键点                         | 假设                                            |  求解              | 运算时间  |
| ------------                              | ------------------------------ | ----                                            |   ----             |  --- |
| _Bayesian_                                |     _Local color analysis_     | _Color separation, camera quality_              |    _Iterative_     | _~30 secs_  |
| __Poisson__                               | __Image gradients__            |   __Locally smooth foreground and background__  |     __Iterative__  |  __~5 secs__ |
| _Closed Form_                             |     _Image windows_            |   _Locally linear foreground and background_    |      _Direct_      |  _~60 secs_ |

#### ___Bayesian Matting Method___

总结: 需要trimap数据的监督方法, 是一个逐步精细化trimap的过程, 精细化指的是边界$\alpha$. 换句话说: 在极大似然的框架下从trimap出发逐步精细化$\alpha$通道图像的过程.

注意点:

>* 统计方法
>* 极大似然
>* 迭代求解

主要问题:

>* 需要trimap标记数据

#### ___Poisson Matting Method___

总结: 仍然是从trimap出发, 然后根据图像的梯度逐步精细化trimap, 因此这里有个假设: matting图像的梯度和图像梯度类似.

注意点:

>* 迭代求解

主要问题:

>* 需要trimap标记数据

#### ___Closed Form Matting Method___

总结: 与Posisson Matting理论类似, 关键在于将求解部分通过closed-form的方式将迭代求解转换成直接求解.

### <a name="similar"></a>图像语义分割方法

这类方法与前面提到的方法的最大不同是: 语义分割方法将问题转换为一个分类问题, 而前文的方法则是将问题当作回归来处理. 其发展历史可粗略的认为:

|     方法                                  | 概述、存在的问题                     | 
| ------------                              | ------------------------------ | 
| _正则化切_                                |     _基于距离的二义分类方法; 容易将一个物体分成多类_     | 
| __GrabCut__                               | __加了人工干预的二义分类方法; 需要若干个人工干预才可以得到精确的结果__            | 
| _FCN+CRF_                             |     _FCN做特征工程然后喂给CRF做inference_            | 


ps: 二义分类指的是一次只能分两类

### <a name="technical"></a>技术方案

最后一种FCN+CRF是目前主流的方法, 其中FCN的特征工程部分和CRF的推理部分可以并行进行. 后续安排:

+ __1.__ 基于CRF推理模型的传统方法: 理解算法、实现、看效果
+ __2.__ 根据step 1的demo结果决定是否实施FCN特征工程
+ __3.__ 基于回归的方法调研

### <a name="reference"></a>参考文献

___Traditional method(image or $/alpha$ matting):___

- [1. (2017)-Three-layer graph framework with the sumD feature for alpha matting](https://www.sciencedirect.com/science/article/pii/S1077314217301236)
- [2. (2010)-Shared Sampling for Real-Time Alpha Matting](https://pdfs.semanticscholar.org/074e/39a1c533993dcc829d9996c6518608d01e49.pdf)
- [3. (2006-Closed Form)-A Closed Form Solution to Matting](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.478.6701&rep=rep1&type=pdf)
- [4. (2004)-GrabCut](http://pages.cs.wisc.edu/~dyer/cs534-fall11/papers/grabcut-rother.pdf)
- [5. (2004-Posisson)-Poisson Matting](http://www.wisdom.weizmann.ac.il/~vision/courses/2006_2/papers/matting/Sun%20poisson%20matting.pdf)
- [6. (2003)-Digital Matting and Compositing](http://grail.cs.washington.edu/projects/digital-matting/)
- [7. (2002-Bayesian)Video Matting of Complex Scenes](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.164.911&rep=rep1&type=pdf)
- [8. (2001-Bayesian)-A Bayesian Approach to Digital Matting](https://grail.cs.washington.edu/projects/digital-matting/image-matting/)

___Deep learning(image or $/alpha$ matting):___

- [1. 2018-Deep Energy: Using Energy Functions for Unsupervised Training of DNNs](https://arxiv.org/pdf/1805.12355.pdf)

___Image segmentation:___

- [0. (2000-classical method)-Normalized Cuts and Image Segmentation](https://repository.upenn.edu/cgi/viewcontent.cgi?article=1101&context=cis_papers)
- [1. (2011-CRF)-Efficient Inference in Fully Connected CRFs with Gaussian Edge Potentials](http://www.philkr.net/papers/2011-12-01-nips/2011-12-01-nips.pdf)
- [2. FCN和CRF博客](https://zhuanlan.zhihu.com/p/22308032)
- [3. 十分钟看懂图像语义分割技术](https://mp.weixin.qq.com/s?__biz=MzA4ODgxMDY4MA==&mid=2655430607&idx=1&sn=fac0142ff44fac2d466350b922a707b1)
- [4. 基于随机场的图像语义分割](https://blog.csdn.net/step_forward_ML/article/details/80519698)
- [5. 图像语义分割综述](http://ojmhfvae7.bkt.clouddn.com/%E5%9B%BE%E5%83%8F%E8%AF%AD%E4%B9%89%E5%88%86%E5%89%B2%E7%BB%BC%E8%BF%B0.pdf)

### <a name="resource"></a>资源

- [1. image matting](http://www.alphamatting.com)
- [2. 2006-presentation of Digital Matting](http://www.cs.tau.ac.il/~dcor/Graphics/adv-slides/DigitalMatting2.pdf)
- [3. PyDenseCRF](https://github.com/lucasb-eyer/pydensecrf)

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/)
