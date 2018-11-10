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
* [CRF](#technical)
* [待复习](#will-review)
* [参考文献](#reference)

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

#### ___问题描述:___

图像的语义分割是计算机视觉中重要的基本问题之一，其目标是对图像的每个像素点进行分类，将图像分割为若干个视觉上有意义的或感兴趣的区域, 以利于后续的图像分析和视觉理解. 有一点要注意:
语义分割包含了传统的分割和目标识别, 最终的输出是一副具有___逐像素语义___标注的图像. 从抠图应用的角度看待图像语义分割方法, 这类方法与前面提到的方法的最大不同是: 语义分割方法将问题
转换为一个分类问题, 而前文的方法则是将问题当作回归来处理. 问题的难点体现在:

+ __1.__ 光照、视角、距离对算法的干扰
+ __2.__ 类内物体的相异性、类间物体的相似性
+ __3.__ 复杂背景的干扰

#### ___输入数据:___

+ __1.__ 灰度图像与多通道图像
+ __2.__ 单图像语义分割、多图像语义分割

#### ___评价指标:___

+ __1.__ 被正确分类的像素与总像素的比例
+ __2.__ 平均正确率(mean accuracy)、平均交叉率(mean intersection over union)、频率加权交叠率(frequency weighted intersection over union)
+ __3.__ 算法对同场景图像的鲁棒性

#### ___方法分类:___

传统方法:

|     方法                                  | 概述                                                                    |  存在的问题 |
| ------------                              | ------------------------------                                          | ---       |
| _阈值法_                                  |     _根据像素强度的不同设定阈值进行分类_                                |  _像素接近时、出错概率高_   |
| __边缘检测__                              | __边缘检测、连线(Sobel, Canny常用的边缘检测算子)__                     |   __适合梯度明显、噪声小的简单图像; 往往需要在抗噪性与检测精度之间做trade-off__  |
| _主动轮廓模型(ACM)_                       |     _跟人脸对齐的原理一样_                                              |   _需要模式一样的标注数据_     |
| __MRF、CRF__                              |     __计算像素的概率以进行分类__                                          |   __-__     |

ps: 传统方法中CRF通常被选做神经网络模型(做特征工程、提取图像的高阶特征)的后端来做inference工作.

操作模式纬度:

|     方法                                  | 概述、存在的问题                                                        |  操作模式 |
| ------------                              | ------------------------------                                          | ---       |
| _正则化切_                                |     _基于距离的二义分类方法; 容易将一个物体分成多类_                    |  _被动式_   |
| __GrabCut__                               | __加了人工干预的二义分类方法; 需要若干个人工干预才可以得到精确的结果__  |  __交互式__   |
| _FCN+CRF_                                 |     _FCN做特征工程然后喂给CRF做inference_                               |  _交互式_      |


ps: 二义分类指的是一次只能分两类.

### <a name="technical"></a>CRF

最后一种FCN+CRF是目前主流的方法, 其中FCN的特征工程部分和CRF的推理部分可以并行进行. 后续安排:

+ __1.__ 基于CRF推理模型的传统方法: 理解算法、实现、看效果
+ __2.__ 根据step 1的demo结果决定是否实施FCN特征工程
+ __3.__ 基于回归的方法调研

#### 条件随机场(CRF)

+ 图像符合马尔可夫分布
+ 马尔可夫在计算上的复杂性
+ Gibbs模型
+ MRF中变量的联合概率形式又叫做Gibbs distribution
+ Markov Random Field与Gibbs Random Field的等价性
+ CRF本质上是给定了observations的马尔可夫随机场, linear CRF、high-level CRF都是某种特定结构的CRF

#### 随机场

___cheat sheet:___

|     概念                                  | 描述                                                                    |  补充      |
| ------------                              | ------------------------------                                          |   ---    |
| _随机场(Random Field)_                                |     _随机变量的集合_                                                      |   _随机变量对应同一样本空间、随机变量具有依赖关系_    |
| __Markov Random Field(MRF)__                               | __MRF对应一个无向图, 其中随机变量对应节点、边意味着两随机变量间具有概率依赖关系__  |  __图结构反映了先验知识(变量之间的关系); MRF具有临域性质__     |
| _clique-potential_                                |     _clique对应的函数_                                                      |   _具体的问题对clique的定义不同; 用户定义; 用来帮助描述随机变量分布的_    |
| __energy function__                               | __MRF上所有clique-potential之和__  |  __none__     |
| _CRF_                                |     _在MRF基础上, 每个随机变量还有观察值_                                                      |   _条件分布(后验概率)、形式类似于MRF的分布_    |

___训练:___

+ clique-potential由用户自定义的特征函数组成, 其强弱、方向由函数中的参数控制, 而这些参数是通过训练确定的.
+ 图的结构由特征函数的定义确定. 只有一维特征函数, 对应的图没有边.
+ 通过最大log似然准则进行训练: 取log后, 指数没了, 目标函数是凸的, 且梯度具有解析解, 这样可以通过LBFGS(拟牛顿法)进行求解. 该框架下的训练, 每次迭代都要做inference.
+ 为了提高训练速度, 可以采用伪似然来训练, 从而免得在训练过程中做inference, 但这种方法的训练效果比较差.

___推理:___

+ 分类的时候要找出概率最大的一组解.
+ 推断的本质是图模型上的概率推断问题, 对于最简单的线性框架结构可以使用Viterbi.
+ 如果图是树状的, 可采用belief propogation用sum-product得到概率.


#### CRF2

+ 概率图模型:用图论的方法表现数个独立随机变量之间关系的一种建模方法, 两种常见模型为: 有向图模型、无向图模型.
+ 给定观察集合$X=(x_1, x_2, ..., x_n)$后输出集合$Y$实质上是一个MRF, 因此参数化这个条件概率的方法和MRF模型的参数化方法是一样的.
+ Hammersley-Clifford 定理指出：马尔科夫随机场和Gibbs分布是一致的, 这就意味着概率无向图模型的联合概率分布可用Gibbs Distribution来表示.

___viterbi inference:___


+ 跟dijkstra差不多
+ 动态规划算法

#### Linear chain CRF

### <a name="will-review"></a>待复习

+ Graphical Models and Sampling Methods.
+ 最大熵准则下的GIS和IIS求解与最大似然下的LBFGS求解, 取log后本质上应该区别不大.
+ 贝叶斯网络和马尔可夫网络

#### Introduction to crf

+ 由于输出变量间具有依赖关系, 因此, 用Graphical model来表示这种关系就比较自然.
+ 生成模型通常是求联合分布, 而判别模型是求条件分布
+ CRF结合了判别模型和图模型的优势

___Graphical Modeling:___

+ 图模型主要利用local dependency, 这样在求多变量分布的时候可以将其拆分成多个local function的乘积, 其中每个local function依赖一个小的变量子集.
+ Graphical modeling framework的几个关键要素是: factorization、conditional independence、graph structure, 其中, conditional independence 用于独立建模、factorization用于设计inference算法, 另外, 从数学的角度讲factorization可以使分布的表达更高效(变量子集可能比整个变量集小的多).
+ 之所以提到Graphical Model, 是指联合概率分布可以用一个图来表示.
+ 无向图模型: local fucntion没有概率解释.
+ 有向图模型: 将联合概率分布分解成条件概率乘积的形式.
+ 有向图模型与无向图模型的本质区别在于local function的含义差异.

___生成模型与判别模型:___

+ 生成模型: how a label vector __y__ can probabilistically "generate" a feature vector __x__.
+ 判别模型: how a feature vector __x__ can probabilistically "discriminate" a label vector __y__.
+ 理论上, 通过贝叶斯准则, 可以将一个生成模型转换成一个判别模型, 反之亦然.

#### feature engineering

+ Label-observation features: 指定的标签$\tilde{y}_c$才有值, 而特征值完全由输入观测决定(这里的特征值计算可能是文本、图像处理, 也称之为观测函数).
+ Unsupported features: 训练集中出现的错误的特征, 这些特征可能有用, 因为可以给他们一个负权重以阻止错误的标签被赋予高概率.eg, ad hoc技术.
+ Edge-Observation and Node-Observation Features:
+ Boundary labels: 边界处理.
+ Feature Induction: Unsupported feature是穷人版feature induction, eg: L1  regularization.
+ Categorical Features: 对特征进行数值化处理, 如: 二值化、正规化.
+ Features as Backoff: 数据集小的时候采用的一种策略.
+ Features as Model Combination: 将先验知识改成观测函数

#### Efficient Inference in Fully Connected CRFs with Gaussian Edge Potentials

+ 通过mean field approximation来对CRF distribution进行近似: 利用iterative message passing 算法实现近似推理.
+ 关键观察: message passing 可以通过特征空间的高斯滤波近似实现, 这样可以降低message passing的计算复杂度.

### <a name="reference"></a>参考文献

___Traditional method(image or $\alpha$ matting):___

- [1. (2017)-Three-layer graph framework with the sumD feature for alpha matting](https://www.sciencedirect.com/science/article/pii/S1077314217301236)
- [2. (2011-Xiaoou Tang&Jian Sun)-A Global Sampling Method for Alpha Matting](http://mmlab.ie.cuhk.edu.hk/archive/2011/cvpr11matting.pdf)
- [3. (2010)-Shared Sampling for Real-Time Alpha Matting](https://pdfs.semanticscholar.org/074e/39a1c533993dcc829d9996c6518608d01e49.pdf)
- [4. (2006-Closed Form)-A Closed Form Solution to Matting](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.478.6701&rep=rep1&type=pdf)
- [6. (2004-Posisson)-Poisson Matting](http://www.wisdom.weizmann.ac.il/~vision/courses/2006_2/papers/matting/Sun%20poisson%20matting.pdf)
- [7. (2003)-Digital Matting and Compositing](http://grail.cs.washington.edu/projects/digital-matting/)
- [8. (2002-siggraph-Bayesian)Video Matting of Complex Scenes](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.164.911&rep=rep1&type=pdf)
- [9. (2001-cvpr-Bayesian)-A Bayesian Approach to Digital Matting](https://grail.cs.washington.edu/projects/digital-matting/image-matting/)

___Deep learning(image or $\alpha$ matting):___

- [1. (2018)-Deep Energy: Using Energy Functions for Unsupervised Training of DNNs](https://arxiv.org/pdf/1805.12355.pdf)
- [2. (2018-US Patent)-Utilizing deep learning for automatic digital image segmentation and stylization](https://patentimages.storage.googleapis.com/d4/00/65/0f72d794c37845/US9978003.pdf)

___Image segmentation:___

- [1. (2000-classical method)-Normalized Cuts and Image Segmentation](https://repository.upenn.edu/cgi/viewcontent.cgi?article=1101&context=cis_papers)
- [2. (2004)-GrabCut](http://pages.cs.wisc.edu/~dyer/cs534-fall11/papers/grabcut-rother.pdf)
- [3. (2011-1059cited-nips-CRF)-Efficient Inference in Fully Connected CRFs with Gaussian Edge Potentials](http://www.philkr.net/papers/2011-12-01-nips/2011-12-01-nips.pdf)

___Domain Knowledge:___

- [1. An Introduction to Conditional Random Fields for Relational Learning](https://people.cs.umass.edu/~mccallum/papers/crf-tutorial.pdf)
- [2. An Introduction to Conditional Random Fields](http://homepages.inf.ed.ac.uk/csutton/publications/crftut-fnt.pdf)
- [3. Conditional Random Fields: Probabilistic Models for Segmenting and Labeling Sequence Data](https://www.seas.upenn.edu/~strctlrn/bib/PDF/crf.pdf)
- [4. Training Conditional Random Field](https://www.lewuathe.com/machine%20learning/crf/conditional-random-field.html)

___中文博客:___

- [1. FCN和CRF博客](https://zhuanlan.zhihu.com/p/22308032)
- [2. 十分钟看懂图像语义分割技术](https://mp.weixin.qq.com/s?__biz=MzA4ODgxMDY4MA==&mid=2655430607&idx=1&sn=fac0142ff44fac2d466350b922a707b1)
- [3. 基于随机场的图像语义分割](https://blog.csdn.net/step_forward_ML/article/details/80519698)
- [4. 图像语义分割综述](http://ojmhfvae7.bkt.clouddn.com/%E5%9B%BE%E5%83%8F%E8%AF%AD%E4%B9%89%E5%88%86%E5%89%B2%E7%BB%BC%E8%BF%B0.pdf)
- [5. 抠图算法（交互式）以及证件照的自动抠图](https://blog.csdn.net/zlj6786579/article/details/79941170)
- [6. 图像抠图算法学习 - Shared Sampling for Real-Time Alpha Matting](https://www.cnblogs.com/Imageshop/p/3550185.html)
- [7. 条件随机场(CRF)](https://hit-computer.github.io/2017/06/10/CRF/)

___资源:___

- [1. image matting](http://www.alphamatting.com)
- [2. 2006-presentation of Digital Matting](http://www.cs.tau.ac.il/~dcor/Graphics/adv-slides/DigitalMatting2.pdf)
- [3. PyDenseCRF](https://github.com/lucasb-eyer/pydensecrf)
- [4. MSRC-21](http://rodrigob.github.io/are_we_there_yet/build/semantic_labeling_datasets_results.html#4d5352432d3231)
- [5. 无痛的机器学习第一季目录](https://zhuanlan.zhihu.com/p/22464594)

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/)
