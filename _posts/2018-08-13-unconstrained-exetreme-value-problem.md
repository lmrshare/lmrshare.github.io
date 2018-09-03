---
layout: post
title: "无约束极值问题的解法"
date: 2018-06-01
description: "Rearch"
tag: Research
---


### 目录


* [梯度下降(Gradient Descent---GD)](#Gradient-Descent)
* [共轭方向法(Conjugate Direction---CD)](#Conjugate-Direction)
* [共轭梯度法(Conjugate Gradient---CG)](#Conjugate-Gradient)
* [Ref](#will-search)


&emsp;&emsp;本文是关于求解的, 主要介绍无约束极值问题的一些常用方法, 同时也是CNN这篇文章中Hessian Free Optimization的补充材料. 本文源于教材<< __运筹学__ >>中的 __无约束极值问题的解法__ 一节, 这篇笔记的特点在于: 对书中一些公式细节进行补充说明、提出作者自己的推导方法, 此外, 给出实际案例以及代码来加深理解.


### <a name="Gradient-Descent"></a>梯度下降(Gradient Descent---GD)

&emsp;&emsp;无约束极值问题可以被描述为:

$$ min f(x), X \in E^n \tag{0}$$

假设目标函数具有一阶连续偏导数, 并存在极小值点$ X^* $. 现在以$ X^k $作为对极小值点的第$ k $次近似, 那么第$ k+1 $次近似可被描述为 $ X^{k+1} = X^k + \lambda P^k$, 注意, 这里的步长$ \lambda $和方向向量$ P^k $都是不知道的. 我们这样建模的目的就是寻找一种求解方式使得$X^k$迭代下降, 而我们接下来阐述的GD算法就是能够达到此目的的一种方法, 进一步说就是对$ \lambda $和$ P^k $进行求解的一种方法. 接下来本文就要GD算法是如何对其进行具体求解的, 通过以下几个步骤展开我们的话题: 

+ __泰勒级数分析 ------__ 通过一阶泰勒级数展开来对方向向量进行理论分析, 也可以说是给出其可行域.
+ __GD的方向向量 ------__ 在该理论分析的基础上引出GD中所使用的方向向量$ P^{*}$, 即: GD是怎么求方向向量的.
+ __$\lambda$求解 ------__ 介绍几种求步长$ \lambda $的方法.
+ __草稿手算练习------__ 如果有一天计算机没了, 我们可以用纸笔来做GD(多么牛批的解释).
+ __GD的流程 ------__ 指导编码.
+ __代码------__ 我们这行里, 如果落实不到代码上, 都不算掌握, 哪怕是非常简单的代码, 还是写一下吧.
+ __小结------__ 获奖感言

__1. 泰勒级数分析:__

&emsp;&emsp;本节主要是站在理论制高点搔首弄姿的告诉你什么样的方向$P^k$是ok的, 什么样的方向是不ok的. 首先, 我交代下通过理论分析所得到的结论: 在$ X^k $ 的附近 __充分小__ 的距离内, 只要$ P^k $与$ X^k $的梯度$ \nabla f(X^k) $的夹角大于$ 90^o $, 那么沿$P^k$行走就可以改善结果, 换句话说可以使目标函数进一步朝极小值迈进. 如果你对这个结论有了感性的认识, 那么可以不继续向下看了, 直接跳到下节吧. 接下来进行具体的分析: 首先, 对原函数$ f(X) $进行一阶泰勒展开, 临域为$\lambda P^k$. 展开式为:

$$ f(X) = f(X^k + \lambda P^k) = f(X^k) + \lambda \nabla f(X^k)^T P^k + o(\lambda) \tag{1}$$

其中, 高阶项$ o(\lambda) $满足: $ \lim_{\lambda \rightarrow 0} \frac{o(\lambda)}{\lambda} = 0 $.(这个条件不满足是没办法用低阶项对原函数进行近似的, 你可以不严谨的想一个bad case: 不连续的函数). 也就是说, 在$ \lambda $充分小的时候, 我们可以忽略高阶分量的影响. 现在只考虑$ \lambda \nabla f(X^k)^T P^k $. 我们发现, 只要$ \nabla f(X^k)^T P^k < 0$就可以保证目标函数向极小值迈进, 即: $ f(X^k + \lambda P^k) < f(X^k) $, 至此, 理论分析结束. 我们要注意一点: 分析并没有给出具体的$ P^k $求解, 而是从微分的角度告诉我们 __哪些__ 方向可以减小目标函数值. 我觉得很多时候我们不会记得住复杂的细节, 所以看完一段理论后最好能总结成一句话或者绘制一个图片, 哪怕是没那么严谨的. 这里我给出的助记总结是: "梯度方向的钝角区域可改善结果", 同时绘制相应的助记图形, 如图1所示:

<div align="center">
	<img src="/images/posts/unconstrained/ok-rigion.png" height="200" width="200">
</div>

$$图1. 粗体曲线与虚直线之间的钝角区$$

__2. GD的方向向量:__

&emsp;&emsp;前一节的泰勒级数分析没有给出具体的方向向量$ P^k $, 而是一种实操准则, 并不能用代码实现. 本节给出GD算法在该准则下的$P^k$, 同样, 先抛出结论: 沿$ P^k = -\nabla f(X^k) $ 方向行走可以使函数值下降最快, 负梯度方向也就意味着该钝角是$ {180}^o $, 接下来, 给出推导. 我们在前文提到, 只要$ \nabla f(X^k)^T P^k < 0$就可以保证目标函数向极小值迈进, 由向量的内积我们可得到:

$$  \nabla f(X^k)^T P^k = \left \|  \nabla f(X^k)  \right \| \cdot \left \| P^k \right \| {cos}^\theta \tag{2}$$

式中,$ \theta $为向量$ \nabla f(X^k) $与$ P^k $的夹角. 当$ \theta = {180}^o, {cos}^\theta = -1$时$  \nabla f(X^k)^T P^k$最小. 此时$  \nabla f(X^k) $与$P^k$方向相反, 这样结论得证.

&emsp;&emsp;结合前两节我们得到这样的结论: 在$ X^k $ 附近 __充分小__ 的距离内, 只要沿着$X^k $的梯度$ \nabla f(X^k) $反方向迈进, 可以使函数值下降最快, 这就是我们常听到的___向梯度反方向走下降最快的理论解释. 最后, 我们要确定步长$\lambda$.

__3. $\lambda$求解:__

&emsp;&emsp;这里只介绍最优一维搜索算法, 想法比较直观, 即: 使$ \lambda $满足:

$$ \nabla f(X^k - \lambda \nabla f(X^k)) = 0 \tag{3.1}$$

也即:

$$ \nabla f^T(X^k-\lambda \nabla f(x^k)) \nabla f(X^k) = 0 \tag{3.2}$$

这样求得的$\lambda$就是负梯度方向上的最佳步长. 此外, 如果$f(X)$具有二阶连续偏导数, 也可在$X^k$做$ f(X^k-\lambda \nabla f(X^k)) $的泰勒展开, 然后用低阶项进行近似:

$$ f(X^k - \lambda \nabla f(X^k)) \approx f(X^k) - \nabla f^T(X^k)\lambda \nabla f(X^k) + \frac{1}{2}\lambda \nabla f^T(X^k) H(X^k)\lambda \nabla f(X^k) = 0 \tag{3.3}$$

得到:

$${\lambda}^k = \frac{\nabla f^T(X^k \nabla f(X^k)}{\nabla f^T(X^k H(X^k)\nabla f(X^k} \tag{3.4}$$

接着, 负梯度方向取单位向量$ P^k = -\frac{\nabla f(X^k)}{\left \| \nabla f(X^k) \right \|}$, 求${\lambda}^k$:

由

$$ \nabla f(X^k + \lambda P^k) \approx f(X^k) + \lambda \nabla f^T(X^k) P^k + \frac{1}{2} \lambda {P^k}^k H(X^k) \lambda P^k = 0 \tag{3.5}$$

求得:

$$ {\lambda}^k = -\frac{ \nabla f^T(X^k)P^k} { {P^k}^T H(X^k) P^k } \tag{3.6}$$

将$ P^k = -\frac{\nabla f(X^k)} {\left \| \nabla f(X^k) \right \|}$带入 __3.6__ 式:

$$ {\lambda}^k = \frac{\nabla f^T(X^k) \nabla f(X^k) \left \| \nabla f(X^k)  \right \|} {\nabla f^T(X^k) H(X^k) \nabla f(X^k)} \tag{3.7}$$

__4. 草稿手算练习:__

<div align="center">
	<img src="/images/posts/unconstrained/cal-on-paper.png" height="600" width="500">
</div>

$$图2. 手算$$

__5. GD的流程:__

<div align="center">
	<img src="/images/posts/unconstrained/gd-pseudocode.bmp" height="400" width="200">
</div>

$$图3. 伪代码$$

__6. 代码:__

```
//TODO
def GD()

...


```

__7. 总结:__

&emsp;&emsp;GD算法是比较简单的方法了, 在实际应用中其实没必要关注这么多理论细节. 这个方法有个缺陷: 泰勒级数分析也就意味着这是个临域方法, 从而对于复杂函数(多个极值点)可能求出的解是局部最小值. 另外这也是个贪心算法, 因为每次迭代都是选择临域最优解. 如果模型比较简单比如单峰函数, 用这个方法就可以了, 对于复杂的模型, 这个求解方法能力是不够的. 另外再提醒一下: 负方向最速下降的理论基础是泰勒级数展开, 因此必须在临域内, 他才是使目标函数下降最快的. 另外GD方法还有个特点: 当目标函数的等值线偏扁平的时候, 收敛速度就没那么快了, 因此在实际应用中通常结合GD和其他收敛速度快的方法一起使用.

### <a name="Conjugate-Direction"></a>共轭方向法(Conjugate-Direction---CD)

&emsp;&emsp;这一部分讨论稍微高阶点的方法: 共轭方向法. 所谓共轭就是正交概念的推广: 非0向量$X$与$Y$关于对称正定矩阵$A$共轭, 有$X^TAY=0$. 由此可见正交的两个向量是$I$共轭的. 该部分的讨论围绕正定二次函数极小值问题. 正定二次函数的极小值问题为:

$$min f(X) = \frac{
1
}{
2
}X^TAX + B^TX + c
\tag{
0
}
$$

其中, $A$是对阵正定矩阵, $B \in E^n, X \in E^n$. 对于这个问题, 有如下定理: 如果向量组$P^{
i
}, i = 0, 1, 2, ..., n-1$是$A$共轭的, 那么从任意$X^0$出发只要不重不落的沿着向量组里的向量方向迭代更新就可以收敛到极小值点$X^*$. 对于这个定理我给出自己稍好理解的解释:

由于$P^{
i
}$是$A$共轭的, 那么$P^{
i
}$一定是线性独立的, 又因为向量组有$n$个向量, 所以综合这两点我们得到:$X^0, X^*$一定在$P^{
i
}$张成的线性空间里, 因此有:


$$
\begin{cases}
\alpha_0P^{0} + \alpha_0P^{0} +, ..., + \alpha_{n-1}P^{n-1} = X^0 \text{,  (a)}\\
\alpha_0'P^{0} + \alpha_0'P^{0} +, ..., + \alpha_{n-1}'P^{n-1} = X^T  \text{,  (b)}
\tag{1}
\end{cases}
$$

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
