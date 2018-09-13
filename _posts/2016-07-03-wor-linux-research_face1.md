---
layout: post
title: "整理自为知笔记的关于人脸对齐的(1)"
date: 2016-07-03
description: "这是在学校期间做的调研"
tag: Research
---

### Face detection

人体检测的方法主要分为三类，区别如下：

>* 1. 不同特征的使用，如：边缘特征（受背景杂波影响较大），哈尔特征，梯度特征（SIFT，形状上下文，HOG）
>* 2. 不同分类器的选择，如：近邻分类器，神经网络，SVM，Adaboost
>* 3. 图像中整体处理和分步处理的区别，整体处理是指将图像的整体区域进行分析和处理，分步处理是指先将图像分成若干小的子区域，先处理每一个子区域，然后通过区域间的关联对图像进行分析



### stasm proj:

主要Function：

>* stasm_search_single:输入脸，打标记
>* stasm_search_auto：与stasm_search_single作用相同，只不过是处理多脸的情况

`stasm`可以对一张或者对多张脸进行打标记:

>* 输入：可以设置脸部大小、命令行标记
>* 输出：stasm.log（文本文件）［list 77 point（landmarks）
>* swas：比较测量的landmarks和引用的landmarks

`minimal2`该函数可以对一副图像的多张脸进行landmark，细节可以看`stasm lib.h`和`minimal2.cpp`.

`stasm_open_image`:可以检测出人脸. `inputs of stasm_open_image`：

>* multiface：设置1时，对图像中所有脸进行landmark；设置0时，对图像中最好（最大）的脸进行landmark。
>* minwidth：脸部大小（face detector box）占图像宽度的百分比，通常设置未10%，15% 

注意, 对于`multiface`:

>* 1.设置为0时，最好脸可能不是最大的脸（为了缩减false positives，比median过大）或者过小的脸都会被剔除掉
>* 2.设置为1时，一组大小相近的脸会被landmark
>* 3.如果不想移除大小过大或者过小的脸就不调用facedet.cpp中的DiscardMissizedFaces      函数
>* 4.调试时，如果想显示脸部矩形，就设置#define TRACE IMAGES 

stasm中的一些功能说明:

>* stasm_search_pinned:用户手动在脸上打些点（眼睛，鼻子，嘴巴），然后算法将剩余点补充.
>* stasm_convert_shape:将77点图形转化成特定数目点图形（如XM2VTS，BioID格式），新格式的landmark是通过原77点图形计算出来的.
>* stasm_force_points_into_image:将landmarks转换成图像边界（boundary），可用于图像切图.
>* stasm_printf:可以打印到stdout中，也可以打印到stasm.log中，可以和stasm_init配合使用.

stasm的几个实现细节:

>* 1. 如果人脸靠近图像边缘，那么openCV frontal face detection 经常失败，stasm的做法就是在图像的周围添加一个10%的border；如果不想要这个border，就将Facedet.cpp的BORDER_FRAC设置为0
>* 2. 为了加快速度，stasm在Hatdesc.cpp中使用了hash_map 
>* 3. stasm使用了HAT（Histogram Array Transform），HAT用于在landmark时的模版匹配
>* 4. 如果想训练新的模型，可以参考Building Stasm 4 Models （http://www.milbo.users.sonic.net/stasm, 2014. ）
>* 5. 当前的Stasm版本只实现了frontal model（referred to yaw00 model），并不支持3/4 model
>* 6. stasm中有一些非线程安全的变量.
>* 7. 全局变量有_g后缀,几乎所有的头文件都被stasm.h包含；与example applications 相关的定义全部都放在`appmisc.h`中.


#### Active Shape Models with SIFT Descriptors and MARS

abstract:

>* 1.用简化的SIFT描述子代替ASM中1D gradient profiles，同时用MARS（multivariate adaptive regression splines）用于描述子匹配（descriptor matching），描述子是在landmark周围的 
>* 2.论文算法是modified ASM
>* 3.SIFT用于模版匹配（template matching）

related work：

>* MARS：multiple adaptive regression splines（多元适应性回归样条）
>* SIFT和HAT描述子的作用相同

descriptor matching：

>* 1. Once we have the descriptor of an image patch, we need a measure of how well the descriptor matches the facial feature of interest(度量描述子对感兴趣区域的匹配).
>* 2. SVM可用于descriptor mathching，但是用SVM比较慢，而MARS比SVM快多了，而且结果几乎与SVM一样好。

#### ASM

ASM是一种基于点分布模型（Point Distribution Model）的算法。

PDM：

PDM中,外形相似的物体,例如人脸、人手、心脏、肺部等的几何形状可以通过若干关键特征点(landmarks)的坐标依次串联形成一个形状向量来表示。对于发生扭曲，旋转，偏移的图形，可用procrustes方法进行归一化。

#### ref

- [1. Active Shape Models with SIFT Descrip-tors and MARS](www.milbo.org/stasm-files/active-shape-models-with-sift-and-mars.pdf)
- [2. Technical Report: Statistical Models of Appearance for Computer Vision](http://www.isbe.man.ac.uk/~bim/Models/app_models.pdf)
- [3. Locating Facial Features with an Extended Active Shape Model. ECCV](http://www.milbo.org/stasm-files/locating-facial-features-with-an-extendedasm.pdf)

- [4. Multiview Ac-tive Shape Models with SIFT Descriptors for the 300-W Face Landmark Challenge](http://www.milbo.org/stasm-files/multiview-active-shape-models-with-sift-for-300w.pdf)

### ASM笔记

Aligning:

>* 1. 移动训练集中的每个样本，使得图像的重心位于原点（即对所有样本使用同一坐标系）
>* 2. 选定一个样本（如x0）做为对平均形状x_的初始检测，将x_归一化，并将该初始化检测单独记为x_0
>* 3. 将训练集中的所有样本与x_对齐
>* 4. 利用已经对齐的形状重新计算x_
>* 5. 将x_与初始化检测x_0对齐,并对x_归一化
>* 6. 如果不收敛，就跳转到步骤3(收敛条件为：平均形状改变很小)
>* ps：具体的将两个形状对齐的算法见附录的详细推导。

1. 利用PCA进行将维:

>* 应用统计学方法解决模式识别问题经常遇到模式问题，在低纬空间里可以解决的问题在高位空间里往往行不通，因此降维是解决实际问题的关键，PDM中采用的将维方法是常规的PCA，应用PCA进行降维的原理是：选取由训练集构成的高维空间即云团（cloud）的t（t<2n）个主轴做为线性变换，在该线性变换下就可以得到原始高维数据的低维表示，即达到了将维的目的，其中主轴恰好是协方差矩阵的特征向量，通常我们选取大特征值对应的特征向量。详细的PCA推导见附录。

>* 对于t的选取，如果问题限定了精度，那么我们就可以通过逐渐增加主轴（协方差矩阵的特征向量）的试探方法来确定t。另外一种策略是选择t个特征向量使得模型能够展现训练样本集给定比例98%的形状变化。该比例可通过：sum（t个特征值）/sum（全部特征值）＝给定比例[如98%]确定。

2. 利用步骤1所得到的PCA表示模型来对新形状进行适配:

将模型点X向目标点Y（即：目标形状）进行匹配的过程。利用步骤三得到的线性变换可将低维系数b转换为高维的形状，然后再通过尺度变换，旋转变换和移位来对形状进行变换就得到了我们的模型点。将X向Y对齐的过程就是迭代寻找b和变换（尺度，旋转以及移位）的过程，优化目标为最小化X与Y的平方距离，具体的算法流程如下(matching)：

>* 1. 将低维向量b初始化为0
>* 2. 利用变换矩阵将b转换为高维形状（x＝x_ ＋ Pb）
>* 3. 利用最小二乘法找到当前最好的变换系数（优化目标为最小化X与Y的平房距离，X＝T(x)）
>* 4. 利用步骤3求得的变换系数，求Y在逆变换下的y（y＝T'(Y)）
>* 5. 将y进行规范到与x_同一尺度（y_=y/(y.x_)）
>* 6. 更新b，即b＝P_(y_-x_),［P_代表P的逆，由于P是正交矩阵，因此逆矩阵就是转置矩阵］
>* 7. 如果不收敛就跳转到步骤2

#### 如何测试模型

通常采用leave－one－out实验来测试模型的优劣，具体来说，去除数据集中的一个样本，然后利用剩下的样本集合来生成模型，然后用生成模型来对去除的样本进行估计，并记录误差。如果误差过于大，这说明训练集样本量过小；如果误差比较小，也仅仅说明一个类型的图形可能不仅有一个样本，而不能说明训练集是完备的。

#### 小结

ASM是基于点分布模型（PDM）的，其主要特点是用PCA对形状进行建模以及形状适应新图像时梯度方向的移动策略。ASM由两部分构成：训练和搜索。训练主要完成两项工作，即：从训练集中构建形状模型（用于表示形状）、从训练集中构建局部特征（用于适应新图像）。搜索主要完成的工作是：形状X在局部特征的作用下在新图像上移动得到新形状X‘，然后用形状模型表示该新形状X’。此外，在训练和搜索过程都要注意对数据进行标准化。

### one million paper(dlib proj)

#### theory

1.dlib中的初始预测有问题

>* "Also, to reproduce the testing scenario, we ran the face detector on the training images to provide an initial configuration of the landmarks (x0), which corresponds to an average shape"

dlib的训练过程中的初始预测是不是不只用样本数据？因为只用样本的初始预测可能表示力不够

SIFT 是在landmark周围抽取的图像特征：

>* “SIFT features ex- tracted from patches around the landmarks to achieve a ro- bust representation against illumination”

1.SIFT 是不可导的，因此使用一范数或者二范数方法就需要对jacobian和hessian进行数值近似

>* ps：数值近似的计算复杂度非常高

SDM

>* 1. SDM的目标就是学习一系列下降方向和尺度变换因子（牛顿方法中hessian干的事）
>* 2. SDM不需要SIFT是二阶可导，也不需要对jacobian和hessian进行近似计算；SDM直接通过学习获得形状差和图像特征差之间的线形回归器来直接导出图像特征差的投影矩阵
>* 3. SDM就是在牛顿迭代框架下进行建模的，只是去除了对二阶导的限制

#### expr

##### Sun Mar 10 13:32:07 CST 2017

训练了帧间回归器，来捕捉前后帧的运动:

>* 1. 在真实形状的基础上增加了满足高斯分布的平移和尺寸扰动, 对人脸的平移运动捕捉的比较好，抖动情况也比较好，但是对于人脸的转动，捕捉的不好
>* 2. 增加了模拟转动的训练样本（20度，10度），这样训练样本就变成了包含转动和平移的训练样本, 单帧检测的时候效果比较好，也不怎么抖，但是跟踪起来的时候全部都乱了，现在在分析原因

接下来的工作：

>* 1. 查找形状乱掉的原因
>* 2. 传入小角度的扰动
>* 2. 在3D形状基础之上生成平移
>* 3. 考虑分类
>* 4. 研究基于CLM跟踪的论文和代码:
>* 5. 计算语义五点，算姿态，选平均形状，回归(JDA)



<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
