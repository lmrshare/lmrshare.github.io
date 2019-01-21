---
layout: post
title: "CNN checklist(1)"
date: 2018-05-22
description: "CNN checklist1"
tag: Domain Knowledge
---

这是我从网上的博文整理的主要关于CNN的checklist(主要参考[Beginner](https://adeshpande3.github.io/adeshpande3.github.io/A-Beginner's-Guide-To-Understanding-Convolutional-Neural-Networks/)), 并非本人阅读论文后的笔记, 所以文中大部分内容都不是我的观点. checklist的主要作用在于收集大家的观点, 同时, 用以发现我的一些不足, 进而可以帮助我制定后续的学习计划.

### 目录

* [Backpropagation](#Backpropagation)
* [全连接层(fully connected layers, FC)](#FC)
* [A Beginner's Guide To Understanding Convolutional Neural Networks](#beginer)
* [AlexNet (2012)](#alexnet)
* [ZF Net(2013)](#zfnet)
* [VGG Net(2014)](#vggnet)
* [GooGleNet (2015)](#googlenet)
* [Microsoft ResNet](#Microsoft-ResNet)
* [R-CNN(2013)、Fast R-CNN(2015)、Faster R-CNN(2015)](#r-cnn-fast-rcnn-faster-rcnn)
* [Generative Adversarial Networks 2014](#GAN)
* [Generating Image Descriptions](#GID)
* [Hessian Free Optimization](#hessian-free-optimization)
* [模型压缩](#optimize-model)
* [待添加](#will-search)
* [Reference](#reference)

### <a name="backpropagation"></a>Backpropagation

可参考我这篇中的[介绍](https://lmrshare.github.io/2018/10/mri/).

### <a name="FC"></a>全连接层(fully connected layers, FC)

FC在整个卷积神经网络中起到分类器的作用, 在实际使用中，全连接层可以由卷积操作实现: ___a. 对前层是全连接的全连接层可以转化为卷积和为1x1的卷积___;___b. 而前层是卷积层的全连接层可以转化为卷积核为hxw的全局卷积，h和w分别为前层卷积结果的高和宽___. 有关卷积操作"实现"全连接层的一个知识点: 以VGG-16为例, 对224x224x3的输入, 最后一层卷积可得输出为7x7x512. 如后层是一层含4096个神经元的FC, 则可用卷积核为7x7x512x4096的全局卷积来实现这一全连接运算过程, 其中该卷积核参数如下:

`filter size = 7, padding = 0, stride = 1, D_in = 512, D_out = 4096`

经过此卷积操作后可得输出为1x1x4096, 如需再次叠加一个2048的FC, 则可设定参数为"filter size = 1, padding = 0, stride = 1, D_in = 4096, D_out = 2048”的卷积层操作, 具体可参考: [<font color="ff0000">conv+relu+pooling</font>](http://cs231n.github.io/convolutional-networks/).

FC层参数存在冗余(占整个网络的80%), 因此近期一些性能优异的网络模型如ResNet和GoogLeNet等均用全局平均池化(global average pooling, GAP)取代FC来融合学到的深度特征. 最后仍用softmax等损失函数作为网络目标函数来指导学习过程. 具体的案例如下:
[<font color="ff0000">冠军之道</font>](https://zhuanlan.zhihu.com/p/23176872), [<font color="ff0000">project</font>](http://210.28.132.67/weixs/project/APA/APA.html). 似乎FC是越来越不被看好的, 不过近期研究发现: FC可在模型表示能力迁移过程中充当"防火墙"的作用. 具体来说: 可以在source domain和target domain差异较大的时候保证模型表示能力的迁移, 也就是说冗余的参数并不是一无是处.

__PS:__ <font color="ff0000">结合原始论文完善这部分</font>

### <a name="beginer"></a>[A Beginner's Guide To Understanding Convolutional Neural Networks](https://adeshpande3.github.io/adeshpande3.github.io/A-Beginner's-Guide-To-Understanding-Convolutional-Neural-Networks/)

2.2 part2:

- stride: 就是我以前做的sliding step
- padding: 边缘处理技巧，常规的有zero padding，我还做过wrapped around

Rectified Linear Units(ReLU):

- ReLU就是增加model的nonlinear性质
- 引入nonlinearity[在线性层之后]
- 是一种nonlinear layer，过去常用的有tanh、sigmoid
- 相比tanh、sigmoid，ReLU的特点是计算速度快和减轻Vanishing gradient problem
- 公式为`f(x) = max(0, x)`, 可以看出ReLU层可以把negative actibations改成0
- ReLU可以在不影响卷积层receptive fields的情况下增加模型的nonlinear性质

ReLU可参考:

- [<font color="ff0000">hinton paper about ReLU</font>](http://www.cs.toronto.edu/~fritz/absps/reluICML.pdf)

Pooling Layers:

- 也称作下采样层, 下采样层中最流行的有`maxpooling`

我感觉maxpooling有点结合等间隔采样和压缩传感的意味, 或者说maxpooling是考虑了数据本身特性的等间隔采样, 这一层的主要作用是：

- control overfitting
- reduce the amount of parameters or weights

Dropout Layers:

这一层主要是防止过拟合，有一句比较关键的话是：

- The network shoudl be able to provide the eight classsification or output for a specific example even if some of the activations are dropped out.

Dropout Layers可参考:

- [<font color="ff0000">hinton paper about Dropout</font>](https://www.cs.toronto.edu/~hinton/absps/JMLRdropout.pdf)

Network in Network Layers:

- [<font color="ff0000">paper by min lin</font>](https://arxiv.org/pdf/1312.4400v3.pdf)

classfication、localization、detection、segementation:

这篇文章(part 2)后面的内容主要就是讲应用、迁移学习、数据增强. 由于涉及的论文较多, 我就不一一列出了, 后续要看的时候, 可以从这篇文章找，文章为:

- [<font color="ff0000">A Beginner's Guide To Understanding Convolutional Neural Networks Part 2</font>](https://adeshpande3.github.io/A-Beginner%27s-Guide-To-Understanding-Convolutional-Neural-Networks-Part-2/)

### <a name="alexnet"></a>[AlexNet (2012)](https://papers.nips.cc/paper/4824-imagenet-classification-with-deep-convolutional-neural-networks.pdf) (cited: 6184)

几个关键点:

- 在ImageNet数据上训练了网络结构，具体来讲：用了150,000,00张标注图像, 其中图像来自于超过220,00个类
- 利用了比tanh function更快速的ReLU非线性单元，大大缩减了训练事件
- 利用了data augmentation techniques来处理图像的translations、horizontal reflection以及patch extraction
- 利用dropout layers来对抗overfitting问题
- 使用了batch stochastic gradient descent技术进行驯良
- 在两个`GTX 580 GPU`上训练了5、6天

为什么重要?

CNNs里的Alex非常具有代表性，因为这是有史以来在ImageNet dataset上表现最好的一个模型, 里面的技术，如: `data augmentation`、 `dropout`现在仍然被使用，这篇论文阐述了CNNs的优势.

- [<font color="ff0000">Gradient-Based Learning Applied To Document Recognition</font>](http://yann.lecun.com/exdb/publis/pdf/lecun-01a.pdf)

### <a name="zfnet"></a>[ZF Net(2013)](https://arxiv.org/pdf/1311.2901v3.pdf)

自AlexNet之后就有大量的CNNs模型提交到ILSVRC 2013, 其中[Matthew Zeiler](http://www.matthewzeiler.com/research/)和[Rob Fergus](https://cs.nyu.edu/~fergus/pmwiki/pmwiki.php)赢得了比赛, ZF Net的错误率为11.2%. 该模型的体系结构相对于AlexNet的结构更加精细化，同时提出了几个关于改善性能的关键点. 此外，这篇论文的亮点是: 作者花了大量的篇幅来解释ConvNet的动机，并展示如何可视化filters和weights。
这篇论文开篇讨论了"CNNs之所以可以重新吸引人们的兴趣是因为大训练集和GPU的计算性能"。作者也提到：由于缺乏对神经网络内部机制的深入理解，开发更好的模型往往就变成了实验工程(trial and error)，现在神经网络的内部机制仍然是一个黑盒。这篇论文的主要贡献是对AlexNet模型的细节进行轻微调整、对feature map进行可视化。

总结:

- ZF Net和AlexNet的网络结构仅有细小的差别
- AlexNet的训练集是15,000,000个图片，而ZF Net仅用了13,000,00个图片
- ZF Net的第一层滤波尺度不是11x11而是7x7，理由是：第一个卷积层使用小尺度滤波可以跟好的保持原始图像的像素级信息，此外stride用的是2
- 仍然使用ReLUs作为激励函数来引入nonlinearity，使用cross-entropy作为error function。利用stochastic gradient descent分batch进行训练
- 在GTX 580 GPU上训练了两个星期
- 提出了Deconvolutional Network的可视化技术来检验各layer的feature map以及与input的关系。之所以叫做deconvnet是因为该技术将feature map与原始输入图像的pixel进行了映射
- ZF Net对CNNs提供了很多直觉性的解释，同时提供多了多种改善性能的方案。可视化策略不仅解释了CNNs的内部工作原理，也对改善神经网络结构给出了比较深刻的解释。

DeConvNet:

_ __Idea:__ 在CNN的每一个layer都附加一个deconvnet使得任意一层的feature map都可以回溯到input pixel，进而完成了映射。
_ __实现细节:__ 这部分看的不是很明白，后续看原文(undone)

### <a name="vggnet"></a>[VGG Net(2014)](https://arxiv.org/pdf/1409.1556v6.pdf)

19层CNN并且严格限制了滤波的大小为3x3，stride为1，在CNN的后面接了2x2的maxpooling，其中stride为2。VGG Net的特点是 __简单__、__深__。

总结：

- 3x3滤波的使用与AlexNet的11x11和ZF Net的7x7有很大不同。作者的理由是：两个3x3的卷积层与一个5x5的卷积层的表现类似，这就意味着可以在保持小滤波器的尺寸优势的前提下来模拟大滤波器。其中之一的好处就是可以减少参数的个数，此外，利用两个卷积层意味着可以增加两个ReLU
-进而增强模型的非线性。
- 3个连续的卷积层可以模拟一个7x7。
- 值得注意的是：在每个maxpooling层之后滤波的数量会增加。这个操作吻合"收缩空间维度、增加深度"
- 除了在classification和localization任务中表现良好外，作者把一种localization任务当作regression来处理，详细见[paper](https://arxiv.org/pdf/1409.1556v6.pdf)
- 使用Caffe toolbox
- 在训练过程中使用了scale jittering作为数据增强技术
- 在卷积层之后使用ReLU层来增强模型的非线性，并利用batch gradient descent进行训练
- 在Nvidia Titan Black GPUs上训练了三个星期

为什么重要？

VGG Net 强化了这样一个概念：“卷积神经网络的网络结构应该是由多个层构成的深度网路结构，这样才可以使视觉数据的层次化表示更好的工作”。进而形成这样的一个经验：keep it deep，keep it simple。

### <a name="googlenet"></a>[GooGleNet 2015](https://www.cv-foundation.org/openaccess/content_cvpr_2015/papers/Szegedy_Going_Deeper_With_2015_CVPR_paper.pdf)

简单来说GoogleNet更好的遵守了"Keep it deep, Keep it simple". GoogleNet使用了22层CNN, 其设计原则也颇为简单: 堆叠卷积层和pooling层, 同时作者也着重强调并处理了机器学习中的著名问题: “复杂模型下的计算复杂度问题以及overfitting问题”.
GoogleNet 引入了Inception module这一概念. GoogleNet的网络结构不是一路串行到底的, 这中间会出现一些并行计算单元. 通俗来讲: 在串行计算的过程中会出现几个分支, 然后把分支的计算结果进行concat后再串行. 这里的由并行分支构成的单元就称作Inception module, 其结构如图所示:

<div align="center">
	<img src="/images/posts/dl-ref-notes/inception_module.png" height="300" width="400">
</div>

$$图1. inception module(图片引自原文)$$

在传统的串行网络结构中, 在每一层的后面只能接一种操作, 比如: pooling op、conv op, 而inception module允许并行执行所有的这些操作. 但这样做会导致训练没办法工作, 主要原因就是输入过多, 为了降低输入的深度, GoogleNet在进行3x3或5x5的卷积操作之前会先通过1x1的卷积操作对depth进行降维, 这个操作可被认为是一种特征池化. 类似地, GoogleNet通过正常的maxpooling层来降低width和height的维度. 关于1x1 conv的详细描述可参考[<font color="ff0000">one by one Convolution</font>](https://iamaaditya.github.io/2016/03/one-by-one-convolution/). 另外有一点需要注意: 这些1x1conv后面会跟着ReLU units. 现在的疑问是: 网络套网络的设计为什么工作呢? 答案简单来讲就是: 模块中的几个支线可以抽取不同层次的特征(比如: 小尺寸滤波系数的卷积操作可以抽取精细化的特征而大尺寸滤波系数的卷积操作可以抽取粒度较粗的特征), 而特征工程又是机器学习领域里很重要的环节. 这是一种有失严谨的解释, 详细描述看原文吧(不过我认为原文也并没有给出什么严格的数学证明, 但肯定比我这样说要convince).

-  整个网络又9个Inception module，共计100个layer
-  没有使用全连接层，替代它的是平均池化层实现了7x7x1024到1x1x1024的映射
-  在预测的时候，会传输给网络多个同样的图片，然后把这些softmax probabilities平均后作为最终的输出解
-  利用了R-CNN中的一些理念来实现detection model(啥意思，哈哈)
-  在一些"high-end GPUs"上训练了一周

GoogleNet是第一个提出Inception module的网络, 也就是说从今天起我CNN同学也不再仅仅是sequentially了哟, 总之GooleNet可以深入看下.

### <a name="Microsoft-ResNet"></a>[Microsoft ResNet](https://arxiv.org/pdf/1512.03385v1.pdf)

这个网络是152层的, 在ILSVRC 2015上的错误率仅为3.6%, 关于ConvNets在图像上的经验可以参考[Andrej Karpathy](http://karpathy.github.io/2014/09/02/what-i-learned-from-competing-against-a-convnet-on-imagenet/). 在ResNet里有一个Residual Block的概念, Residual Block是基于这样的考虑: 在原始信息基础之上附加一些特征, 这样联合了原信息和新特征的输入会更容易进行优化. 具体来说, 你可以让input x通过一系列conv-relu-conv序列进而得到F(x), 然后将其附加到原input x上得到: H(x) = F(x) + x. 此外, Residual Block之所以work的可能原因就是: 在反向传播的时候由于有"+"这个操作, 所以梯度更容易贯穿graph.

总结：

- 152层
- 值得注意的是：在开始的两个layer之后，spatial size会从224x224变成56x56
- 作者提到：不假思索的粗暴加层会导致train error和test error的提高
- 作者尝试了1202层的网络，但结果导致测试精度的下降，猜测可能是overfitting导致的
- 在8个GPU机器上跑了2~3个星期

ResNet跑了3.6%的error这点很吸引人, 由于residual learning的使用ResNet目前是最好的CNN.

<div align="center">
	<img src="/images/posts/dl-ref-notes/residual_block.png" height="300" width="400">
</div>

$$图2. residual block(图片引自原文)$$

中文帖:

- [<font color="ff0000">Microsoft-resnet</font>](https://www.jianshu.com/p/6908be0c5389)

### <a name="r-cnn-fast-rcnn-faster-rcnn"></a>[R-CNN(2013)](https://arxiv.org/pdf/1311.2524v5.pdf)、[Fast R-CNN(2015)](https://arxiv.org/pdf/1504.08083.pdf)、[Faster R-CNN(2015)](https://arxiv.org/pdf/1506.01497v3.pdf)

#### R-CNN

R-CNN是解决object detection任务的, 引用率挺高的. R-CNN在做检测任务的时候通常分为成两个步骤: 感兴趣区域提取(region proposal)、分类(classification). 对于第一步, RCNN使用了[Selective Search](https://ivi.fnwi.uva.nl/isis/publications/2013/UijlingsIJCV2013/UijlingsIJCV2013.pdf)，这个算法可以生成2000个最有可能包含object的区域。获取到这些region后，将其规范到图像尺寸，然后将这些图像作为input喂给训练好的CNN(如AlexNet)，这样就会为每个region image提取feature vector。最后利用linear SVMs(事先为每个class训练好的一个个SVM)对这些feature vector进行分类。补充一点，处于精细化的考虑，还会将这些vector传递给bounding box regressor来获得更精确的box.

#### Fast R-CNN

原R-CNN主要存在速度问题: 在训练阶段R-CNN的计算量很大, 非常慢, 每副图像花费大概53秒. 针对这个问题, Fast R-CNN通过共享不同感兴趣区域之间的卷积计算、对感兴趣区域进行排序来进行优化. 在Fast R-CNN中, 图像首先通过ConvNet, 然后从ConvNet的最终的feature map中获得感兴趣区域的特征, 最后, 把我们的全连接层作为我们回归或者分类的开始, 详细描述见[论文](https://arxiv.org/pdf/1504.08083.pdf)

#### Faster R-CNN

Faster R-CNN主要解决R-CNN和Faster R-CNN略显复杂的训练流程. 作者在卷积层的后面插入了一个区域建议网络(region proposal network-RPN). 这个网络可以根据最后的convolutional feature map来生成推荐区域或者称作感兴趣区域, 之后再执行与R-CNN同样的训练流程(ROI pooling、FC、开始分类或开始回归). 我的理解就是把之前的Selective Search用conv layers+RPN给换掉. 论文亮点: 可以确定一个图像中的具体是一个东西, 和物体的确切位置. 目前Faster R-CNN已经成为object detection算法的标准. 

### <a name="GAN"></a>[Generative Adversarial Networks 2014](https://arxiv.org/pdf/1406.2661v1.pdf)

LeCun提到GAN是未来的一个发展趋势. 首先介绍一点关于对抗的例子. 例如, 对于一个训练好的在ImageNet data上工作良好的CNN网络, 我们在一副图像上做轻微的改动以便使预测概率误差增大. 虽然图像本身在修改前后看起来一致, 但预测结果却可能发生改变. 站在另外一个角度来讲可以理解成: 数据愚弄了模型. [对抗的例子](https://arxiv.org/pdf/1312.6199v4.pdf)吸引了很多研究员(如mengranlin), 成为现在的热点问题. 现在我们讨论生成对抗网络(GAN), 考虑两个模型: 生成模型(generative model-gm)和辨识模型(discriminative model-dm). dl的任务就是区分图像是原始数据集中的还是人造的. gm的任务就是生成人造数据以便训练dm, gm和dm这两个角色像是做着零和博弈. 形象点描述可以这样理解: gm是犯罪团伙, 小伙子们拼命印假钞, 与此同时, dm同学就像警察拼命的打击假钞, gm致力于愚弄dm, 而dm拼命反抗愚弄. 两个模型都会一直改善直至: 仿品无法从真品中辨识.

LeCun在Quora中[提到](https://www.quora.com/What-are-some-recent-and-potentially-upcoming-breakthroughs-in-deep-learning): dm现在知道数据的内部表示, 因为dm得以训练来理解真实图像同人造图像之间的差异, 因此dm可以作为CNN中的特征提取器. 另外, 你可以制造出比较cool的人造图像](http://soumith.ch/eyescream/).

### <a name="GID"></a>[Generating Image Descriptions](https://arxiv.org/pdf/1412.2306v2.pdf)

当CNNs和RNNs结合的时候会发生什么? Fei-Fei Li和Andrej Karpathy两位结合了CNN和RNN为图像的不同区域生成了自然语言描述. 一般情况下, 我们喂给CNN的数据都是image+比较简单清晰的标签, 而在这个任务里, 标签是一句话, 其中句子的每个segment和图像的一部分区域对应, 这叫做weak label. 利用这样的训练数据会训练出可以把segment和图像region对应(alignment)起来的深度神经网络, 这个网络叫做Alignment Model. 此外, 另外一个神经网络会将一副图像作为输入, 然后生成一句文本描述. 接下来分别介绍这两个模型: Alignment 和 Generation.

#### Alignment Model

这个模型的作用就是把视觉和文本数据对应起来，该模型将图像和句子作为输入, 并输出得分来评价匹配的好坏程度. 接下来我们首先考虑图像表示: 第一步，将图像喂给R-CNN来检测出一个个独立的object. R-CNN是在imagenet上训练出来的. 包括原图在内共有20个区域被嵌入在500-d的sapce内，因此每个图像有20个500-d的向量，这样我们就有了图像信息，接下来是获取句子信息的内容了。这篇论文利用了RNN来将words/segements映射到同样的多模空间内，这样image和sentence就都在同样的多模空间内了，这也就意味我们可以通过计算他们的inner-product来对他们的相似性金星度量。

#### Generation Model

对齐模型的作用是构建由图像区域和文本描述子组成的数据集, 然后生成模型从这个数据集中进行学习来获得可以为图像生成描述子的能力.

### <a name="spatial-transformer-networks"></a>[Spatial Transformer Networks](https://arxiv.org/pdf/1506.02025.pdf)

在传统的CNN中, 如果希望自己训练的模型对图像的尺寸以及旋转具有不变性(在CNN中, 处理spatial invariance的模块是maxpooling layer), 那么事先要准备很多具有这样特点的训练样本, 而Google的这篇论文通过引入Spatial Transformer module(stm)来解决这个问题, 也就是说该module关心两个问题: ___1. pose normalization, 2. spatial attention___.

stm:

- Localization network: 输入图像, 输出放射变换参数（6个）
- Grid generator: 利用前面的放射变换参数来改变常规的采样网格
- sampler: 利用构造好的grids进行采样

可见相对于CNN的常规maxpool, stm不再是预定义的. stm是动态的、具有多种行为的. stm可以顺利的插入到CNN中来对feature map进行变换, 进而在训练期间帮助minimize cost function. 这篇论文主要对输入图像进行放射变换来使模型对translation, scale, and rotation具有不变性. 论文并没有对CNN的体系结构做改动. 这是关于stm的一个[讨论](https://www.quora.com/How-do-spatial-transformer-networks-work).
以上是对Convnet的初步讨论, 更细节的东西可以参考Stanford CS 231n lecture videos. 接下来我会通过几个应用进一步讲解.

### <a name="hessian-free-optimization">Hessian Free Optimization

适用于神经网络的一个最优化方法, Gradient Descent、Newton's Method、Conjugate Gradient可参考我之前的一篇[博文](https://lmrshare.github.io/2018/06/unconstrained-exetreme-value-problem/).

___Gradient Descent:___

最简单的迭代优化算法. 在任意一点沿着反向梯度下降是最快的. 因此有如下迭代算法:

1. 初始化: 选定初始值$ x_0 $
2. 计算$ x_i $处的梯度(即方向向量): $ \upsilon_i = \nabla f(x_i) $
3. 更新: 梯度乘以步长: $ x_{i+1} = x_{i} - \alpha \upsilon_i $
4. 迭代2、3直至收敛, 即: $ f{i} < \epsilon $

GD是first-order方法, 这个方法的限制就是: 如果误差平面比较平滑的时候才表现良好, 如果误差平面复杂则可能会导致收敛很慢.

___Newton's Method:___

尽管GD方法work, 但是这个方法的缺点就是慢, 为了优化速度, 可以利用二阶导数信息, 其中比较有代表性的就是Newton's Method. 接下来以1D举例, 然后拓展到多维情况:

1D:

对于一个可导函数来说, 他的局部最小值就是导数为0时$ {f}'(x) = 0 $. 如果$ f $是二次函数或者是单峰函数, 那么局部最小值就是最小值, 然而对于任意的非线性$ f $这就不好说了, 因此
, 在确定Nerwo Method的递推公式后要利用迭代的方式以跳出局部最小值以求得最小值或者说接近最小值, 接下来通过二阶泰勒展开的方式给出Newton's Method的递推公式:

对$ f(x_0) $附近的函数进行second-order Taylor展开:

$$
f(x_0 + x) \approx f(x_0) + {f}'(x_0)x + {f}''(x_0)\frac{x^2}{2}
\tag{1}
$$

此时, 我们需要找到$ x $来使$ f(x_0 + x) $最小, 既然临域且是二阶泰勒展开, 显然导数等于0即可:

$$
\frac{\mathrm{d} }{\mathrm{d} x}(f(x_0) + f'(x_0)x + f''(x_0)\frac{x^2}{2}) = f'(x_0) + f''(x_0)x
\tag{2} 
$$

由此可得到: $$ x = - \frac{f'(x_0)}{f''(x_0)} $$

则递推为: $$ x_{n+1} = x_n - \frac{f'(x_n)}{f''(x_n)} $$

可以看出二阶泰勒展开就是利用二次函数在定义域进行search, 姑且起个名---临域二次曲线近似. 对于高维, 有类似的结论: $$ f: R^n -> R $$, 原理类似, 只不过就是一阶导数变梯度向量, 二阶导数变成海赛矩阵:

$$ f'(x) -> \nabla f(x) $$

$$ f''(x) -> H(f)(x) $$

递推变为:

$$ x_{n+1} = x_n - (H(f)(x_n))^{-1}\nabla f(x_n)$$

总结: Newton's method是二阶算法, 效果可能比简单的GD要好. Newton's method假设函数在临域内可以很好的进行二阶泰勒展开也就是说可以很好的被二次函数来描述, 在这个假设下来搜索全局最优.
对比GD和Newton's method的递推公式, 可看出Newton's method是一种变步长算法. 此外, 从二阶导数的数学性质再来看这个可变化的步长有什么性质. 简单总结: Newton's method的步长可以做到: __低曲率曲面大步长, 高曲率曲面小步长__. 理由: 二阶导数$ f''(x) $反映了曲率, 即曲率高二阶导数大、曲率低二阶导数小; 而Newton's method方法的步长为$ f''(x)^{-1}$, 显然验证如上的简单总结.

然而(骚年, 重点来啦!), 海赛矩阵自打我记事起, 就听说这哥们hin难算. 如果不借助于有限差分几乎是不可能计算海赛矩阵的, 因此我可能不知道怎么计算海赛矩阵, 此外, 海赛矩阵需要$ O(n^2) $
存储空间来计算和查找, 所以复杂度是比较高的. 而Hessian-free optimization可以解决这两个问题, 该方法的关键在于优化了求二阶泰勒近似最小值的方法, 具体来说: 利用共轭梯度来迭代求二阶泰勒展开的最小值而不是直接通过导数/梯度为0(__利用 $ \frac{\partial f}{\partial x} = 0 $ 不可避免的就要求海赛矩阵, 注意这里的前提是二阶泰勒展开__).

___共轭梯度:___

共轭梯度算法是一种变步长gradient descent, 这里的步长是通过line search找到的. 共轭梯度可以求二次函数的最小值, 此外, 其变体可以处理非线性函数. 接下来我们看共轭梯度算法是怎么解决二次函数的:

二次函数:

$$
f(x) = \frac{1}{2} x^TAx + b^Tx + c
\tag{3}
$$

其中, $ x \in \mathbb{R}^n Q \in \mathbb{R}^{n \times n}, b, c \in \mathbb{R}^{n} $. 梯度为: $ \nabla f(x) = Ax + b $. 我们知道沿着梯度反方向是下降最快的, 那么每次下降多长呢? 普通的GD算法是固定步长的, 而CG是一种变步长方法, 每一次都寻找一个$ \alpha $ 使得 $ f $ 最小. 这个问题就是minimizing
函数: $ g(\alpha) = f(x_0 + \alpha d_0) $. 这里$ d_0 = - \nabla f(x_0)$.

对于二次函数有: $ g(\alpha) = \frac{1}{2} \alpha^2 d_0^T A d_0 + d_0^T (Ax_0 + b)\alpha + (\frac{1}{2}x_0^T A x_0 + x_0^T d_0 + c) $ 

- [<font color="ff0000">未写完</font>](http://andrew.gibiansky.com/blog/machine-learning/hessian-free-optimization/)

### <a name="optimize-model"></a>模型压缩

模型压缩

+ CNN、RNN模型存在着大量的参数冗余
+ D-S-D训练流程就是利用稀疏约束来进行模型压缩的
+ 既然神经网络的层参数有冗余, 一个直观的想法就是将参数分组, 然后对组内参数进行parameter sharing. 基于这个思路就会产生一个新问题: 如何分组.

### <a name="will-search"></a>待添加

+ <font color="ff0000">Hinge loss</font>
+ <font color="ff0000">hyperbolic tangent activation function</font>
+ <font color="ff0000">为什么weight sharing可以有助于阻止back-propagating过程中的gradient diffusion</font>

### <a name="reference"></a>Reference

- [1. 一个中文总结](http://kekecv.com/resource/landmark_review_2015.pdf)
- [2. andrew 的机器学习博客](http://andrew.gibiansky.com/archive.html)
- [3. a good blog about deep learning](http://andrew.gibiansky.com/archive.html)
- [4. ImageNet Classification with Deep Convolutional Neural Networks 2012](https://papers.nips.cc/paper/4824-imagenet-classification-with-deep-convolutional-neural-networks.pdf)
- [5. 论文列表](https://github.com/lmrshare/lmrshare.github.io/tree/master/papers/cnn-mri-papers-tmpfile)
- [6. DSD: Regularizing Deep Neural Networks withDense-Sparse-Dense Training Flow](https://arxiv.org/pdf/1607.04381v1.pdf)
<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
