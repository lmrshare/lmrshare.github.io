---
layout: post
title: <font color="00ff00">作息时间以及计划</font>
date: 2018-05-21
description: "不在主页显示"
tag: HNotes
---

## 介绍

&emsp;&emsp;这是作息时间以及计划安排，从读研到现在还不能严格按照时间计划来执行，但还是依然坚持以这种方式来管理自己的学习和工作，目的在于:第一，起到监督作用，第二，把控方向，第三，提高自律。

### 目录

* [计划](#Long-term-plan)
* [作息时间](#Timetable)
* [Idea](#Idea)
* [遗留问题汇总](#Will-search)

### <a name="Long-term-plan"></a>计划

| [Research](#long-research)                  |[计算机基础与工作经验](#cs-work)      |[月安排](#month-plan)                                          |
| ------------                                |--------------------------------------|------------------------------------------------------------      |
| _[Computer Vision](#long-re-cv)_            |  _[计算机基础](#long-hy-cb)_         | _[9月: 现有算法原理、硬件、博客、刷题](#april)_                   |
| __[MRI](#long-re-mri)__                     |  __[项目相关](#long-hy-engineer)__   | __[-]()__                                                         |
| _[Optimization Method](#long-re-om)_        |  _[公众号资源](#wechat-resource)_    | _[-]()_                                                            |
| __[Domain Knowledge](#long-re-dk)__         |  __[工作方法](#long-hy-work-trick)__ | __[-]()__                                                          |
| _[Math](#long-re-math)_                     |  _[-]()_                             | _[-]()_                                                           |
| __[English](#long-re-eng)__                 |  __[-]()__                           | __[-]()__                                                         |
| _[Writing&Blog](#long-re-wb)_               |  _[-]()_                             | _[-]()_                                                           |
| __[Other](#long-re-other)__                 |  __[-]()__                           | __[-]()__                                                         |

### <a name="long-research"></a>Research

#### <a name="long-re-cv"></a>___Computer Vision___

>* 关注计算机视觉中的顶级会议论文
>* 人脸检测，人脸标记
>* OCR

#### <a name="long-re-mri"></a> ___MRI___

>* [CRNN用于动态核磁共振成像的论文](https://arxiv.org/pdf/1712.01751.pdf)

#### <a name="long-re-om"></a> ___Optimization Method___

>* review非线性规划
>* 与求解相关的理论(凸优化，非线性规划；数值分析)
>* blog上写文章

#### <a name="long-re-dk"></a> ___Domain Knowledge___

>* 把计算机视觉里的基本书看了(PR, computer vision)
>* 数字信号处理教材

#### <a name="long-re-math"></a> ___Math___

>* 数学：统计推断，数学分析，矩阵论，测度论＋实分析

#### <a name="long-re-eng"></a> ___English___

>* 面试、口语、复杂句、复习日常记录(writing)

#### <a name="long-re-wb"></a> ___Writing& Blog___

>* all in blog

#### <a name="long-re-other"></a> ___Other___

>* 调研几个名校的实验室导师的研究方向，选择后读他们的论文(围绕工作)
>* 调查mit，斯坦福和宾大的与现有工作相关的博士课程(围绕工作)

### <a name="cs-work"></a> 计算机基础与工作经验

#### <a name="long-hy-cb"></a> ___计算机基础___

___语言 (c/c++):___

>* c traps and pitfalls, effective c++(一遍、待复习)
>* 位操作，有符号无符号，高低字节（笔试题）
>* 内存相关（C++不会太问，因为都是自己管理)
>* 程序栈，函数执行的一个过程（查一下）
>* 虚函数，函数指针
>* 跨平台、混编，OC上：RN，java：JNI

___操作系统(进程/线程):___

>* runloop机制, C++和OC都有; post_task; 实多进程现无锁化; google：发现死锁的方法
>* 线程开销
>* 多进程模型(Android)
>* IPC, 你为什么这么选型， async socket: 因为数据量大，unix socket好多都这么用的比如chrome
>* 多线性，多进程的选型（PC， android）
>* WKWebview, 跨进程的(IOS)

___网络(tcp/ip http)___

>* TCP/IP高效编程
>* 滑窗等理论的细节
>* 你怎么做长连接
>* 了解Https协议，了解操作；http协议
>* udp: 视频动画、VoIP；用udp实现可靠的连接，udp打洞
>* 抓包分析
>* 网络调优，特别是移动端（移动端容易断）、心跳、接入点变化(WIFi to 4G)

#### <a name="long-hy-engineer"></a> ___项目相关___

+ 现有算法工作原理
+ 硬件特性

#### <a name="wechat-resource"></a> ___公众号资源___

[1. papers](#papers) &emsp;&emsp;[2. python and deep learning](#python-and-dl)&emsp;&emsp;[3. cs基础](#cs-basis)&emsp;&emsp;[4. tools](#tools)&emsp;&emsp;[5. 资源](#resources)&emsp;&emsp;[6. 面试](#interview)&emsp;&emsp;[7. research](#research2)&emsp;&emsp;[8. news](#news)

<a name="papers"></a>papers:

+ [机器学习 TOP 10 必读论文](https://mp.weixin.qq.com/s/dpb-gAFWhs4YMvGcEBZdqA)
+ [人脸识别技术全面总结：从传统方法到深度学习](https://mp.weixin.qq.com/s/HteNoL3hkjNgUTbGguMflQ)
+ [如何走近深度学习人脸识别？你需要这篇超长综述](https://mp.weixin.qq.com/s/eZ78biXN-mVw3s9Ky_LBZg)
+ [FAIR&MIT提出知识蒸馏新方法：数据集蒸馏](https://mp.weixin.qq.com/s/mFuxCl0Mzv5hmDFewWZkrw)
+ [COLING 2018 最佳论文解读：序列标注经典模型复现](https://mp.weixin.qq.com/s/VCeEz5QhGqQ5TF0lkCk40A)
+ [何恺明大神的「Focal Loss」，如何更好地理解](https://mp.weixin.qq.com/s/Duouc-ErqGqO4aTNA0NiyA)
+ [就喜欢看综述论文：情感分析中的深度学习](https://mp.weixin.qq.com/s/MHxxBgfiQt1Fzkpco3Uoig)
+ [基线系统需要受到更多关注：基于词向量的简单模型 ACL 2018论文解读](https://mp.weixin.qq.com/s/BHA-tFCQjvhf1Tj53SBEaw)
+ [CVPR 2018 最佳论文解读：探秘任务迁移学习](https://mp.weixin.qq.com/s/yhSCa_4GwrG0dnjJPFk2FQ)
+ [顶会论文轮番炸场，本周哪些论文最值得读](https://mp.weixin.qq.com/s/2kpwRzoL96saubV6p7istw)
+ [漫谈深度网络的泛化，从Loss Surface到Deep Image Prior](https://mp.weixin.qq.com/s/X2UbOO_dm-at5qbZPMhjzg)
+ [机器学习5年大跃进，可能是个错觉](https://mp.weixin.qq.com/s/r143qYj8bziu_N-27RWRRw)
+ [近期有哪些值得读的QA论文？专题论文解读](https://mp.weixin.qq.com/s/XFovumX2PZ0cEpEsRCTE9w)
+ [深度森林第三弹：周志华组提出可做表征学习的多层梯度提升决策树](https://mp.weixin.qq.com/s/bE9BZQ6wCICvrgomdySDuw)
+ [自然语言处理(3)之词频-逆文本词频（TF-IDF）详解](https://mp.weixin.qq.com/s/QsmEdCqAjiEhkFJl2ad2Aw)
+ [还在熬夜憋思路？这12篇最新论文打包送给你](https://mp.weixin.qq.com/s/7gFA_KfCdjCNlMNCccbX3g)
+ [一文看懂虚假新闻检测（附数据集 & 论文推荐)](https://mp.weixin.qq.com/s/Emlzfgoo99T9xAsTKJRQXg)
+ [GitHub标星3600：最会编故事的OpenAI语言模型，现已加入PyTorch BERT豪华阵容](https://mp.weixin.qq.com/s/W9n96-yw4n0NzBmiObsX4g)
+ [人工智能：长相越「娘」颜值越高](https://mp.weixin.qq.com/s/5ifqvZCyx-mLEEZD90NS9A)
+ [机器学习中如何处理不平衡数据](https://mp.weixin.qq.com/s/x48Ctb0_Eu1kcSGTYLt5BQ)
+ [这份攻略帮你「稳住」反复无常的 GAN](https://mp.weixin.qq.com/s/I7mpy5P7LFFkop618ANLtA)
+ [Science：人工智能的发展离不开神经科学，先天结构或是下一个方向](https://mp.weixin.qq.com/s/cZNtUwpXQudFaM3dN1UOaw)
+ [152页简明《计算机视觉》入门教程下载，带你回顾CV发展脉络](https://mp.weixin.qq.com/s/eRoZ2309KaPKbhMZZzsWTA)
+ [深度学习中 Pooling 运算汇总](https://mp.weixin.qq.com/s/ISvHyUrXpxGTCMVib-ptnw)
+ [逆天的GPT-2居然还能写代码（但OpenAI却被无情吐槽）](https://mp.weixin.qq.com/s/zBd-EEdGd1F4rcclwhPmhQ)
+ [刷新一次，生成一张逼真假脸：用英伟达StyleGAN做的网站，生出了灵异事件](https://mp.weixin.qq.com/s/Rgi6Yxy-kS5y8ui20aU3vg)
+ [从此再无真「相」！这些人全部是AI生成的](https://mp.weixin.qq.com/s/Um7rDXxhhfzkWpuyhoTRJA)
+ [结合人工智能的高性能医学：现状、挑战与未来](https://mp.weixin.qq.com/s/u-taX_kQXX2sBW8sT6ZZYg)
+ [如何利用深度学习模型实现多任务学习？这里有三点经验](https://mp.weixin.qq.com/s/MPhKUosKZbLtVjJ1XYGXYA)
+ [AI自动识别移动应用代码bug：详解Facebook Infer](https://mp.weixin.qq.com/s/0SnD7yDGlXAjnWCuzSdGRA)
+ [效率提高50倍！谷歌提出从图像中学习世界的强化学习新方法](https://mp.weixin.qq.com/s/dlOFM7LuOF2npDP_EaITvg)
+ [一份nlp入门精选资料](https://mp.weixin.qq.com/s/E_p0JWAE1hX1njZRgv6AJg)
+ [深度学习计算机视觉极限将至，我们该如何找到突破口](https://mp.weixin.qq.com/s/jcIaNnT9KHdfLujqppEXAQ)
+ [CV元老、霍金弟子：三大瓶颈扼住深度学习咽喉，破局要靠这两招](https://mp.weixin.qq.com/s/5kFLIOIbK24u0O6m_5jlLg)
+ [常用机器学习实践技巧](https://mp.weixin.qq.com/s/zvhnUiDEvMKiSu3Q_fY7BQ)
+ [详解GAN的谱归一化（Spectral Normalization）](https://mp.weixin.qq.com/s/tWaKMFZ4dQX7kZlT3tiDAQ)
+ [FSRNet：端到端深度可训练人脸超分辨网络](https://mp.weixin.qq.com/s/M8gCrQDtjT1lszsxV2QQKg)
+ [李沐等将目标检测绝对精度提升 5%，不牺牲推理速度](https://mp.weixin.qq.com/s/flXzhQ-Ypf3fwTqLelLzOQ)
+ [迄今最大模型？OpenAI发布参数量高达15亿的通用语言模型GPT-2](https://mp.weixin.qq.com/s/ZitIqX-9MNk6L1mAC_AwBQ)
+ [逆天的语言AI模型来了！编故事以假乱真，问答翻译写摘要都行，横扫各大语言建模任务](https://mp.weixin.qq.com/s/Viyc66ywVBsrnQUdYvK8ow)
+ [朴素贝叶斯算法的优缺点](https://mp.weixin.qq.com/s/Oxfa6Xvqx5BCO46CMGZB-w)
+ [AAAI 2019教程—361页PPT带你回顾最新词句Embedding技术和应用](https://mp.weixin.qq.com/s/XyWjmDUIgiuiX5YBPVFDEA)
+ [能量视角下的GAN模型（二）：GAN＝“分析”＋“采样”](https://mp.weixin.qq.com/s/uGuywTY33SrYERDO522N1Q)


<a name="python-and-dl"></a>python and deep learning:

+ [最全 Python3 函数知识点大全](https://mp.weixin.qq.com/s/B-0guaWa8_9LC8mH6E955Q)
+ [一份鲜为人知的Python特性](https://mp.weixin.qq.com/s/zUXlULqTdczxJPXgM-Lqog)
+ [学习Python，怎能不懂点PEP呢？](https://mp.weixin.qq.com/s/Wh6RvMyb19Yg3b14xaPITw)
+ [教你用 Cython 自己造轮子](https://mp.weixin.qq.com/s/M0qDLibbM9-c1fw6wQNvFA)
+ [TensorFlow 程序员的自我修养](https://mp.weixin.qq.com/s/BKCj21AQ2OOXVGGrkR5ZwQ)
+ [据说这篇总结覆盖了一般Python开发面试中可能会问到的大部分问](https://mp.weixin.qq.com/s/OiCYxJXbLaYM53N6wnoLzA)
+ [302页吴恩达Deeplearning.ai课程笔记，详记基础知识与作业代码](https://mp.weixin.qq.com/s/qBRw5ZPERKWfjC49k4_Ngg)
+ [吴恩达deeplearning.ai第5课开课了：敲黑板序列模型](https://mp.weixin.qq.com/s/H3LBRROH4W3xX5QFZAyk3w)
+ [吴恩达Deeplearning.ai课程学习全体验：深度学习必备课程(已获证书)](https://mp.weixin.qq.com/s/SFSn1zplMmJAYf85EBxBkg)
+ [不吹不擂，你想要的Python面试都在这里了【315+道题】](https://mp.weixin.qq.com/s/mme6OPNM-QvOwuojwmU40g)
+ [Python黑魔法：元类](https://mp.weixin.qq.com/s/Ipy_P6Uoaj6h3Kdg5U9dbA)
+ [GPU编程入门课程：使用CUDA C/C++进行并行计算加速](https://mp.weixin.qq.com/s/SAB0MTwSczrS17uuZsEYKw)
+ [请快点粘贴复制，这是一份好用的TensorFlow代码集](https://mp.weixin.qq.com/s/ggfrhp8R6rIPWgY0BPHNWA)
+ [Python面试攻略之基础概念篇](https://mp.weixin.qq.com/s/TtJyeCZ27fI1dyd18kCl-Q)
+ [强推！《PyTorch中文手册》开源！附资源下载链接](https://mp.weixin.qq.com/s/U3gDLs19dvPesa3f_bfmng)
+ [浏览器上跑：TensorFlow发布实时人物分割模型，秒速25帧，24个部位](https://mp.weixin.qq.com/s/vjpMr3TsF3Lui8Q0IstQxw)

<a name="cs-basis"></a>cs基础:

+ [计算机科学中最重要的 32 个算法](https://mp.weixin.qq.com/s/izVt4O-qm-Y9ZrYQFrrLaA)
+ [176条DevOps人员常用的linux命令速查表](https://mp.weixin.qq.com/s/Z0dsHroFvoqG-rX9a-_SJw)
+ [黑客常用linux入侵常用命令，有你不知道的没](https://mp.weixin.qq.com/s/PKYbkkqltHy5AaDRiE4Y_Q)
+ [Linux 新手必会的21条命令合集](https://mp.weixin.qq.com/s/L5rmy0LLBVoiyMjDrFH2BA)
+ [最全的常用正则表达式大全](https://mp.weixin.qq.com/s/sLYRGDn0lCEG_TCL2N6gXA)

<a name="tools"></a>tools:

+ [写给新手的十一条 Docker 守则](https://mp.weixin.qq.com/s/h69P9QHrqO7Lpl1uhbW7aQ)
+ [把docker镜像当作桌面系统来用](https://mp.weixin.qq.com/s/xSeAGQn8UZqVlrtS3dfSiA)
+ [能当主力，能入虚拟机，还能随时打包带走，Linux 就是这么强大](https://mp.weixin.qq.com/s/sSAyJ3r2zgNRleOzfqPXfA)
+ [作为一个有追求的科研党，电脑上必备哪些软件](https://mp.weixin.qq.com/s/PIBGo3hHpXNxjJa5sJVlvw)
+ [Linux架构之HA配置](https://mp.weixin.qq.com/s/ILnyHnWSabAgkWf2w_Gbuw)
+ [练了一年再来总结的 Vim 使用技巧](https://mp.weixin.qq.com/s/K6bDZf2w_G16T1RxzlRBfw)

<a name="resources"></a>资源:

+ [深度学习资源一网打尽！论文、数据集、框架、课程、图书等应有尽有](https://mp.weixin.qq.com/s/P5p1h3x_ovWjYQsVTK1eug)深度学习的hao123
+ [斯坦福CS230官方指南：CNN、RNN及使用技巧速查（打印收藏)](https://mp.weixin.qq.com/s/nL5_tF7WkL9YMjNAagc_eg)
+ [资源-机器学习标准教科书PRML的Python实现](https://mp.weixin.qq.com/s/-UqoGXbQqewYs2IyuED6Iw)
+ [PaddleFluid和TensorFlow基本使用概念对比 PaddlePaddle专栏](https://mp.weixin.qq.com/s/G8hUNK5hyZPDHt9JRROMKw)
+ [书单, 计算机视觉的修炼秘笈](https://mp.weixin.qq.com/s/6Oo2w-AZEf09I_QNRV154w)
+ [书单, NLP秘笈，从入门到进阶](https://mp.weixin.qq.com/s/7m90zihmoGZABP7Ib4aYIA)
+ [150多万张“不可描述”照片数据集新鲜出炉，这次一定不要在办公室打开](https://mp.weixin.qq.com/s/7DDrIi0nL4n70r54KsgzUw)
+ [李宏毅: 286页的《一天搞懂深度学习》下载](https://mp.weixin.qq.com/s/5DBCzR4fBq-AvVDnv2xzYw)

<a name="interview"></a>面试:

+ [用动画的形式呈现解LeetCode题目的思路](https://github.com/MisterBooo/LeetCodeAnimation)
+ [技术面试必备基础知识](https://github.com/CyC2018/CS-Notes)
+ [假期快乐！超强面试资源等你Pick，先收藏](https://mp.weixin.qq.com/s/KatYnzpNF8lH0aqM1ns7gA)
+ [掌握这几点，2个月拿下春招30W+offer](https://mp.weixin.qq.com/s/_LE566Hw_w4xJahnKsaTUg)
+ [阿里电话面试(算法工程师)](https://mp.weixin.qq.com/s?__biz=MjM5MDAxNjkyMA==&mid=2650739651&amp;idx=1&amp;sn=ba5dd12f9d2f17cdbb398632c960792f&source=41#wechat_redirect)
+ [图像处理笔试面试题](https://mp.weixin.qq.com/s/xa30KbIgG63isqH-HooreA)
+ [机器学习岗面试，这些是基础！(ML,DL,SL相关知识整理)](https://mp.weixin.qq.com/s/nHM5wB3N9Igb6gM2HumejA)
+ [我是如何一步一步拿下Google offer的](https://mp.weixin.qq.com/s/MBEszLMzSFtG-ZijIsjwqA)
+ [头条 Python 工程师面经分享：一年经验也能进大公司](https://mp.weixin.qq.com/s/TU-Cr3UkACg2J-Dh7iuUbw)

<a name="research2"></a>research:

+ [我的八年博士生涯——CMU王赟写在入职Facebook之前](https://mp.weixin.qq.com/s/TrDYumRxdwWvYS9oc5xGqA)
+ [求生之路：博士生涯的17条简单生存法则](https://mp.weixin.qq.com/s/x44ZoYj1IU1PfF4BN-ZV5g)
+ [苏步青谈读书与做题](https://mp.weixin.qq.com/s/rjbfB9FMUkPz-Pa1rvkZjA)
+ [解决做好一个机器学习项目的3个问题](https://mp.weixin.qq.com/s/yvPWxVz1pL2OoBstd7HlbQ)

<a name="news"></a>news:

+ [华为82位博士离职](https://mp.weixin.qq.com/s/3wml2IhCNnLPRZ4P9CDbkg)
+ [AI大牛LeCun：Python该过时了！深度学习需要新编程语言](https://mp.weixin.qq.com/s/t5MsHY6cAvncmkd_Xq8AtQ)
+ [Yann LeCun：未来的AI芯片应该这样做](https://mp.weixin.qq.com/s/Y5zcKTlYctWNk1KW35yNDw)
+ [阿里巴巴达摩院发布2019十大科技趋势](https://mp.weixin.qq.com/s/Bp-vkWZW0YdWECxQ5dYACA)
+ [一位 70 后程序员的 26 个职场感悟](https://mp.weixin.qq.com/s/pbeFN8ZfN-jCvAfbvnus3Q)

#### <a name="long-hy-work-trick"></a> ___工作方法___

+ 总体把握，了解各个平台特点，能做些什么，尽量把潜在的问题挖掘出来
+ 偏向研究的任务: 除了算法本身外业务不熟悉的地方需要及时提出，或者说为了加快进度提出业务资源, 这样做也能更好的给算法确定输入输出边界
+ 偏向工程的任务多向开发人员请教
+ 在提升综合能力这样的定位下有没有什么高效的执行方法？比如这次我遇到的问题：在算法没完全稳定下来的时候再接入windows平台，里面一个比较小的一个问题都会花费我比较长的时间，甚至里面有些配置在网络上搜都很难，最后是通过电话沟通才知道怎么操作。windows平台问题最多，但类似的这样的问题在我做其他平台的时候同样会出现.

### <a name="month-plan"></a> 月安排

#### <a name="april"></a> ___9月:___

___重点:___

+ pytorch、论文、硬件知识
+ 计算机基础
+ tmux

___tracking:___

+ 看Hnotes中红贴和archive1(中c++部分)帖子
+ 虚函数和纯虚函数的区别, 应用场景
+ 人脸对齐方法总结(option:人脸对齐dlib)
+ TTS初步调研
+ 把卷积和rnn的教材看了并整理笔记, 复习
+ 把8.4Permutations II的有重复元素的全排列代码中涉及的c++愈发知识熟悉下
+ 8.6涉及到的C++字符串语法熟悉下
+ 工银亚洲、港澳通行证
+ [看一下: 明无梦-books](https://www.dreamxu.com/books/)

### <a name="Timetable"></a>作息时间

| 时间                  | 安排                                      |   周期            |
| ------------          | ---------------                           |------------       |
| _6:00~6:30_           | _起床、洗漱_                              | _[1-7]_           |
| __6:30~9:00__         | __英语1h、刷1题、计划今天、处理邮件__     | __[1-7]__         |
| _9:00~12:10_          | _工作;刷题_                               | _[1-6;7]_         |
| __12:10~13:30__       | __吃饭、休息__                            | __[1-7]__         |
| _13:30~18:00_         | _工作;归档本周、下周计划、刷题or玩_       | _[1-6;7]_         |
| __18:00~19:00__       | __休息、刷1题__                           | __[1-7]__         |
| _19:00~22:00_         | _工作;玩or佛经_                           | _[1-6;7]_         |
| __22:00~23:30__       | __汇报、整理、复习notes、刷题;佛经or玩__  | __[1-6;7]__       |
| _23:30~00:00_         | __洗漱、睡觉__                            | __[1-6;7]__       |

+ <font color="ff0000">ps: 月初周六干自己的事情; 周三记得写第二天的材料;1、4、7是运动日</font>

### <a name="Idea"></a>Idea

+ 对于实时人脸对齐，能否把$\delta x$当作attention，形状当作predicate，然后也利用这种转移的思想，同理dynamic MRI能否也利用这个思路。
+ 我想做个榫卯vr app

### <a name="Will-search"></a>遗留问题汇总

>* C、C++的封装，用C实现C++的封装，C的函数指针模拟多态(笔记记录在today中)
>* #define bzero(s, n) memset((s), 0, (n));
>* 动态链接库
>* C、C++如何调用私有api
>* Git下常建立几个分支
>* 如何让别人参与开发
>* C和C++的差异
>* 信号量，chengyi的那部分锁代码
>* 堆对象、栈对象
>* source tree
>* git管理自己的笔记
>* 怎样调私有接口
>* CFRetain
>* 内存泄漏经验
>* 串行、并行、并发
>* 借助macvim+正则表达式分析日志
>* 抓包工具 wireshark
>* cpu工具，Time Profile
>* 熟悉storyboard, 了解控件的布局，层级关系
>* 查看系统日志
>* 看内存，看CPU
>* run loop原理
>* Xcode使用技巧，学会看内存、CPU，向chengyi咨询查看系统日志的方法等技能性的经验
>* Xcode中对项目的配置, 联调
>* shell常用操作
>* ios打点
>* C++有没有类似ios黑魔法的玩意儿
>* [scale jittering的工作原理是什么---VGG Net的数据增强策略](https://arxiv.org/pdf/1409.1556v6.pdf)

##### Wed Jun 20 23:22:11 CST 2018

>* 熟悉双目/TOF相机的工作原理(1 day for breadth)
>* 机器人平台多传感器标定算法的设计与开发
>* CUDA/OpenCL优化, FPGA算法开发经验
>* 目标检测与跟踪、姿态估计、图像分割涉及的常用算法(cv domain knowkedge)
>* Vanishing gradient problem. [ref1](https://en.wikipedia.org/wiki/Vanishing_gradient_problem), [ref2](https://www.quora.com/What-is-the-vanishing-gradient-problem)
>* 内存泄漏分析
>* 这里要做的一个调研是：ResNet50和VGG19这两个卷积网络的各自优缺点。
>* [keras中的Embedding和word2vec -> 利用Glove、Google-News以及FastText训练出来的word2Vec模型(pre-trained)以及keras的接口来做任务](http://www.flyml.net/2017/11/26/deepnlp-keras-pre-trained-word2vec-explaination/)。
>* Dense层的作用
>* Dropout层的作用
>* Lambda层的使用以及作用，注意不是python中的那个小写的lambda哦
>* Activation("tanh")的使用以及作用
>* 几个优化器的对比`RMSprop`, `Adam`, `Adagrad`, `Adadelta`, 有空手动实现一把
>* cross entropy的具体算法是什么，即如何利用y_truth和y_predict来计算cross entropy
>* 最终整理完这份代码后，给自己写出第一份基于keras的框架出来(很重要)
>* 有了这些直观感受后看一遍keras中文文档
>* dense graph inference can be approximated by mean field in Conditional Random Fields(CRF)
>* fully differential inference assuming weighted gaussians as pairwise potentials
>* messaging passing during inference is a series of learnt convolutions.
>* soft attention
>* Rectified Linear Unit operator(ReLU)
>* 编译、链接问题的搜集(从内部论坛开始，最好自己辅助些代码)
>* ACK
>* 为什么atomic也不一定是线程安全的, 以及@synchronized关键字的使用
>* 如何看ojbdump -h a.out的信息
>* pimpl模式、桥接模式；思考结构体加字段的问题。
>* 用pimpl处理这个问题:"把结构体的实现隐藏起来，用一个固定布局的壳对接口进行转发；缺点：多了一次指针访问，多一次内存申请与释放，性能有所损耗, 手工编写plmpl模式代码、枯燥繁重"
>* C++ 工程实践经验谈-陈硕
>* 把March里的文档总结在我自己的笔记里
>* review singleton代码
>* tensorflow predict加速

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
