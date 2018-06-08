---
layout: post
title: "Proj-这么多人，AI怎么知道你说的是哪一个"
date: 2018-4-30
description: "ReferringRelationship项目笔记1"
tag: Proj
---

最近看了一篇视觉跟语义结合的文章，感觉比较有意思，同时也想看看涉及到语义的任务做的效果怎么样。接下来会写一系列的笔记把这篇文章的理论、代码整理一下。

###  paper笔记

这篇论文联系了计算机视觉和简单的自然语言，解决的问题就是：根据语言描述找出主体和客体。所有的语义都形式化为<subject-predicate-object>，
最终这篇文章的模型输出就是subject和object对应的图像区域。关键部分在于对predicate的建模。物体定位任务里的困难点：

    These difficulties arise due to, for example, small size and non-discriminative composition. 比如球、杯子。

通过我们的语义模型，可以对物体定位任务的困难点进行优化：

    To tackle this challenge, we use the intuition that detecting one entity becomes easier if we know where the other one is. In other words, we can find the ball conditioned on the person who is kicking it and vice versa.

本文的核心就是对predicate的建模。通常的visual relationship的文章给predicate学习出一个appearance-based model，但是这么做会有如下挑战：

    实体干扰：For example, the appearance for the predicate carrying can vary significantly between the following two relationships: <person - carrying - phone> and <truck - carrying - hay>.

我们对于predicate的建模受心理学里的聚光灯效应的启发。通过把predicates作为一个物体到另一个物体的视觉注意转移操作，而绕开这种聚光灯效应。

用于relationship的数据集：

    scene graphs---通俗来讲就是具有语言描述(formal representation)的图像集. 每个场景图会把各个entity编码成图的节点，两个实体间的连接边就是这两个实体间的相对关系。

    场景图改善了许多计算机视觉任务，包括：语义图像检索(semantic image retrieval)、图像字母(image captioning)、物体检测(object detection)。

    代表数据集: Visual Genome

最近的工作通过__co-occurrence statistics__将scene graphs用在了关系检测上，甚至将scene graphs用于加强学习框架。

    我猜测是将scene graphs中的node-connection-node和co-occurrence联系起来了。

previous work1:

    这些论文主要集中在：直接给出视觉关系，也就是：给定图像，输出关系。

我们的工作:

    恰恰相反，我们专注于其逆问题：给定关系，输出图像(subject roi、object roi)。

previous work2:

    Moreover，while previous work 学习predicate的诗句特征

我们的工作：

    we propose that: predicates的视觉外观变化各异，我们通过引入实体间的状态转移来有效的学习这种变化。

我的理解：

    1. 仍然是学习predicates的视觉特征
    2. 对前文提到的干扰(如实体干扰)进行建模，具体的建模方式为：实体之间的状态转移
    3. 这个想法是对的，比如说：person由carrying转到phone与truck由carrying转到hay是不一样的，那么就要对其进行具体的量化

我们的工作：

    1. 把视觉焦点(attention)建模成聚光灯，可以在次基础之上进行视觉焦点转移。目前基于attention的方法已经改善了图像捕捉、甚至问答系统任务。
    2. 我们对每一个predicate的两个attention shifting步骤构建两个不同的模型。这两个shifting分别为："subject以此shifting定位到object"和"object以另外一个与之相反的shifting定位到subject"。
    3. 每一个predicate同时利用当前的entity检测结果(在此我将其理解为intermediate result)和图像特征来学习怎样shifting。这个过程使得空间特征和__语义特征__同时被利用。[模型简介到这里比较让人不清楚的是这个语义特征]

Related work总结：

    我们的工作与__knowledge bases__具有相似性，形似之处在于：在一个确定的语义空间里表达predicates。这样的想法是最近才被应用于视觉关系检测的。
    不同之处在于：我们没有将predicates建模成语义空间里的投影，而是建模成关系中实体间的shift。可以将我们的方法想象成特殊的deformable parts model，
    在我们的方法中有两个deformable parts，每个都对应一个实体，最后我们的信息传递算法可以被认为成graph convolution approximation methods中的信息传递的一种特殊实现。

我们用两类模块，即attention shift module和predicate shift module来涉及我们的模型。attention模块尝试定位在图像中的具体的一个类别，而predicate模块学着把attention从一个实体转移到另一个实体上。

3.2 SSAS

回顾两个挑战：

    1. the difference in difficulty in object detection(目标检测的难易程度参差不齐，如：斑马好检测、杯子不好检测)。
    2. drastic appearance variance of predicates(carry的故事)

对于问题1

    利用一个实体的位置来推测另一个实体，原文为：We can overcome this problem by conditioning the localization of one entity on the other. if we know where the person is, weshould be able to estimate the lcation of the ball that they are kicking.

对于问题2

    我们的思路是：把predicates当作attention转移的机制(细节没读懂,3.2第二段需要仔细重读)


Attention modules

    作为subject和object位置的初始检测

predicate shift modules

    F_l(*)、F_-1_l(*)是学习的卷积滤波

Image Encoding

    1. 使用提前训练的ResNet50's的最后一个conv4激励层提取图像特征，特征的纬度是14x14x512
    2. 我们的predicate卷积滤波的kernel size为5x5，channels的个数为10 的时候模型的效果最好

Training details

    1. RMSProp为我们的最优化函数
    2. 初始学习率为0.0001，如果validation loss在连续3个epochs不下降时就以30%的速率进行衰减
    3. 我们训练了30个epochs，在512纬空间内对我们的objects和predicates进行嵌入

Experiments

数据集介绍：

    CLEVR是一个合成数据集, predicates比较简单，只有：left，right，front，behind, 30
    VRD是benchmark数据集，图像来自于真实世界, 有100个object，70个predicate类别，总共5000个图像,38000个relationship，60%的关系是模糊的.
    Visual Genome是最大的数据集，100000个图像，2.3M个relationship

Evaluation Metrics

    1. IoU---定位图像显著部分的通用标准, 计算了预测区域与ground truth的平均交集
    2. KL-divergence---测量两个显著maps的相异程度

小结：思路我了解了，就是把predicate当成shift，寻找predicate的语义反面的atention。

###  代码部分

这个代码写的比较规范，接下来把跑这个代码遇到的一些bug总结下，然后对应论文把比较困惑的一些细节理解下。

#### 跑通代码

作者的源码的环境用virtualenv来管理，按理说包的版本没问题，就可以一次性跑通，可是还是遇到了些问题。在跑train4me.py的时候遇到了这个bug:

```
Using TensorFlow backend.
WARNING:tensorflow:From /Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/tensorflow/contrib/learn/python/learn/datasets/base.py:198: retry (from tensorflow.contrib.learn.python.learn.datasets.base) is deprecated and will be removed in a future version.
Instructions for updating:
Use the retry module or similar alternatives.
high-level api is used for train visualgenome
train the visualgenome model...

Downloading data from https://github.com/fchollet/deep-learning-models/releases/download/v0.2/resnet50_weights_tf_dim_ordering_tf_kernels_notop.h5
94650368/94653016 [============================>.] - ETA: 0s2018-04-15 12:23:45.202608: I tensorflow/core/platform/cpu_feature_guard.cc:140] Your CPU supports instructions that this TensorFlow binary was not compiled to use: AVX2 FMA
WARNING:tensorflow:From /Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/keras/backend/tensorflow_backend.py:1192: calling reduce_sum (from tensorflow.python.ops.math_ops) with keep_dims is deprecated and will be removed in a future version.
Instructions for updating:
keep_dims is deprecated, use keepdims instead
Traceback (most recent call last):
  File "train4me.py", line 70, in <module>
    model = relationships_model.build_model()
  File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/models.py", line 75, in build_model
    return self.build_ssas()
  File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/models.py", line 154, in build_ssas
    subject_att = Concatenate(axis=3)(subject_outputs)
  File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/keras/engine/topology.py", line 583, in __call__
    previous_mask = _collect_previous_mask(inputs)
  File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/keras/engine/topology.py", line 2752, in _collect_previous_mask
    mask = node.output_masks[tensor_index]
IndexError: list index out of range
```

出这个bug的代码为：

    subject_outputs = Lambda(lambda x: [internal_weights[i]*x[i] for i in range(len(x))])(subject_outputs)

如果改成这种方式就可以跑通:

            subject_outputs1 = []
            for i in range(len(subject_outputs)):
                subject_outputs1.append(Lambda(lambda x: x * internal_weights[i])(subject_outputs[i]))
            subject_outputs = subject_outputs1

这是比较让我困惑的，按理说这两个代码是等效的。另外有一点要注意，如果代码这样写就会出现错误：

            subject_outputs1 = []
            for i in range(len(subject_outputs)):
                subject_outputs1.append(subject_outputs[i] * internal_weights[i])
            subject_outputs = subject_outputs1

会报错"tensor' object has no attribute '_keras_history'"。主要的原因在于，你的tensor的定义要一环扣一环的，一旦出现了如上这种操作，就会破坏这种关系。当然为了不破坏这种关系，就要借助于Lambda layer。Lambda的作用就在于可把如上这种操作作为layer 对象，就像官方文档描述的: "Wraps arbitrary expression as a Layer object."。

为了看代码，我跑了个小模型，为此我写了data4me.py这个脚本来生成小一点的数据集。训练的小模型在dataset-vrd-train-small里。

__注：跑训练或者验证的基本思路就是打开一个xx.sh，然后根据里边的脚本在config4me.py中添加一个相应的函数就齐了。__


#### 配合论文阅读源码

position

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/)
