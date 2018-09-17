---
layout: post
title: "人脸对齐方法总结(草稿)"
date: 2018-09-17
description: "Rearch"
tag: Research
---

### 目录

* [CNN在人脸对齐上的应用](#cnn-face-alignment)
* [待查](#will-search)
* [Reference](#Reference)

&emsp;&emsp;本文对人脸对齐涉及到的一些方法进行总结, 并在最后介绍我在这个任务上的一些工作.

### <a name="cnn-face-alignment"></a>CNN在人脸对齐上的应用

先对Facial Landmark Detection by Deep Multi-task Learning(2014年的文章)论文做个笔记

#### Facial Landmark Detection by Deep Multi-task Learning(TCDCN)

TCDCN将人脸标记点检测任务与其他相关任务(related tasks)联合起来一起优化. TCDCN构造了一个task-constrained loss function来使related task的error得以反响传播来改善标记点检测任务.
为了调和不同难度、不同收敛速率的任务, 专门设计了任务级的(task-wise)停止规则来加速收敛。

TCDCN从raw pixels中学习feature representation而不是预定义的HOG 人脸描述子. 

知识点：

>* regularization term的作用就是惩罚weights的complexity
>* 通常的MTL最大化所有任务的性能, 而TCDCN希望在相关任务的辅助下最大化主要任务的性能, 即人脸标记点检测.

SGD对于单一任务的学习是有效的, 但是对于多任务的学习却没那么容易, 原因在于: 不同任务具有不同的收敛速率. 现有的解决这个问题的方案为: 利用任务之间的相关性, 例如: 学习一个所有任务权重的协方差矩阵. 然而, 这个方法的局限在于需要要求所有任务的loss function是相同的, 可见对于具有不同loss function的多任务系统显然是不适用的. 此外, 当weight向量的维度很高时, 计算协方差矩阵的代价是很高的.

TCDCN提出early stop规则来及时停止辅助任务的学习以防止其对training set过拟合. 这里有一点要注意early stop规则的regulalization与惩罚权重的regulalizaion是不同的. early stop规则综合考虑了任务在training error的下降趋势以及在validation set上的泛化能力。也就是希望达到这样的目的：如果在training set上的error下降很快则倾向于继续训练. 

网络结构: 输入是40x40的灰度人脸图像, 4个卷积层, 3个池化层, 1个全连接层. 每个卷积层会输出多个feature map. 卷积层中的activation function是absolute tangent function. 在池化阶段, 将max-pooling应用在feature map的non-overlap regions. 最后全连接层输出主要任务、辅助任务共享使用的feature vector. 结构如下图:

<div align="center">
	<img src="/images/posts/cnn-blog/structure_spcification_for_TCDCN.png" height="600" width="800">
</div>

TCDCN与cascade CNN的对比: ****更好的检测精度、更低的计算消耗. 

总结：这篇论文并不没有利用cascade, 模型小, 实时性较好, 可以尝试将其整合到我的工作中, 试试效果.接下来对较早的cascade CNN文章进行解读、分析.

#### Deep Convolutional Network Cascade for Facial Point Detection 2013

abstract: 分三个level的卷积神经网络, 第一层网络用于整体形状的预测, 接下来的两层是精细化的修正.

本文的3 level 网络结构:

<div align="center">
	<img src="/images/posts/cnn-blog/three_level_CNN_model.png" height="250" width="800">
</div>

F1 的结构:

<div align="center">
	<img src="/images/posts/cnn-blog/f1_model.png" height="250" width="800">
</div>

length: feature map的个数, [width x height]: map的大小.

EN1和NM1的网络结构与F1类似, 只是对应的input region不同. level 2和level 3的网络将facial points周围的local patch作为input. 在cascade的框架下, patch size 和search range逐级缩小.

globally weight sharing在人脸应用中表现的并不好, 例如: 虽然眼睛和嘴巴可以共享一些low-level的特征如: edges, 但是他们在high-level上的feature差异很大. 因此对于input包含不同语义的region的情况, 在high layers上采用locally sharing weights的方式更有效(ps: []the idea of locally sharing weights was originally proposed for convolutional deep belief net for face recognition](http://vis-www.cs.umass.edu/papers/HuangCVPR12.pdf)).

Multi-level regression: level 1是初始预测, 后面的level是对形状差进行预测, 也就是精细化调整, 对应着文中提到的Adjustment.

__implementation details:__

convolutional layer(CR(s, n, p, q))

<div align="center">
	<img src="/images/posts/cnn-blog/cr.png" height="600" width="500">
</div>

pooling layer(P(s)) and Fully connected layer(F(n))

<div align="center">
	<img src="/images/posts/cnn-blog/pl_cl.png" height="600" width="500">
</div>

___网络结构:___ level 1的网络结构是由四层卷积+绝对值非线性操作+局部共享权值构成的深度卷积层, level 2、3是与level 1类似的浅层结构(level 2、3之所以是浅层结构是因为他们提取局部features, 因此没必要设计成deep结构与局部权值共享). 网络的细节如图所示:

<div align="center">
	<img src="/images/posts/cnn-blog/net_details.png" height="80" width="500">
</div>

table description: F1 采用了S0, EN1和NM1采用了S1, level2、3采用了S2.

___输入:___ F1 将整个人脸图像作为输入并输出5点坐标, EN1将人脸的顶部和中间部分图像作为输入并输出3点坐标(眼睛、鼻尖). level2、3将前一层预测的point附近的image region作为输入并输出形状增量. 注意: level2、3对于同一个点使用了两个不同的image region进行预测, 然后merge这两个结果, 同时level3 中的image region要比level2中的小.

___训练:___ 对于level1, 我们根据bounding box做了translation和rotation操作. 在level2、3, 我们将truth position进行随机水平和垂直平移来获得region, level2的最大平移限上限为0.05、level3为0.02, 这里的距离够根据bounding box进行了规范化. 训练过程中需要更新的网络参数为: weight(w)、gain(g)、bias(b), 学习的方法为SGD.

___实验以及结论:___ S0 与S3~5结构类似, 只是深度不同, 从结果可以看出深度增加可以改善算法性能. S6~7均与S0层数相同, 但是S6没有absolute value rectification, S7采用的是全局权值共享, 也就是说所有的convolutional layer的权值都一样. 从实验可知: absolute value rectification和locally sharing weights非常重要. 论文猜测: 高阶特征的共享性质要弱于低阶特征. 基于这个
猜想可推测: a)locally sharing weights对于较高layer比较重要,b)仅在较低layer使用locally sharing weights会影响性能或者说低层layer更适合globally sharing weights. 实验说明采用cascade的方式可以提高性能.

#### A Deep Cascade of Convolutional Neural Networks for MR Image Reconstruction

基于deep learning的CS-MRI的主要挑战就是要在模型性能和网络模型大小之间做trade-off. 这篇论文同CS-MRI的思路一样，仍然是将图像重建问题看成是一个de-aliasing问题.


#### Hessian Free Optimization

适用于神经网络的一个最优化方法.

___Gradient Descent:___

最简单的迭代优化算法. 在任意一点沿着反向梯度下降是最快的. 因此有如下迭代算法:

1. 初始化: 选定初始值$ x_0 $
2. 计算$ x_i $处的梯度(即方向向量): $ \upsilon_i = \nabla f(x_i) $
3. 更新: 梯度乘以步长: $ x_{i+1} = x_{i} - \alpha \upsilon_i $
4. 迭代2、3直至收敛, 即: $ f{i} < \epsilon $

GD是first-order方法, 这个方法的限制就是: 如果误差平面比较平滑的时候才表现良好, 如果误差平面复杂则可能会导致收敛很慢.

___Newton's Method:___

尽管GD方法work, 但是这个方法的缺点就是慢, 为了优化速度, 可以利用二阶导数信息, 其中比较有代表性的就是Newton's Method. 接下来以1D举例, 然后拓展到多维情况:

1D:

对于一个可导函数来说, 他的局部最小值就是导数为0时$ {f}'(x) = 0 $. 如果$ f $是二次函数或者是单峰函数, 那么局部最小值就是最小值, 然而对于任意的非线性$ f $这就不好说了, 因此
, 在确定Nerwo Method的递推公式后要利用迭代的方式以跳出局部最小值以求得最小值或者说接近最小值, 接下来通过二阶泰勒展开的方式给出Newton's Method的递推公式:

对$ f(x_0) $附近的函数进行second-order Taylor展开:

$$ f(x_0 + x) \approx f(x_0) + {f}'(x_0)x + {f}''(x_0)\frac{x^2}{2} $$

此时, 我们需要找到$ x $来使$ f(x_0 + x) $最小, 既然临域且是二阶泰勒展开, 显然导数等于0即可:

$$ \frac{\mathrm{d} }{\mathrm{d} x}(f(x_0) + f'(x_0)x + f''(x_0)\frac{x^2}{2}) = f'(x_0) + f''(x_0)x $$

由此可得到: $$ x = - \frac{f'(x_0)}{f''(x_0)} $$

则递推为: $$ x_{n+1} = x_n - \frac{f'(x_n)}{f''(x_n)} $$

可以看出二阶泰勒展开就是利用二次函数在定义域进行search, 姑且起个名---临域二次曲线近似. 对于高维, 有类似的结论: $$ f: R^n -> R $$, 原理类似, 只不过就是一阶导数变梯度向量, 二阶导数变成海赛矩阵:

>* $$ f'(x) -> \nabla f(x) $$

>* $$ f''(x) -> H(f)(x) $$

递推变为:

$$ x_{n+1} = x_n - (H(f)(x_n))^{-1}\nabla f(x_n)$$

总结: Newton's method是二阶算法, 效果可能比简单的GD要好. Newton's method假设函数在临域内可以很好的进行二阶泰勒展开也就是说可以很好的被二次函数来描述, 在这个假设下来搜索全局最优.
对比GD和Newton's method的递推公式, 可看出Newton's method是一种变步长算法. 此外, 从二阶导数的数学性质再来看这个可变化的步长有什么性质. 简单总结: Newton's method的步长可以做到: __低曲率曲面大步长, 高曲率曲面小步长__. 理由: 二阶导数$ f''(x) $反映了曲率, 即曲率高二阶导数大、曲率低二阶导数小; 而Newton's method方法的步长为$ f''(x)^{-1}$, 显然验证如上的简单总结.

然而(骚年, 重点来啦!), 海赛矩阵自打我记事起, 就听说这哥们hin难算. 如果不借助于有限差分几乎是不可能计算海赛矩阵的, 因此我可能不知道怎么计算海赛矩阵, 此外, 海赛矩阵需要$ O(n^2) $
存储空间来计算和查找, 所以复杂度是比较高的. 而Hessian-free optimization可以解决这两个问题, 该方法的关键在于优化了求二阶泰勒近似最小值的方法, 具体来说: 利用共轭梯度来迭代求二阶泰勒展开的最小值而不是直接通过导数/梯度为0(__利用 $ \frac{\partial f}{\partial x} = 0 $ 不可避免的就要求海赛矩阵, 注意这里的前提是二阶泰勒展开__).

___共轭梯度:___

共轭梯度算法是一种变步长gradient descent, 这里的步长是通过line search找到的.

共轭梯度可以求二次函数的最小值, 此外, 其变体可以处理非线性函数. 接下来我们看共轭梯度算法是怎么解决二次函数的:

二次函数:

$$ f(x) = \frac{1}{2} x^TAx + b^Tx + c $$

其中, $ x \in \mathbb{R}^n Q \in \mathbb{R}^{n \times n}, b, c \in \mathbb{R}^{n} $

梯度为: $ \nabla f(x) = Ax + b $

我们知道沿着梯度反方向是下降最快的, 那么每次下降多长呢? 普通的GD算法是固定步长的, 而CG是一种变步长方法, 每一次都寻找一个$ \alpha $ 使得 $ f $ 最小. 这个问题可描述为: minimizing
这个函数: $ g(\alpha) = f(x_0 + \alpha d_0) $. 这里$ d_0 = - \nabla f(x_0)$.

对于二次函数有: $ g(\alpha) = \frac{1}{2} \alpha^2 d_0^T A d_0 + d_0^T (Ax_0 + b)\alpha + (\frac{1}{2}x_0^T A x_0 + x_0^T d_0 + c) $ 




position_c: [xxxxxx](http://andrew.gibiansky.com/blog/machine-learning/hessian-free-optimization/)


#### Forward Propagation and Back Propagation理论及公式推导

Hessian-Vector Product: 可以通过fp和bp算法来计算Hessian-vector, 该方法叫做R{.}方法. R{.}:

H代表error function的hessian矩阵


position_c1: 找这篇文章以及人脸的代码, 配合文章读代码; 把backpropagation推导一遍.

___常见求解方法:___

position_c: 找这篇文章以及人脸的代码, 配合文章读代码; 把backpropagation推导一遍.

### <a name="will-search"></a>待查

>* TCDCN这篇文章的Related work对人脸方法的总结可以应用到我对face alignemnt的总结里
>* Deep Convolutional Network Cascade for Facial Point Detection 2013这篇文章的introduction和related work的总结可以放到我的总结里
>* Hinge loss
>* 怎样将论文中的辅助任务整合到普通模型中
>* hyperbolic tangent activation function
>* 为什么weight sharing可以有助于阻止back-propagating过程中的gradient diffusion

### <a name="Reference"></a>Reference

- [0. 一个中文总结](http://kekecv.com/resource/landmark_review_2015.pdf)
- [0. 写这个博客要读的论文](https://github.com/lmrshare/lmrshare.github.io/tree/master/papers/cnn-mri-papers-tmpfile)
- [0. andrew 的机器学习博客](http://andrew.gibiansky.com/archive.html)
- [0. a good blog about deep learning](http://andrew.gibiansky.com/archive.html)
- [1. 香港中文大学多媒体实验室](http://mmlab.ie.cuhk.edu.hk/publications.html)
- [2. Face Alignment by Coarse-to_fine Shape Searching](http://personal.ie.cuhk.edu.hk/~ccloy/files/cvpr_2015_alignment.pdf)
- [3. Face Alignment by Coarse-to_fine Shape Searching(Code)](http://mmlab.ie.cuhk.edu.hk/projects/CFSS.html)
- [4. Facial Landmark Detection by Deep Multi-task Learning](http://personal.ie.cuhk.edu.hk/~ccloy/files/eccv_2014_deepfacealign.pdf)
- [5. Deep convolutional network cascade for facial point detection 2013](http://www.ee.cuhk.edu.hk/~xgwang/papers/sunWTcvpr13.pdf)
- [6. ImageNet Classification with Deep Convolutional Neural Networks 2012](https://papers.nips.cc/paper/4824-imagenet-classification-with-deep-convolutional-neural-networks.pdf)
- [7. Compressed Sensing MRI Using a Recursive Dilated Network 2018](http://www.columbia.edu/~jwp2128/Papers/SunFanetal2018.pdf)

2013 face alignment相关的一些代码资源和帖子(tmp):

- [0. 做人脸同行的博文](https://luoyetx.github.io/)
- [1. train](https://github.com/luoyetx/deep-landmark)
- [2. test](https://github.com/luoyetx/mini-caffe/tree/master)
- [3. Cascaded CNN 方法寻找人脸关键点](https://www.zybuluo.com/nrailgun/note/177447)
- [4. 实践总结](https://blog.csdn.net/XZZPPP/article/details/74933489)

2014 TCDCN(tmp):

- [1. source code by one reader](https://github.com/flyingzhao/tfTCDCN)
- [2. and his blog](https://blog.csdn.net/tinyzhao/article/details/52730553)
- [3. TCDCN blog](http://mmlab.ie.cuhk.edu.hk/projects/TCDCN.html)
- [4. 读后小记](https://blog.csdn.net/xiaomeng_marina/article/details/39897773)


<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
