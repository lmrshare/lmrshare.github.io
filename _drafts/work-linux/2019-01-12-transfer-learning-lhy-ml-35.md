---
layout: post
title: <font color="ff0000">Notes about Machine Learning(lhy 35-svm)[6]</font>
date: 2019-01-12
description: "Research"
tag: Research
---

### 目录

* [Outline](#outline)
* [Hinge Loss](#hinge-loss)
* [Linear SVM](#linear-svm)

### <a name="outline"></a>Outline

<div align="center">
	<img src="/images/drafts/lhy-video/svm-ooutline.png" height="300" width="600">
</div>

$$图1. outline(源于lhy视频)$$

### <a name="hinge-loss"></a>Hinge loss

+ loss 曲线 
+ hinge loss 的结果比较robust

<div align="center">
	<img src="/images/drafts/lhy-video/svm1.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/svm2.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/svm3.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/svm4.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/svm5.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/svm6.png" height="300" width="600">
</div>

$$图1. hinge\ loss(源于lhy视频)$$

### <a name="linear-svm"></a>Linear SVM

+ Linear SVM: 投影到高维(高维的表现形式有时候很难确定, 所以往往通过kernel function来绕过这个困难---kernel trick), 然后用了hinge loss的线性模型.
+ 选了hinge loss的线性模型(零零脚脚会不可微, 没关系, 想想relu和maxout)
+ SVM具有稀疏性质(选了hinge loss后, $\alpha$是稀疏的), 因此SVM并没有选择database里所有的数据, 相较于其他方法就更加鲁棒
+ radial basis function kernel: 用了kernel trick后等价于在无穷维的平面上做inner product
+ 直接定义kernel function而避免有时候很难设计$\phi(*) $, 也就是不用考虑在高维空间里长啥样

<div align="center">
	<img src="/images/drafts/lhy-video/svm7.png" height="300" width="600">
</div>

$$这页幻灯片有点小问题(源于lhy视频)$$

<div align="center">
	<img src="/images/drafts/lhy-video/svm8.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/svm9.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/svm10.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/svm11.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/svm12.png" height="300" width="600">
</div>

$$example1(源于lhy视频)$$

<div align="center">
	<img src="/images/drafts/lhy-video/svm13.png" height="300" width="600">
</div>

$$example2(源于lhy视频)$$

<div align="center">
	<img src="/images/drafts/lhy-video/svm14.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/svm15.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/svm16.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/svm17.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/svm18.png" height="300" width="600">
</div>

$$图2. linear\ SVM(源于lhy视频)$$


<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
