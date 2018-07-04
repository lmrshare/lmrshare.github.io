---
layout: post
title: "作息时间以及计划"
date: 2018-05-21
description: "不在主页显示"
tag: HNotes
---

## 介绍

从研一开始坚持作息时间，这么多年还是未能严格按照时间表来走，还是会经常犯懒耍赖，还是希望自己越来越进步吧，好想体验像机器人工作的感觉。加油，上进又风骚的学者。

### 目录

* [Month IDP](#This-month)
* [作息时间](#Timetable)
* [待查](#Will-search)
* [Idea](#Idea)
* [长期计划](#Long-term-plan)
* [总结](#Summary)

### <a name="This-month"></a>Month IDP

*  ___1.___ CNN理论、在face alignment上的应用、在MRI上的应用(7.03~7.08)
*  ___2.___ RNN理论、在韵律预测上等相关应用(7.09~7.15)
*  ___3.___ 对PRML中的非线性方法如: SVM、神经网络完整推倒一遍并做串联(7.16~7.22)
*  ___4.___ 深度学习相关工程经验：把网络设计与优化、模型压缩与裁剪、之前遇到的问题、前面的笔记, 自己的研究生经历完整的写一篇博文出来(7.23~7.29)
*  ___5.___ 整理个人主页达到可以对外开放的程度、整理完后制定下一个Month IDP(7.30~8.05)
*  ___6.___ 整理以前做过的题+33道题(7.03~8.05)
	

### <a name="Timetable"></a>作息时间

>*  6:45~7:30-- 起床、英语电台(1-7)
>*  7:30~8:00~9:00-- 刷题(两个问题, 一新一旧)[1-7]
>*  9:00~9:30--吃饭、看邮件、rtx消息[1-7]
>*  9:30~12:10--工作[1-6], 周IDP and 整理消化本周刷的题[7]
>*  12:10~13:10--吃饭、溜达、睡觉[1-7]
>*  13:10~14:10--周IDP[1-7]
>*  14:30~18:00--工作[1-6]、周IDP and 整理消化本周刷的题[7]
>*  18:00~20:00--周IDP[1-7]
>*  20:00~23:00--工作[1-5]，周IDP and 整理消化本周刷的题[6、7]
>*  23:00~23:30--总结今日工作明日任务、清理work_tmp、添加待查和处理待查[1-6]、休息[7]
>*  23:30~00:00--听力(1-6)
>*  00:00~02:30--周IDP(1-6)


### <a name="Will-search"></a>待查

>* 单例
>* NSData
>* plist
>* [iOS 文件目录](https://www.jianshu.com/p/572edba1ff9d)
>* C、C++的封装，用C实现C++的封装，C的函数指针模拟多态
>* 动态链接库
>* C、C++如何调用私有api
>* nm分析静态库，如何利用反编译看源代码
>*  Git下常建立几个分支
>*  如何让别人参与开发
>*  C和C++的差异
>*  动态代理
>*  信号量，chengyi的那部分锁代码
>*  堆对象、栈对象
>*  iOS使用GCDSocketManager实现长连接, GCDAsynvsockt源码分析
>*  “界面绘制的比较多，堆栈全是系统函数，这种很难定位原因. 下个版本我把时间设置长点，过滤掉全是系统函数的堆栈”---探究出soap师兄这段描述所涉及的经验
>*  直连、走公网、公网带宽，带宽很高容易丢包
>*  NSLog 加标签
>*  背诵<以父之名> pos: Spit it out already. I’m busy.
>*  WWDC17 的AR和machine learning
>*  source tree
>*  git管理自己的笔记
>*  试着把人脸对齐的matlab代码提交到公网
>*  为什么占位符改了就好了, 我现在给出的解释就是：接收端的请求有没取到的，导致发送端有数据累积，越来越多后导致程序jetsam。最好后续给出模拟现场的实验(undone)
>*  ack
>*  tcp通信，物理隔离
>*  为什么栈有“容易恢复现场”的特性
>*  code signing entitlements、code signing identity、provisioning profile是干什么的, xx.entitlements里的App Groups有什么作用
>*  how to read code
>*  接收端口异步线程分析
>*  怎样调私有接口
>*  CFRetain
>*  Info.plist文件详解(看简书)
>*  详解SVN 的使用(看简书)
>* `GCDAsyncServerSocketCommunicationManager`属性中的选项含义
>* `+ (nullable GCDAsyncServerSocketCommunicationManager *)sharedInstance;`单例、`instancetype`关键字
>* 内存泄漏经验
>* 串行、并行、并发
>* 接口中的属性和property有什么区别
>* 为什么像下图这么写
>* 线程不安全的对象
>* 借助macvim+正则表达式分析日志
>* 提代码的时候我把易办的代码冲掉了，调查下原因。
>* 抓包工具 wireshark
>* 哥们儿！到底啥是硬解
>* CGI是个啥玩意儿
>* 为了解决性能问题，现在利用硬编的方式，查询："硬编框架"、"h264 encode"
>* cpu工具，Time Profile
>* 保活仍存在问题，就是播放音乐的时候偶尔会保活失败，我要做的事情：a. 能否抢占回来[WXCSysCallback的-(void)handleAudioInterruption:(NSNotification* )notify]
>* 现在还是会偶尔出现50M的问题，这个可以根据页面的返回信息进行判断，“基本可以确定类型”
>* springer搜索关键字：“machine learning, english, book”, 下次从第九页开始收集，顺便收集下与nonlinear programming相关的文章。
>*  堆对象、栈对象
>*  iphone的run loop原理
>*  网络、协议; 定协议，痛殴service与后台交互，进行收发数据
>*  回掉
>*  熟悉storyboard, 了解控件的布局，层级关系
>*  查看系统日志
>*  看内存，看CPU
>*  二维码OC逻辑
>*  VOIP的OC逻辑
>*  做一个与wework一样的UI交互界面
>*  run loop原理
>*  Start Developing iOS Apps Today(OC version)
>*  Xcode使用技巧，学会看内存、CPU，向chengyi咨询查看系统日志的方法等技能性的经验
>*  着手weworkUI界面demo的开发(a. 从头写个最简单的demo, b. 借助storyboard写界面程序)
>*  Xcode中对项目的配置, 联调
>*  shell常用操作
##### Wed Jun 20 23:22:11 CST 2018
>* [刨根问底：对于 self = [super init] 的思考](https://www.jianshu.com/p/9b36e1b636d8)
>* ios层做 libevent这种等级的操作这么容易, c++应该要写一些代码，一般会用libevent库。所以我的问题就是查libevent是啥玩意, c++怎么实现
>* ios打点
>* C++有没有类似ios黑魔法的玩意儿
>* [scale jittering的工作原理是什么---VGG Net的数据增强策略](https://arxiv.org/pdf/1409.1556v6.pdf)
>* 看work_tmp/ui下的文章
>* palindromic substring的所有思路整理完、coding、看比较好的解法
>* 熟悉双目/TOF相机的工作原理(1 day for breadth)
>* 机器人平台多传感器标定算法的设计与开发
>* CUDA/OpenCL优化, FPGA算法开发经验
>* 目标检测与跟踪、姿态估计、图像分割涉及的常用算法(cv domain knowkedge)
>* 搜索C++常用语法技巧
>* 解决voip源码中的待查

### <a name="Idea"></a>Idea

* 对于实时人脸对齐，能否把/delta x当作attention，形状当作predicate，然后也利用这种转移的思想，同理dynamic MRI能否也利用这个思路。

### <a name="Long-term-plan"></a>长期计划

#### PHD

读博流程：

* 上课（一年左右，课程非常严格，上课这一年要留意实验室）----这个阶段又叫做硕士期
* 博士资格考试（提出新兴课题，摆出实验方案，由五人评议小组审核课题的新颖程度，意义和方案可行性。）
* 实验室工作（可能需要补充理论知识，看大量的文献）

注意事项：

* 如果需要某个教授的研究课题更多信息，直接写信给这位教授。如果是关于项目本身的信息，写信给院系的老师。如果想要其他学院的申请流程信息，写信给他们。每个学院的申请流程大不相同，你确实需要直接从该学院获取信息。
* 成功获得录取的因素主要有：好成绩（GRE，专业考试，大学毕业生等）,推荐信（一封向教授证明你的价值的信）,经验（如果有一些有趣的经验，或者对你有利的作品）
* 一下这些因素对申请没有意义：钱（学校不在意你是否承担得起研究生费用）
* 在博士申请的过程中最重要的两样东西是个人陈述和推荐信。某种程度上你的考试成绩也很重要，但是几个百分点的差异不会太在意。

总结：

* 成为某教授博士生正确的申请流程应该是："向研究生院提出申请，被录取，第一年的课程和考试中表现良好，同时，在第一年中，考虑清楚感兴趣的方向。然后再把简历寄给某教授。"

我要准备的工作:

* toefl（100以上），GRE至少1300换算现在的分数就是320，最好可以考1500以上, 所以要有计划的开始背托福和GRE的单词
* 调查mit，斯坦福和宾大的博士课程，学习之
* 调研这几个名校的实验室导师的研究方向，选择后读他们的论文
* 关注计算机视觉中的顶级会议论文
* 为发论文做准备
* 写专利
* 补数学基础
* 补计算机基础(编程基础包括:c++，python,matlab语言的学习和信息学的学习;vim、shell、cmake、latex,gdb等工具的使用)
* 把计算机视觉里的基本书看了，包括：模式识别，机器学习
*  把非线性规划读透
*  把自己的笔记，专利，论文等放到个人主页上提高影响力
*  Vanishing gradient problem. [ref1](https://en.wikipedia.org/wiki/Vanishing_gradient_problem), [ref2](https://www.quora.com/What-is-the-vanishing-gradient-problem)
*  内存泄漏分析
*  这里要做的一个调研是：ResNet50和VGG19这两个卷积网络的各自优缺点。
*  [keras中的Embedding和word2vec -> 利用Glove、Google-News以及FastText训练出来的word2Vec模型(pre-trained)以及keras的接口来做任务](http://www.flyml.net/2017/11/26/deepnlp-keras-pre-trained-word2vec-explaination/)。
*  Dense层的作用
*  Dropout层的作用
*  Lambda层的使用以及作用，注意不是python中的那个小写的lambda哦
*  Activation("tanh")的使用以及作用
*  几个优化器的对比`RMSprop`, `Adam`, `Adagrad`, `Adadelta`, 有空手动实现一把
*  cross entropy的具体算法是什么，即如何利用y_truth和y_predict来计算cross entropy
*  最终整理完这份代码后，给自己写出第一份基于keras的框架出来(很重要)
*  有了这些直观感受后看一遍keras中文文档
*  dense graph inference can be approximated by mean field in Conditional Random Fields(CRF)
*  fully differential inference assuming weighted gaussians as pairwise potentials
*  messaging passing during inference is a series of learnt convolutions.
*  [CRNN用于动态核磁共振成像的论文](https://arxiv.org/pdf/1712.01751.pdf)
*  soft attention
*  Rectified Linear Unit operator(ReLU)
*  编译、链接问题的搜集(从内部论坛开始，最好自己辅助些代码)
*  ACK是什么
*  为什么atomic也不一定是线程安全的, 以及@synchronized关键字的使用
*  如何看ojbdump -h a.out的信息
*  pimpl模式、桥接模式；思考结构体加字段的问题。
*     用pimpl处理这个问题:"把结构体的实现隐藏起来，用一个固定布局的壳对接口进行转发；缺点：多了一次指针访问，多一次内存申请与释放，性能有所损耗, 手工编写plmpl模式代码、枯燥繁重"
*  C++ 工程实践经验谈-陈硕
*  把March里的文档总结在我自己的笔记里

### <a name="Summary"></a>总结

其实目前我最紧急的任务是: "英语和paper，由于我的成绩特别烂，所以我这两项要突出. 同时把选定导师的论文弄清楚。"

___长期任务:___

* 博士课程和论文的跟踪，这两点我做的很好的（课程非常熟练，申博前尽量有个初步的新型课题课题）的话，可以较为顺利的进入博士的实验阶段。
* 我把自己觉得重要的基础，比如：数学、计算机、非线性规划以及模式识别和机器学习相关的基本好书透彻的啃完，那么我就可以全身心专注于我的问题，而不是把大块时间浪费在补充基础上面。

___总目标:___

* __数学：__ 统计推断，数学分析，矩阵论，测度论＋实分析
* __与求解相关的理论：__ 凸优化，非线性规划；数值分析
* __tools相关：__ c，c＋＋，opencv；计算机网络；git，shell，vim，linux下的c编程（编译，调试gdb）；makefile的书写；
* __领域：__ 模式识别，机器学习，人工智能；音视频（数字信号处理）
* __小领域：__ OCR文字识别，深度学习，VR，AR，人脸检测，人脸标记
* __学术：__ 跟踪模式识别，机器学习，人工智能的论文；aec相关的文献
* __英语：__ 六级单词，六级阅读，雅思单词，雅思真题

* __音视频__: 数字信号处理，数据通信与网络，语音信号处理，VOIP，webrtc（主要是aec），视频处理（ffmpeg ），图像处理
* __模式识别、机器学习、人工智能入门知识__: Ng，林轩田的机器学习视频，（周志华的机器学习＋机器学习实战＋统计学习方法），模式分类

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
