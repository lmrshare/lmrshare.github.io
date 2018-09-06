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
\alpha_0P^{0} + \alpha_1P^{1} +, ..., + \alpha_{n-1}P^{n-1} = X^0 \text{			,(a)}\\
\alpha_0'P^{0} + \alpha_1'P^{1} +, ..., + \alpha_{n-1}'P^{n-1} = X^T  \text{			,(b)}
\tag{1}
\end{cases}
$$

$(b) -(a)$并整理得:

$$
X^0 + (\alpha_0' - \alpha_0)P^{0} + (\alpha_1' - \alpha_1)P^{1} +, ..., + (\alpha_{n-1}' - \alpha_{n-1} )P^{n-1} = X^T
\tag{
2
}
$$

显然左式可看成:

$$
X^{
i-1
} + 
(\alpha_{i-1}' - \alpha_{i-1} )P^{i-1} = X^{
i
}
\tag{
3
}
$$

其中, $i \in {
\begin{Bmatrix}
1, 2, 3
\end{Bmatrix}
}$, 显然经过n次迭代即可收敛到$X^{
T
}$, 结论得证. 我认为单纯了证明这个定理只需要向量组是向量空间的基即可, 并不需要满足$A$共轭. 然而, 我这个证明相比较教材中的证明是有缺陷的, 即: 没办法给出迭代中${\lambda}^k$的具体
解法, 而教材的证明既给出了证明, 又给出了${\lambda}^k$的一种解法---最优一维搜索, 而这种解法在"$P^{i}$是$A$共轭的"条件下使得$ \nabla f(X^n)$为0，进而得到了极小值点. 因此教材中的证明既给出了理论验证又给出了求解方案.(对于这个细节我会单独在另外一篇博客里给出更详细的解释) 说到了这, 共轭方向法也算是呼之欲出了, 即: 如果给定任意已知的$A$的共轭向量组$ { \begin{Bmatrix} P^{(0)}, P^{(1)}, ..., P^{(n-1)} \end{Bmatrix} } $, 那么只要按照如下方式迭代就可以求得正定二次函数的极小值:

$$
\begin{cases}
X^{(k+1)} = X^{(k)} + \lambda_{k} P^{k}, k = 0, 1, 2, ... ,n-1 \\
\lambda_{k}: \min_{\lambda} f(X^{(k)} + \lambda P^{(k)}) \text{
, 最优一维搜索(前面已铺垫)
}\\
X^{(n)} =  X^{\star}
\tag{4}
\end{cases}
$$

这就是共轭方向法的内容了, 记住两个关键点即可: 1). 共轭基 2). 用最优一纬搜索求$\lambda$. 当然, 到这里就有了新问题了: 具体怎么获得满足要求的基, 这里只是点明了对基的要求, 而没有明确具体怎么获得这样的基? 而接下来讨论的共轭梯度法就是一种既可求基又可求$\lambda$的可编程实现的方法.

### <a name="Conjugate-Gradient"></a>共轭梯度法(Conjugate-Gradient---CG)

&emsp;&emsp;由前面的描述我们知道共轭梯度法(CG)和共轭方向法(CD)的关系: CG是在CD框架下的一种具体解法, 直白点的描述就是: 前者能写代码, 后者只能看看. 接下来的内容就是给出CG的推导过程. 首先, 回顾下正定二次函数问题的极小值特点: 1. 唯一存在; 2. 其理论解为: $X^{\star} = -A^{-1}B$.(看到这是否有种脱裤子放屁的感觉:"既然都知道解了, 为毛还搞些有的没的". 其实有一丢丢基础的人都清楚: $A^{-1}$是很难求的, 因此也就有人会想到利用稀疏化技术对其简化, 比如我以前做的CS问题就涉及这方面的内容. 不过, 即使知道, 我初学的时候还偶尔会脑抽犯嘀咕.), 因此, 对于这个任务只要按照方向梯度法执行固定的步数(找到极值点)就可以了. 那么CG是如何工作的呢? CG是怎么满足CD的呢? 仍然先把结论抛出来: 在一组正交基中寻找$A$共轭的基, 基找完了算法也就结束了, 我对比了下这里基的找法同拉格姆-施密特正交化的方法类似. 在此, 我给出的助记是: 正交基中找共轭基. 进一步确定个细节: 这里提到的正交基是由每次迭代的近似解$X^k$($k \in \begin{Bmatrix} 1, 2,..., n-1\end{Bmatrix}$)的梯度$\nabla f(X^k)$构成.(我仍然觉得, 如果你的工作重心在建模, 有如上的认识就够了, 因为不太可能自己去写CG. 另外, 这些内容是可以推导出CG的具体求解细节的, 前提是要有点耐心.) 下面进行推导:

首先, 我们回顾下确定$\lambda$的最优一纬搜索的内容:

$$
\frac{df(X^{
k+1
})}{d\lambda}
=
\frac{df(X^{
k
}+\lambda P^{
k
})}{d\lambda
}
=
\nabla f(X^{
k+1
})
P^{
k
}
=
0
\tag{
5
}
$$

写近点, 后边方便看. 任取初始近似点$X^{0}$, 初始方向$P^{0} = - \nabla f(X^{0})$. 利用$(5)$的最优一维搜索我们可以依次确定$\lambda^{0}, X^{1}, \nabla f(X^{1})$. 此外, (5)也蕴含着(将$\nabla f(X^{1})$带入$5$式): $\nabla f(X^{1}) \nabla f(X^{0}) = 0$. __duang__, 我们前文描述的正交基向量出来了, 接着就是从中找共轭基向量了. 再次先交代如何找共轭基向量, 即: 共轭条件下的待定系数. 交代完找的方法后小结一下以加深印象: $k$次迭代中做的事情就是: 确定第$k$个正交基向量, 从中找第$k$个共轭基向量. 我把第$k$次迭代具体做的事推导出来, 那么整个求解流程也就讲完了.

进入第$k$次迭代时, 我们有如下已知项:

$$
\begin{cases}
X^{k-1}, \text{k-1次迭代的极小值估计} \\
\nabla f(X^{0}),  \nabla f(X^{1}), ...,  \nabla f(X^{k-1}),  \text{正交向量组} \\
\nabla P(X^{0}),  \nabla P(X^{1}), ...,  \nabla P(X^{k-1}), \text{共轭向量组}
\end{cases}
$$

再次重写下递推关系式:

$$X^{k} = X^{k-1} + \lambda^{k-1} P^{k-1}$$

首先, 通过最优一纬搜索依次确定$\lambda^{k-1}, X^{k}, \nabla f(X^{k}$, 这样就得到了新的正交基向量$\nabla f(X^{k})$,(你可能很好奇为什么这么求就保证了$\nabla f(X^{k})$就是正交基向量,完成推导后会给出解释.) 然后, 用新的正交向量组表示共轭基向量$P^{k}$, 同时又要满足共轭条件, 即:

$$
\begin{cases}
P(X^{k}) = -\nabla f(X^{k}) + \alpha_{k-1} \nabla f(X^{k-1}) +, ..., \alpha_{0} \nabla f(X^{0}) \\
P(X^{k})^TAP(X^{k-1}) = 0 \\
P(X^{k})^TAP(X^{k-2}) = 0 \\
... \\
P(X^{k})^TAP(X^{0}) = 0
\end{cases}
\tag{
6
}
$$

我们的目的是把方程组中的${\begin{Bmatrix}\alpha_{k-1}, \alpha_{k-2},..., \alpha_{0}\end{Bmatrix}}$求出来, 解决该问题的一个思路就是 __表示一致__, 具体做法就是将所有的共轭等式的左侧用梯度表示, 因此, 尝试找$AP(X^{i}),  i \in {\begin{Bmatrix} 1, 2, 3 \end{Bmatrix} }$ 的梯度表达, 这里由梯度函数与极小值递推公式可获得我们想要的东西, 由:

$$
\begin{cases}

\nabla f(X) = AX + B \\
X^{k} = X^{k-1} + \lambda^{k-1} X^{k-1}

\end{cases}
$$

得:

$$
\nabla f(X^{k}) - \nabla f(X^{k-1}) = A(X^{k} - X^{k-1}) = \lambda_{k-1}AP^{k-1}
\tag{
7
}
$$

这样将$(6)$中的所有共轭条件等式进行梯度表达, 得:

$$
\begin{cases}
 \\
(-\nabla f(X^{k}) + \alpha_{k-1} \nabla f(X^{k-1}) +, ..., \alpha_{0} \nabla f(X^{0}))^TAP^{k-1} = 0 \\
(-\nabla f(X^{k}) + \alpha_{k-1} \nabla f(X^{k-1}) +, ..., \alpha_{0} \nabla f(X^{0}))^TAP^{k-2} = 0 \\
... \\
(-\nabla f(X^{k}) + \alpha_{k-1} \nabla f(X^{k-1}) +, ..., \alpha_{0} \nabla f(X^{0}))^TAP^{0} = 0
\end{cases}
\tag{
8
}
$$

再将$(7)$带入$(8)$得:

$$
\begin{cases}
 \\
[-\nabla f(X^{k}) + \alpha_{k-1} \nabla f(X^{k-1}) +, ..., \alpha_{0} \nabla f(X^{0})]^T[\nabla f(X^{k}) - \nabla f(X^{k-1})] = 0 \\
[-\nabla f(X^{k}) + \alpha_{k-1} \nabla f(X^{k-1}) +, ..., \alpha_{0} \nabla f(X^{0})]^T[\nabla f(X^{k-1}) - \nabla f(X^{k-2})] = 0 \\
... \\
[-\nabla f(X^{k}) + \alpha_{k-1} \nabla f(X^{k-1}) +, ..., \alpha_{0} \nabla f(X^{0})]^T[\nabla f(X^{1}) - \nabla f(X^{0})] = 0
\end{cases}
\tag{
9
}
$$

利用正交, 整理简化得:

$$
\begin{cases}

\alpha_{k-1} \nabla f(X^{k-1})^T \nabla f(X^{k-1}) = -\nabla f(X^{k})^T \nabla f(X^{k}) \\
\alpha_{k-2} \nabla f(X^{k-2})^T \nabla f(X^{k-2}) = \alpha_{k-1} \nabla f(X^{k-1})^T \nabla f(X^{k-1}) \\
... \\
\alpha_{0} \nabla f(X^{0})^T \nabla f(X^{0})	= \alpha_{1} \nabla f(X^{1})^T \nabla f(X^{1}) 
\end{cases}
\tag{
10
}
$$

玩一波多米诺骨牌, 得:

$$
\begin{cases}
\alpha_{k-1} = - \frac{\nabla f(X^{k})^T \nabla f(X^{k})}{\nabla f(X^{k-1})^T \nabla f(X^{k-1})} \\
\alpha_{k-2} = - \frac{\nabla f(X^{k})^T \nabla f(X^{k})}{\nabla f(X^{k-2})^T \nabla f(X^{k-2})} \\
... \\
\alpha_{0} = - \frac{\nabla f(X^{k})^T \nabla f(X^{k})}{\nabla f(X^{0})^T \nabla f(X^{0})} \\
\end{cases}
\tag{11}
$$

小手抖到这就把待定的系数求出来了, 那我们分析分析这个解吧, 把他的递推分析出来. 先把他的解写出来:

$$
P(X^k) = -\nabla f(X^k) + \sum_{i=0}^{k-1} -\frac{\nabla f(X^{k})^T \nabla f(X^{k}))}{\nabla f(X^{i})^T \nabla f(X^{i})} \nabla f(X^{i}) 
\tag{
12
}
$$

为了朝递归方向改造, 自然要折腾$\sum$了:

$$
\begin{matrix}
P(X^k) = -\nabla f(X^k) + \\
-\frac{\nabla f(X^{k})^T \nabla f(X^{k}))}{\nabla f(X^{k-1})^T \nabla f(X^{k-1})} \nabla f(X^{k-1}) +
\sum_{i=0}^{k-2} -\frac{\nabla f(X^{k})^T \nabla f(X^{k}))}{\nabla f(X^{i})^T \nabla f(X^{i})} \nabla f(X^{i}) 
\tag{
13
}
\end{matrix}
$$

整理一下:

$$
\begin{matrix}
P(X^k) = -\nabla f(X^k) + \\
\frac{\nabla f(X^{k})^T \nabla f(X^{k}))}{\nabla f(X^{k-1})^T \nabla f(X^{k-1})} \{-\nabla f(X^{k-1}) +
\sum_{i=0}^{k-2} -\frac{\nabla f(X^{k-1})^T \nabla f(X^{k-1}))}{\nabla f(X^{i})^T \nabla f(X^{i})} \nabla f(X^{i}) 
\}
\tag{
13
}
\end{matrix}
$$

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
