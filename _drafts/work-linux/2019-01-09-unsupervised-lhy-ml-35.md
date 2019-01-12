---
layout: post
title: <font color="ff0000">Notes about Machine Learning(lhy 35-unsupervised learning)[4]</font>
date: 2019-01-09
description: "Research"
tag: Research
---

### 目录

* [Unsupervised learning](#un-su-lea)
* [Word Embedding](#word-embedding)
* [Neighbor Embedding](#neighbor-embedding)
* [Deep Auto-encoder](#deep-auto-encoder)
* [Deep Generation Model](#deep-generation-model)

### <a name="un-su-lea"></a>Unsupervised learning

___Clustering:___

+ K-means
+ HAC(Hierarchical Agglomerative Clustering): step1: build a tree(两两算形似度来建树); step2: pick a theshold(切一刀来决定最后聚了几个类, 切的位置不同最后类的个数不同)
+ HAC和K-means最大的不同是如何决定类的数

<div align="center">
	<img src="/images/drafts/lhy-video/clustering1.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/clustering2.png" height="300" width="600">
</div>

$$图1. Clustering(源于lhy视频)$$

___Dimension Reduction:___

+ 只做聚类会漏掉很多信息, 因为某个object是具有多维信息的. 如果这个多维信息存在冗余就需要Dimension Reductin来解决
+ 为什么做dimension reduction: 数据的维度存在冗余
+ 怎么做: Feature selection、PCA(找出W)
+ PCA(图2中4-9)

<div align="center">
	<img src="/images/drafts/lhy-video/dr1.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dr2.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dr3.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dr4.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dr5.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dr6.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dr7.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dr8.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dr9.png" height="300" width="600">
</div>

$$另外的角度讲PCA$$

<div align="center">
	<img src="/images/drafts/lhy-video/dr10.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dr11.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dr12.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dr13.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dr14.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dr15.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dr16.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dr17.png" height="300" width="600">
</div>

$$图2. Dimension\ Reduction(源于lhy视频)$$

### <a name="word-embedding"></a>Word Embedding

+ word embedding(un-supervised propose)是dimension reduction的一个广为人知的应用

<div align="center">
	<img src="/images/drafts/lhy-video/we1.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/we2.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/we3.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/we4.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/we5.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/we6.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/we7.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/we8.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/we9.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/we10.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/we11.png" height="300" width="600">
</div>

$$图1. word\ embedding(源于lhy视频)$$

### <a name="neighbor-embedding"></a>Neighbor Embedding

+ t-SNE
+ 降维
+ manifold learning
+ Localy Linear Embedding(LLE)

<div align="center">
	<img src="/images/drafts/lhy-video/ne1.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ne2.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ne3.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ne4.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ne5.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ne6.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ne7.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ne8.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ne9.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ne10.png" height="300" width="600">
</div>

$$图1. Neighbor\ embedding(源于lhy视频)$$

### <a name="deep-auto-encoder"></a>Deep Auto-encoder

+ auto-encoder: 跟pca想法有相似的地方
+ Greedy Layer-wise Pre-training: 这个方法现在不怎么用的, 但如果有大量的un-label data少量label data的时候还是有用
+ auto-encoder还可以做降噪
+ Auto-encoder for CNN
+ keras里的un-polling就是做repeat
+ Deconvolution: 就是convolution
+ decoder的妙用: 根据code画image

<div align="center">
	<img src="/images/drafts/lhy-video/dae1.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dae2.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dae3.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dae4.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dae5.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dae6.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dae7.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dae8.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dae9.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dae10.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dae11.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/dae12.png" height="300" width="600">
</div>

$$图1. Deep\ Auto-encoder(源于lhy视频)$$

### <a name="deep-generation-model"></a>Deep Generation Model

+ xxx

<div align="center">
	<img src="/images/drafts/lhy-video/xxx.png" height="300" width="600">
</div>

$$图1. Deep\ Generation\ Model(源于lhy视频)$$

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
