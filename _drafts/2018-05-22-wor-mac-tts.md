---
layout: post
title: "TTS初步调研"
date: 2017-07-26
description: "NLP"
tag: NLP
---

### Convolutional Sequence to Sequence learning

这是一篇做机器翻译的文章

#### Abstract:
>* 1. sequence to sequence学习的比较流行的策略是: 通过rnn来将一个序列映射到一个变长的输出序列
>* 2. 我们引进了一个CNN架构
>* 3. 相比于Recurrent Model(循环模型)，CNN可以：
>*     a). 在训练期间，所有元素的计算可以通过更好的利用GPU硬件来充分的实现并行化
>*     b). 由于非线性基(non-linearities)的数量是固定的并且与input的长度是独立的，所以CNN的优化变得更容易
>*     c). 对于gated linear units的使用使得gradient propagation更容易，并且我们将每一个解码层(decoder layer)都配置一个单独的attention module.
>* 4. 我们的方法在精度上超过了Wu的deep LSTM, 同时无论在GPU还是在CPU上都具有一定量级的速度提升

#### Method:

>* 1.CNN相比RNN不需要依赖前面的计算结果，因此可以并行化
>* 2.提出基于卷积的sequence by sequence建模方法
>* a). 模型配置了gated linear units 和冗余连接
>* b). 在每一个解码层使用了attention，并且我们阐明: 每一个attention layer仅仅增加微不足道数量的overhead
>* c). 这些选择可以使我们处理大规模问题

position:

>* 1. 这篇论文是做语言转换的, 比如: 英转法、英转德
>* 2. 概要性的扫一下里面的关键字
>* 3. PRML的第五章

### Recurrent Sequence to Sequence Learning

Sequence to sequence与RNN based encoder-decoder体系结构是同义的:

>* X -> (encoder RNN) -> Z -> Y
>* X = {x_1,...,x_m}
>* Z = {z_1,...,z_m}
>* Y = {y_1,...,y_n}

在decoder的过程中, 是从左到右逐个获得y_i的. decoder RNN大致工作原理:

>*1. 利用hidden state h_i+1生成y_i+1
>*2. 利用h_i,g_i,c_i生成h_i+1
>*g_i: 先前目标语言单词y_i的embedding
>*c_i: 从编码输出Z中导出的条件输入

summary: 这是一个求解框架, 各种encoder-decoder体系结构的差异主要在于: 条件输入和RNN的类型

#### Models without attention:

>* 1. 仅考虑最终的编码状态z_m, 有两种方式来实现:
>* a> c_i = z_m for all i
>* b> 用z_m来初始化第一个解码状态, 这种情况下c_i没有被使用

#### Models with attention:

>* 1. c_i = \sum{j from 1 to m}{w_j * z_j}[每次计算c_i的时候]
>* a> w_j是attention score, w_j使得网络专注于输入序列的不同部分
>* b> 通过比较每个编码状态z_j与组合(先前的解码状态h_i和最后的预测y_i)来确定w_j. 然后将w_j正规化成输入元素的分布
>* c> 基于RNN的encoder-decoder框架中，比较流行的选择是: LSTM, GRU.
>* d> LSTM, GRU这类拓展的RNN具有gating mechanism, 这也就允许对前面时间里的信息存储, 从而实现长时依赖.
>* e> 最近出现了基于双向的编码模型, 这样就可以对双向的上下文信息进行利用
>* f> 具有多层的模型经常需要依赖shortcut或者residual connections

### A Convolutional Architecture

利用卷机体系结构来进行sequence to sequence建模, 我们利用CNN来对中间编码状态Z和解码状态h进行计算.

>* a. 利用position Enbeddings来对输入元素进行表示
>* b. 利用Convolutional Block Structure(卷积块结构)来获得中间编码状态Z和解码状态h(我猜测就是固定输入和非线性卷积和做卷积)

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
