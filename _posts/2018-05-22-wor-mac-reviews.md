---
layout: post
title: "FGR审稿意见总结"
date: 2017-11-30 
description: "Research"
tag: Research
---

### 目录

* [评判的几个方面](#aspects)
* [肯定的地方](#be-worthy-to-be-affirmed)
* [详细意见](#details)
* [总结](#summary)

### <a name="aspects"></a>评判的几个方面:

- 技术创新(Technical novelty)
- 新知识(Contributing new scientific knowledge)
- 论文质量(Quality of presentation)

### <a name="be-worthy-to-be-affirmed"></a>肯定的地方:

- 创新性-现有做法都是对时间相关性进行跟踪，本文方法是对其进行检测

### <a name="details"></a>详细意见:

#### REVIEW 1:

- 论文质量: 结构不好；语言问题(打字错误; 重复的章节名字:section C and section C.2.)
- 工作量: 对比方法仅仅用了2014年的Chehra(not sufficient), 具体问题以及建议: a). 看着像是在one million...方法基础上改的, 那么为什么没有和One million方法做对比; 换句话说: 你的方法有没有提高或降低one million的性能; b). 你的方法应该和[21], [25]还有其他的tracking-by-detection方法做对比; c). 你的方法可以将其他级联回归(cascaded regression methods)方法改造, 然后看看改造后的方法对于视频跟踪这一topic 是否有性能的改善, 我认为这样的实验是吸引人的，没有这个实验很难接收你的论文，下面是可以获得的几个人脸跟踪器:http://www.menpo.org/

#### REVIEW 2:

1. 论文质量: 论文写的太差以至于我很难组织文章的创新点，建议重写:

- 语法错误贯穿全文，例如: "truly shape" 应该是"true shape"
- 有很多令人困惑的句子，例如：Section II 的287-293行和364-375行需要重写
- 符号滥用问题, 如：大写字母既表示变量又表示函数. 公式2和3中的\Gamma 需要清楚的解释, 等式3的上标和下标令人困惑, 似乎没有必要, 367行的M在使用之前没有定义, 相思问题如公式的L_k
- 图表令人困惑，比如119-165的"green region"应该是"blue region"吧. 即便如此，图1的含义仍然不清晰

2. 工作量: 仅仅和2014年的方法做对比, 比较新的方法, 如:[J. Yang, J. Deng, K. Zhang, and Q. Liu. Facial shape tracking via spatio-temporal cascade shape regression. In ICCV-W,First Facial Landmark Tracking in-the-Wild Challenge and Workshop, 2015.]

#### REVIEW 3:

- 大多数现有实时人脸跟踪方法已经充分利用了毗邻帧的时域相关性, 因此创新性不够
- 没有令人信服的实验对比, 比如: 深度学习方法或者回归器方法
- 写作应该改善

#### REVIEW 4:

- 论文质量: 论文质量太差, 有非常明显的语法错误, 甚至在摘要仍有语法问题, 这说明作者自己都没有充分校对文章。
- 工作量: 仅仅和Chehra对比，不能说明state-of-the-art。今年的IJCV文章[1]以ing讨论了人脸跟踪, 建议作者利用开源

实现做一下对比. 作者至少在300VW上做一下对比实验[1] G. Chrysos, E. Antonakos, P. Snape, A. Asthana, S. Zafeiriou. "A Comprehensive Performance Evaluation of Deformable Face Tracking In-the-Wild", International Journal of Computer Vision (IJCV), 2017.

### <a name="summary"></a>总结

- 实验不充分: 对比方法应该更丰富些, 数据集加上300VW
- 针对参考意见来设计实验

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
