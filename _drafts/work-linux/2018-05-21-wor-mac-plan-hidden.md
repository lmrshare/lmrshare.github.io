---
layout: post
title: "作息时间以及计划"
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

| [Research](#long-research)                  |[计算机基础与工作经验](#cs-work)     |[季度安排](#quarter-plan)                                          |
| ------------                                |-------------------------------------| ------------------------------------------------------------      |
| _[Computer Vision](#long-re-cv)_            |  _[计算机基础](#long-hy-cb)_        | _[11月: 博客、刷题、工程资料搜集](#november)_                     |
| __[MRI](#long-re-mri)__                     |  __[项目相关](#long-hy-engineer)__  | __[12月: 项目、基础、刷题](#december)__                           |
| _[Optimization Method](#long-re-om)_        |  _[工作方法](#long-hy-work-trick)_  | _[1月: 复习、面试、基础、刷题](#january)_                         |
| __[Domain Knowledge](#long-re-dk)__         |  __[-]()__                          | __[2月: Research、Unity、面试、季度总结和下季度计划](#february)__ |
| _[Math](#long-re-math)_                     |  _[-]()_                            | _[-]()_                                                           |
| __[English](#long-re-eng)__                 |  __[-]()__                          | __[-]()__                                                         |
| _[Writing&Blog](#long-re-wb)_               |  _[-]()_                            | _[-]()_                                                           |
| __[Other](#long-re-other)__                 |  __[-]()__                          | __[-]()__                                                         |

[ps: 备注](#remark)

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

>* toefl（100以上），GRE至少1300换算现在的分数就是320，最好1500以上

#### <a name="long-re-wb"></a> ___Writing& Blog___

>* all in blog

#### <a name="long-re-other"></a> ___Other___

>* 调研几个名校的实验室导师的研究方向，选择后读他们的论文
>* 调查mit，斯坦福和宾大的博士课程

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
>* 好好理解企业微信移动端（企业微信做的很好），先看下runloop，然后看一个service，看网络，db的安排，connection favorivate service
>* 企业微信怎么做长连接和短连接的，这里企业微信做的還不錯

___网络(tcp/ip http)___

>* TCP/IP高效编程
>* 滑窗等理论的细节
>* 你怎么做长连接
>* 了解Https协议，了解操作；http协议
>* udp: 视频动画、VoIP；用udp实现可靠的连接，udp打洞
>* ios怎么抓包
>* 网络调优，特别是移动端（移动端容易断）、心跳、接入点变化（WIFi to 4G），在km上搜移动端网络调优

___性能调优, db___

>* sql调优
>* google：ios性能调优工具

#### <a name="long-hy-engineer"></a> ___项目相关___

>* 企业微信框架特点：存储架构、消息架构、UI模型
>* 客户端整体架构：数据存储、网络请求、中间逻辑有哪几层
>* UI 到底层，然后再从底层回去，VOIP的信令流程
>* 企业微信框架特点：存储架构、消息架构、UI模型
>* 客户端整体架构：数据存储、网络请求、中间逻辑有哪几层
>* UI 到底层，然后再从底层回去，VOIP的信令流程, aec
>* 把投屏的流程： 跨进程通道，如何复用voip协议，把图画出来
>* 企业微信框架主要做业务的时候带着问题去了解
>* 客户端最常用设计模式：proxy、observer
>* 音视频: 数据通信与网络，语音信号处理，视频处理(ffmpeg)

#### <a name="long-hy-work-trick"></a> ___工作方法___

>* 总体把握，了解各个平台特点，能做些什么，尽量把潜在的问题挖掘出来
>* 偏向研究的任务: 除了算法本身外业务不熟悉的地方需要及时提出，或者说为了加快进度提出业务资源, 这样做也能更好的给算法确定输入输出边界
>* 偏向工程的任务多向老员工请教
>* 在提升综合能力这样的定位下有没有什么高效的执行方法？比如这次我遇到的问题：在算法没完全稳定下来的时候再接入windows平台，里面一个比较小的一个问题都会花费我比较长的时间，甚至里面有些配置在网络上搜都很难，最后是通过电话沟通才知道怎么操作。windows平台问题最多，但类似的这样的问题在我做其他平台的时候同样会出现.

### <a name="quarter-plan"></a> 季度安排

#### <a name="november"></a> ___11月: 博客、刷题、工程资料搜集___

&emsp;&emsp;__这个月主要集中突击一把，侧重点在于22号的时候个人站可以po到linked上, 同时别忘了英语面试的准备工作.__

___11.12~.11.18:___

>* 把leetcode做过的题目整理成项目方便日后刷题, 然后开始快速复习到19:00, 并记录下复习进度, 19:00开始总结出信息学的所有题型, 然后指定后几天的刷题计划. 牛客100道面试题以C++为主,(1day)
>* crf11,15成文(done), leetcode:5~15每个题型一个并复习ch2, 牛客100道, 如果有时间开始搜km文章以及活水岗位(2days)
>* ADMM-net MRI和CNN SR, 刷leetcode题, 计算机视觉面试题1套(1day)
>* 人脸对齐方法总结(option:人脸对齐dlib), 刷leetcode题, 计算机视觉面试题1套(1day, 11.16)
>* TTS初步调研, 刷leetcode题, 牛客复习昨天的题、新题50道(1day, 11.17[周六])
>* 整理个人站, 确定接下来的博文, 计算机视觉面试题1套, 刷leetcode题, 牛客复习昨天的题、新题50道, 制定后几天的计划(1day, 11.18[周日])
>* 投简历(11.19)

___7天总结:___

&emsp;&emsp;xxxxxx

___ps:___

>* 回家之前整理工程资料(every day, tensorflow, caffe, 以及他们的predict调优, 服务器部署流程以及注意事项)
>* 调研面试google的技巧以及外企面试需要的英语材料

___总完成度:___

| ------------          | ---------------          |------------|
| _11:12: 3_           | _11:13: 2_            | _11:14: 3_    | _11:15: ?_    | _11:16: ?_    | _11:17: ?_    | _11:18: ?_    | _11:19: ?_    | _11:20: ?_    | _11:21: ?_    | _11:22: ?_    |
| _11:23: <font color="#ff0000">deadline</font>_           | _11:24: ?_            | _11:25: ?_    | _11:26: ?_    | _11:27: ?_    | _11:28: ?_    | _11:29: ?_    | _11:30: ?_    | _none_    | _none_    | _none_    |


#### <a name="december"></a> ___12月: 项目、基础、刷题___

&emsp;&emsp;__这个月侧重与计算机基础，丰富个人站，以及深度学习项目的主流开发工具(tensorflow, caffe, 以及他们的predict调优, 服务器部署流程以及注意事项)__

___12.22~.12.25:___

>* 看Hnotes中红贴和archive1(中c++部分)帖子, 解决interview中面试出现的问题
>* 牛客100道面试题以C++为主,(1day)
>* 复习、刷leetcode、排序题型 
>* km文章
>* 计算机视觉面试题1套
>* 复习博客

近期面试:

>* 华为: 到北京后可联系hr第一时间确定面试(20号以后)
>* PonyAI(自己联系的, 岗位jd参考stacey): 2018年12月26日 星期三, 19:30(电话面试)

未安排和待处理问题列表:

>* YY语音(stacey):
>* 工银亚洲、港澳通行证
>* 把8.4Permutations II的有重复元素的全排列代码中涉及的c++愈发知识熟悉下
>* 8.6涉及到的C++字符串语法熟悉下
>* 跟两个猎头stacey和徐春琳碰头

___4天总结:___

&emsp;&emsp;xxxxxx

___总完成度:___

| ------------          | ---------------          |------------|
| _12:22: ?_           | _12:23: ?_            | _12:24: ?_    | _12:25: ?_    | _12:26: ?_    | _12:27: ?_    | _12:28: ?_    | _12:29: ?_    | _12:30: ?_    | _12:31: ?_    |


#### <a name="january"></a> ___1月: 复习、面试、基础、刷题___

&emsp;&emsp;__希望这个月以复习为主，个人站比较完善、漂亮. 可达到随时可面试的程度__

#### <a name="february"></a> ___2月: Research、Unity、面试、总结调整___

&emsp;&emsp;__随时可面试，准备Unity的学习, 以及榫卯app的开发准备__

#### <a name="remark"></a> ___备注:___

&emsp;&emsp;__以前制定计划多数时候都在闭门造车，对于算法还好，但是在工作中明显吃了亏，所以下半年针对工程经验这一块，结合过来人的经验以及应试制订了半年计划，执行起来很简单，要满足：__

>* 每准备一块内容后就要写一篇博文出来，同时以面试题作为应试检验
>* 博文写好后给有经验的人看一下，然后完善之

### <a name="Timetable"></a>作息时间


| 时间                  | 安排                     |   周期     |
| ------------          | ---------------          |------------|
| _6:30~7:00_           | _起床、洗漱_             | _[1-7]_    |
| __7:00~10:00__        | __写博客__               | __[1-7]__  |
| _10:00~12:30_         | _写博客or工作;下周计划_  | _[1-6;7]_  |
| __12:30~14:00__       | __吃饭、休息、健身__     | __[1-7]__  |
| _14:00~18:30_         | _写博客or工作_           | _[1-7]_    |
| __18:30~19:00__       | __吃饭、休息__           | __[1-7]__  |
| _19:00~00:00_         | _刷题or工作_             | _[1-7]_    |
| __00:00~01:00__       | __背面试口语材料__       | __[1-7]__  |
| _01:00~01:15_         | _打分、制定明日计划_     | _[1-7]_    |

### <a name="Idea"></a>Idea

>* 对于实时人脸对齐，能否把/delta x当作attention，形状当作predicate，然后也利用这种转移的思想，同理dynamic MRI能否也利用这个思路。
>* 我想做个榫卯vr app

### <a name="Will-search"></a>遗留问题汇总

>* 单例, 在"做iOS项目涉及到的知识点-1"ios中写笔记(done, 代码已写完, 在proj-experience里)
>* [iOS 文件目录](https://www.jianshu.com/p/572edba1ff9d)(还没看完，下次直接到"做ios项目涉及...."记笔记看帖)
>* C、C++的封装，用C实现C++的封装，C的函数指针模拟多态(笔记记录在today中)
>* #define bzero(s, n) memset((s), 0, (n));
>* 动态链接库
>* C、C++如何调用私有api
>*  Info.plist文件详解(看简书)
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
>* CGI是啥玩意儿
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
>*  Vanishing gradient problem. [ref1](https://en.wikipedia.org/wiki/Vanishing_gradient_problem), [ref2](https://www.quora.com/What-is-the-vanishing-gradient-problem)
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
