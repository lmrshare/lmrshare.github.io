---
layout: post
title: <font color="ff0000">Notes about Machine Learning(lhy 35-transfer learning)[5]</font>
date: 2019-01-09
description: "Research"
tag: Research
---

### 目录

* [problem](#problem)
* [overview](#overview)
* [Model Fine-tuning](#model-fine-tuning)
* [Multitask learning](#multitask-learning)
* [Domain-adversarival-training](#domain-adversarival-training)
* [Zero shot learning](#zero-shot-learning)
* [Self taught learning](#self-taught-learning)
* [Self taught Clustering](#self-taught-clustering)

### <a name="problem"></a>problem

<div align="center">
	<img src="/images/drafts/lhy-video/tl1.png" height="300" width="600">
</div>

$$图1. abstract(源于lhy视频)$$

### <a name="overview"></a>overview

+ target data与任务直接相关; source data与任务没有直接相关

<div align="center">
	<img src="/images/drafts/lhy-video/tl-overview.png" height="300" width="600">
</div>

$$图2. overview(源于lhy视频)$$

### <a name="model-fine-tuning"></a>Model Fine-tuning

+ abstract
+ layer transfer: 语音的应用和图像的应用是有区别的

<div align="center">
	<img src="/images/drafts/lhy-video/tl2.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/tl3.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/tl4.png" height="300" width="600">
</div>

$$source\ domain和target\ domain的相似程度对性能的影响$$

<div align="center">
	<img src="/images/drafts/lhy-video/tl5.png" height="300" width="600">
</div>

$$图3. Fine\ tuning(源于lhy视频)$$

### <a name="multitask-learning"></a>Multitask learning

+ fine-tuning关心target domain上做的好不好, 而Multitask learning同时关心target domain和source domain
+ multitask learning的成功应用是多语音语音识别

<div align="center">
	<img src="/images/drafts/lhy-video/tl6.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/tl7.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/tl8.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/tl9.png" height="300" width="600">
</div>

$$图4. Multitask\ learning(源于lhy视频)$$

### <a name="domain-adversarival-training"></a>Domain-adversarival-training

+ target data是unlabel的, 而source data是label; 非常mismatch
+ 需要将domain的特性消除: 绿色会陷害红色(就是网络功能相反, 训练到最后红色网络烂掉, 逼出最强绿色网络, 此时消除了domain的特性)

<div align="center">
	<img src="/images/drafts/lhy-video/tl10.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/tl11.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/tl12.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/tl13.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/tl14.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/tl15.png" height="300" width="600">
</div>

$$图5. Domain\ adversarival\ training(源于lhy视频)$$

### <a name="zero-shot-learning"></a>Zero shot learning

+ 数据比Domain adversarival training处理的数据更严苛
+ input一张image, 然后找出其属性(比如找到毛茸茸的特性, 总之不是分类)
+ convex combination of semantic embedding是另一种zero shot learning方法
+ zero shot learning在文字翻译上的应用(将翻译能力迁移到不知道的语言对上)

<div align="center">
	<img src="/images/drafts/lhy-video/tl16.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/tl17.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/tl18.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/tl19.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/tl20.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/tl21.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/tl22.png" height="300" width="600">
</div>

$$图6. Zero\ shot\ learning(源于lhy视频)$$

### <a name="self-taught-learning"></a>Self taught learning

+ source domain没有label, target domain有label(这也是一种semi-supervised learning)
+ unlabel用于learn一个好的feature extractor

<div align="center">
	<img src="/images/drafts/lhy-video/tl23.png" height="300" width="600">
</div>

$$图7. Self\ taught\ learning(源于lhy视频)$$

### <a name="self-taught-clustering"></a>Self taught clustering

+ source domain没有label, target domain也没有label
+ 聚类问题, 只是两domain的数据的cluster是有差异的(我的猜测)
+ 这类方法待定(源视频没怎么说)

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
