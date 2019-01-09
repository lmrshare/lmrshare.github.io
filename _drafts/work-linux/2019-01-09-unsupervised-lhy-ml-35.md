---
layout: post
title: <font color="ff0000">Notes about Machine Learning(lhy 35-unsupervised learning)[4]</font>
date: 2019-01-09
description: "Research"
tag: Research
---

### 目录

* [Unsupervised learning](#un-su-lea)

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

+ 只做聚类会漏掉很多信息, 某个object是具有多维信息的

<div align="center">
	<img src="/images/drafts/lhy-video/dr1.png" height="300" width="600">
</div>

$$图2. Dimension\ Reduction(源于lhy视频)$$


<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
