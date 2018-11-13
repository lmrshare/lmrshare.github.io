---
layout: post
title: "EFC-CRF和CRF-RNN(未完成)"
date: 2018-11-13
description: "CRF papers"
tag: Research
---

&emsp;&emsp;本文是在预研图像语义分割时所做的笔记, 主要对比分析了EFC-CRF(2011-Efficient Inference in Fully Connected CRFs with Gaussian Edge Potentials)和CRF-RNN(2015-Conditional Random Fields as Recurrent Neural Networks). 首先, 介绍传统方法EFC-CRF, 接着, 通过EFC-CRF的高效inference---mean-field-approximation引出其神经网络版CRF-RNN. 最后, 简单总结这两个方法.

### 目录

* [EFC-CRF](#EFC-CRF)
* [从EFC-CRF到 CRF-RNN()](#CRF-RNN)
* [总结](#review)
* [Reference](#reference)

### <a name= "EFC-CRF"></a> 2011-Efficient Inference in Fully Connected CRFs with Gaussian Edge Potentials---EFC-CRF

&emsp;&emsp;在图像语义分割里, 对于CRF的几种使用方式为: 单像素模型(unary potential)、图像快模型、近邻元素或近邻图像快模型(pairwise potential). 对于pairwise potential, 由于对像素
之间的关系进行建模, 理论上其最终效果梗接近图像本身的语义, 但这种模型有一个弊端: pairwise的规模越大, 在进行inference的时候越慢, 尤其是EFC-CRF这种全连接CRF模型. 全连接意味着要对所有像素对进行建模. 以256x256的图像为例, 就会有$\binom{256*256}{2} = 2147450880$个像素对, 这么大的模型, 在inference的时候会非常慢. 而EFC-CRF的主要贡献之一就是对inference的提速, 主要表现在两方面:

* mean-field approximation(mfa).
* 将mfa中的Message passing(pairwise potential)运算看成高维滤波问题, 进而用高效的permutohedral lattice进行求解.

&emsp;&emsp;接下来, 本文将介绍EFC-CRF的模型以及mean-field approximation. EFC-CRF的全连接模型为:

$$

E(x) = \sum_{i}{\psi_{\mu}(x_i)} + \sum_{i < j}{\psi_{p}(x_i, x_j)}

\tag{1}
$$

其中$i, j$是像素的索引, $\psi_{p}(x_i, x_j)$为pairwise potential, 也就是全连接的数学模型, 在EFC-CRF中是gaussian kernel的线性组合:

$$

\psi_{p}(x_i, x_j) = \mu(x_i, x_j)\sum_{m=1}{K}w^{(m)}k^{(m)}(f_i, f_j)

\tag{2}

$$

在实际应用中, 用了两个gaussian kernel:

$$

\psi_{p}(x_i, x_j) = \mu(x_i, x_j)\{
w^{(1)}
exp(-\frac{\left | p_i-p_j \right |^{2}}{2\theta_{\alpha}^2} - \frac{\left | I_i-I_j \right |^{2}}{2\theta_{\beta}^2}) + 
w^{(2)}
exp(-\frac{\left | p_i-p_j \right |^{2}}{2\theta_{\gamma}^2})
\}

\tag{3}
$$

两个kernel分别为: appearance kernel(ak)和smoothness kernel(sk). ak基于观察:相近的具有相似颜色的像素属于同类, 其中, $\theta_{\alpha}$控制了相近度, $\theta_{\beta}$控制了颜色的相似度. sk用于移除小的孤立区(注意, 这里的$\theta_{*}$从数据学习得到). 另外$\mu(x_i, x_j)$(___Potts model,___ $\mu(x_i, x_j) = \left [ x_i\neq x_j \right ]$)被称作兼容项, 用于惩罚临近相似像素被打了不同的标签, 在EFC-CRF中, 对标签的建模并不是很精细, 而CRF-RNN对此有了更精细的建模.

&emsp;&emsp;模型到这基本介绍完了, 后面都是些通用的东西了, 即图像标签的Gibbs distribution:

$$

P(x|I) = \frac{1}{Z}exp\left ( E(x) \right )
\tag{4}
$$

然后, 我们的inference就是极大化这个后验概率(MAP), 也就是解决如下问题:

$$
x^{*} = arg max P(x|I)
\tag{5}
$$

我们前文提到的全连接模型复杂性就体现在后验概率这, 这个优化问题中的$P(x|I)$有大规模的pairwise potential, 因此用常规的优化算法或者暴力穷举来解决这个问题回发现每一步的概率更新计算量都很大, 鉴于此, EFC-CRF的高效inference就采取了前文提到的两项
优化工作, 总结起来就是: 在mean-field近似求解框架下对里面的pairwise potential用高效的滤波技术再提速.

### <a name= "CRF-RNN"></a> 从EFC-CRF到 CRF-RNN

### <a name= "review"></a> 总结

### <a name= "reference"></a> Reference


<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/)
