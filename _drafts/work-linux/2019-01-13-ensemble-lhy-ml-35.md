---
layout: post
title: <font color="ff0000">Notes about Machine Learning(lhy 35-ensemble)[8]</font>
date: 2019-01-13
description: "Research"
tag: Research
---

&emsp;&emsp;ensemble是一种群殴的方法, 常见的有bagging, boost, adaboost, gradient adaboost, stacking.

### 目录

* [Bagging](#bagging)
* [Boost and adaboost](#adaboost)
* [Gradient Boosting](#gradient-boosting)
* [Stacking](#stacking)

### <a name="bagging"></a>Bagging

+ Bagging: 采样做几个小数据集, 然后分别训练, 预测的时候做平均或者投票(可以并行做)
+ 当模型很复杂的时候, 担心overfiting, 通过bagging减小variance(decision tree比较容易overfitting)
+ 对decision tree做bagging就是一种random forest

<div align="center">
	<img src="/images/drafts/lhy-video/ens1.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens2.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens3.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens4.png" height="300" width="600">
</div>

$$图1. Framework\ of\ Ensemble(源于lhy视频)$$

### <a name="adaboost"></a>Boost and adaboost

+ Boosting用在弱模型上面(不可以并行做), 可通过给数据加权的方式来获得training sets, 然后在loss前乘以这个权重
+ Adaboost: 找训练集使得前一个函数差(error rate), 然后训练一个新的函数来降低errot rate(一直在变弱、变强). 找这种数据集的思想是通过调整权重来提高errot rate.
+ 调整方法推导
+ aggregate

<div align="center">
	<img src="/images/drafts/lhy-video/ens5.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens6.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens7.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens8.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens9.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens10.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens11.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens12.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens13.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens14.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens15.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens16.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens17.png" height="300" width="600">
</div>

$$图2. Boost\ and\ adaboost(源于lhy视频)$$

+ adaboost中$\alpha$的证明

<div align="center">
	<img src="/images/drafts/lhy-video/ens18.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens19.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens20.png" height="300" width="600">
</div>

$$图3. Adaboost的数学证明(源于lhy视频)$$

+ adaboost的一个现象: traing data上的error已经不下降了, 但testing data的error还是会再下降
+ 为什么adaboost可以使margin增加

<div align="center">
	<img src="/images/drafts/lhy-video/ens21.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens22.png" height="300" width="600">
</div>

$$图4. 现象(源于lhy视频)$$

### <a name="gradient-boosting"></a>Gradient Boosting

<div align="center">
	<img src="/images/drafts/lhy-video/ens23.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens24.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens25.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens26.png" height="300" width="600">
</div>

$$图5. Gradient\ Boosting(源于lhy视频)$$

### <a name="stacking"></a>Stacking

<div align="center">
	<img src="/images/drafts/lhy-video/ens27.png" height="300" width="600">
</div>

<div align="center">
	<img src="/images/drafts/lhy-video/ens28.png" height="300" width="600">
</div>

$$图6. Stacking(源于lhy视频)$$

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
