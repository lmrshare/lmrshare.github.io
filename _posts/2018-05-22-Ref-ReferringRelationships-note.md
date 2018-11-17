---
layout: post
title: "Proj-这么多人，AI怎么知道你说的是哪一个"
date: 2018-4-30
description: "ReferringRelationship项目笔记1"
tag: Projs
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

代码笔记2:

>* utils/ --- 这个路径下的文件把metrics相关的，loss相关的都封装起来了。
>*eval_utils.py --- 与metrics相关, 文件中的函数分为两类：调用函数, 如：get_metrics和基本功能函数如precision、recall
>*train_utils.py --- 与train相关

eval_utils.py:

`get_metrics` 函数最终得到6个元素的函数list，元素分别为:

* `metrics[0]` 的 `__name__` 属性 `iou_0.5`
* `metrics[1]` 的 `__name__` 属性 `recall_0.5`
* `metrics[2]` 的 `__name__` 属性 `precision_0.5`
* `metrics[3]` 的 `__name__` 属性 `kl_0.5`
* `metrics[4]` 的 `__name__` 属性 `cc_0.5`
* `metrics[5]` 的 `__name__` 属性 `sim_0.5`

`format_results` 和 `format_results_eval` 就是格式化输出。

接下来分析几个细节：

* 分析 `line75: K.cast(K.greater(y_pred, heatmap_threshold),'float32')`

    >>> from keras import backend as K
    >>> import tensorflow as tf
    >>> import numpy as np
    >>> val = np.array([.1, .2, .3, .4, .5])
    >>> var = K.variable(value=val, dtype='float32')
    >>> var
    <tf.Variable 'Variable_2:0' shape=(5,) dtype=float32_ref>
    >>> K.eval(var)
    array([ 0.1       ,  0.2       ,  0.30000001,  0.40000001,  0.5       ], dtype=float32)
    >>> thr_var = K.greater(var, .2)
    >>> thr_var
    <tf.Tensor 'Greater_3:0' shape=(5,) dtype=bool>
    >>> K.eval(thr_var)
    array([False, False,  True,  True,  True], dtype=bool)
    >>> f_thr_var = K.cast(thr_var, 'float32')
    <tf.Tensor 'Cast_3:0' shape=(5,) dtype=float32>
    >>> K.eval(f_thr_var)
    array([ 0.,  0.,  1.,  1.,  1.], dtype=float32)
    >>> print(K.eval(K.shape(f_thr_var)))
    [5]

* 分析 `line76: intersection = y_true * pred`

    >>> y_true = K.variable(value = np.random.random([5], dtype = 'float32')
    >>> y_true
    <tf.Variable 'Variable_4:0' shape=(5,) dtype=float32_ref>
    >>> print(K.eval(K.shape(y_true)))
    [5]
    >>> K.eval(y_true)
    array([ 0.19151945,  0.62210876,  0.43772775,  0.78535861,  0.77997583], dtype=float32)
    >>> K.eval(f_thr_var)
    array([ 0.,  0.,  1.,  1.,  1.], dtype=float32)
    >>> intersection = y_true * f_thr_var
    >>> intersection
    <tf.Tensor 'mul_1:0' shape=(5,) dtype=float32>
    >>> K.eval(intersection)
    array([ 0.        ,  0.        ,  0.43772775,  0.78535861,  0.77997583], dtype=float32)

分析 `K.sum`:

    >>> val1 = np.random.random([5,5]) * 5
    >>> val1.dtype
    dtype('float64')
    >>> val1 = val1.astype(int)
    >>> val1.dtype
    dtype('int64')
    >>> var1 = K.variable(value = val1, dtype = 'int64')
    >>> var1
    <tf.Variable 'Variable_5:0' shape=(5, 5) dtype=float32_ref>
    >>> K.eval(var1)
    array([[2, 3, 4, 3, 3],
       [0, 3, 4, 3, 2],
       [0, 2, 2, 4, 2],
       [2, 2, 4, 0, 3],
       [3, 3, 3, 2, 4]])
    >>> s1 = K.sum(var1, axis = 0)
    >>> s1
    <tf.Tensor 'Sum_4:0' shape=(5,) dtype=int64>
    >>> K.eval(s1)
    array([ 7, 13, 17, 12, 14])
    >>> s2 = K.sum(var1, axis = 1)
    >>> s2
    <tf.Tensor 'Sum_5:0' shape=(5,) dtype=int64>
    >>> K.eval(s2)
    array([15, 12, 10, 11, 15])

结论是：1按行，0按列;&emsp;Matlab中的是2按行，1按列

eval_utils.py这个文件还有些细节存疑，主要是目前对y_true和y_pred的含义不清楚。

models4me.pys:

对Input层进行K.eval(K.shape(.))会出bug

    >>> test = Input(shape = (1, 4, 4))
    >>> K.eval(K.shape(test))
    *** tensorflow.python.framework.errors_impl.InvalidArgumentError: You must feed a value for placeholder tensor 'input_4' with dtype float
         [[Node: input_4 = Placeholder[dtype=DT_FLOAT, shape=[], _device="/job:localhost/replica:0/task:0/cpu:0"]()]]

    Caused by op 'input_4', defined at:
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/spyder/utils/ipython/start_kernel.py", line 269, in <module>
        main()
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/spyder/utils/ipython/start_kernel.py", line 265, in main
        kernel.start()
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/ipykernel/kernelapp.py", line 486, in start
        self.io_loop.start()
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/tornado/platform/asyncio.py", line 127, in start
        self.asyncio_loop.run_forever()
      File "/Users/linmengran/anaconda3/lib/python3.6/asyncio/base_events.py", line 421, in run_forever
        self._run_once()
      File "/Users/linmengran/anaconda3/lib/python3.6/asyncio/base_events.py", line 1426, in _run_once
        handle._run()
      File "/Users/linmengran/anaconda3/lib/python3.6/asyncio/events.py", line 127, in _run
        self._callback(*self._args)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/tornado/platform/asyncio.py", line 117, in _handle_events
        handler_func(fileobj, events)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/tornado/stack_context.py", line 276, in null_wrapper
        return fn(*args, **kwargs)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/zmq/eventloop/zmqstream.py", line 450, in _handle_events
        self._handle_recv()
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/zmq/eventloop/zmqstream.py", line 480, in _handle_recv
        self._run_callback(callback, msg)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/zmq/eventloop/zmqstream.py", line 432, in _run_callback
        callback(*args, **kwargs)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/tornado/stack_context.py", line 276, in null_wrapper
        return fn(*args, **kwargs)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/ipykernel/kernelbase.py", line 283, in dispatcher
        return self.dispatch_shell(stream, msg)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/ipykernel/kernelbase.py", line 233, in dispatch_shell
        handler(stream, idents, msg)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/ipykernel/kernelbase.py", line 399, in execute_request
        user_expressions, allow_stdin)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/ipykernel/ipkernel.py", line 208, in do_execute
        res = shell.run_cell(code, store_history=store_history, silent=silent)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/ipykernel/zmqshell.py", line 537, in run_cell
        return super(ZMQInteractiveShell, self).run_cell(*args, **kwargs)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/IPython/core/interactiveshell.py", line 2662, in run_cell
        raw_cell, store_history, silent, shell_futures)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/IPython/core/interactiveshell.py", line 2785, in _run_cell
        interactivity=interactivity, compiler=compiler, result=result)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/IPython/core/interactiveshell.py", line 2909, in run_ast_nodes
        if self.run_code(code, result):
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/IPython/core/interactiveshell.py", line 2963, in run_code
        exec(code_obj, self.user_global_ns, self.user_ns)
      File "<ipython-input-11-1d70498dda69>", line 1, in <module>
        debugfile('/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/models4me.py', wdir = '/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master')
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/spyder/utils/site/sitecustomize.py", line 728, in debugfile
        debugger.run("runfile(%r, args=%r, wdir=%r)" % (filename, args, wdir))
      File "/Users/linmengran/anaconda3/lib/python3.6/bdb.py", line 431, in run
        exec(cmd, globals, locals)
      File "<string>", line 1, in <module>
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/spyder/utils/site/sitecustomize.py", line 705, in runfile
        execfile(filename, namespace)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/spyder/utils/site/sitecustomize.py", line 102, in execfile
        exec(compile(f.read(), filename, 'exec'), namespace)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/models4me.py", line 381, in <module>
        model = rel.build_model()
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/models4me.py", line 75, in build_model
        return self.build_ssas()
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/models4me.py", line 88, in build_ssas
        input_subj = Input(shape=(1,))
      File "/Users/linmengran/anaconda3/lib/python3.6/bdb.py", line 48, in trace_dispatch
        return self.dispatch_line(frame)
      File "/Users/linmengran/anaconda3/lib/python3.6/bdb.py", line 66, in dispatch_line
        self.user_line(frame)
      File "/Users/linmengran/anaconda3/lib/python3.6/pdb.py", line 261, in user_line
        self.interaction(frame, None)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/spyder/utils/site/sitecustomize.py", line 442, in interaction
        self._cmdloop()
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/spyder/utils/site/sitecustomize.py", line 453, in _cmdloop
        self.cmdloop()
      File "/Users/linmengran/anaconda3/lib/python3.6/cmd.py", line 138, in cmdloop
        stop = self.onecmd(line)
      File "/Users/linmengran/anaconda3/lib/python3.6/pdb.py", line 418, in onecmd
        return cmd.Cmd.onecmd(self, line)
      File "/Users/linmengran/anaconda3/lib/python3.6/cmd.py", line 216, in onecmd
        return self.default(line)
      File "/Users/linmengran/anaconda3/lib/python3.6/pdb.py", line 376, in default
        exec(code, globals, locals)
      File "<stdin>", line 1, in <module>
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/keras/engine/topology.py", line 1426, in Input
        input_tensor=tensor)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/keras/legacy/interfaces.py", line 87, in wrapper
        return func(*args, **kwargs)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/keras/engine/topology.py", line 1337, in __init__
        name=self.name)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/keras/backend/tensorflow_backend.py", line 432, in placeholder
        x = tf.placeholder(dtype, shape=shape, name=name)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/tensorflow/python/ops/array_ops.py", line 1507, in placeholder
        name=name)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/tensorflow/python/ops/gen_array_ops.py", line 1997, in _placeholder
        name=name)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/tensorflow/python/framework/op_def_library.py", line 768, in apply_op
        op_def=op_def)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/tensorflow/python/framework/ops.py", line 2336, in create_op
        original_op=self._default_original_op, op_def=op_def)
      File "/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/env/lib/python3.6/site-packages/tensorflow/python/framework/ops.py", line 1228, in __init__
        self._traceback = _extract_stack()

    InvalidArgumentError (see above for traceback): You must feed a value for placeholder tensor 'input_4' with dtype float
             [[Node: input_4 = Placeholder[dtype=DT_FLOAT, shape=[], _device="/job:localhost/replica:0/task:0/cpu:0"]()]]

`inputs`的构成:

    input_im    ---shape is (?, 224, 224, 3)
    input_subj  ---shape is (?, 1)
    input_pred  ---shape is (?, 70)
    input_obj   ---shape is (?, 1)

`outputs`的构成:

    subject_regions ---shape is (?, 196)
    object_regions ---shape is (?, 196)

ps: 这里的`(?, 196)`是通过`(?, 14, 14, 1)`reshape得到的，我的理解就是简单的降维。具体执行的是

    subject_regions = Reshape((self.output_dim * self.output_dim), name = 'subject')(subject_att)
    object_regions = Reshape((self.output_dim * self.output_dim), name = 'object')(object_att)

### 算法流程:

* 1. 构建cnn图像模型`self.build_image_model(.)`

```
input  ---  input_im为(?, 224, 224, 3)的tensor, 即论文里的LxLxC
output ---  im_features为(?, 14, 14, 1024)的tensor
```

* 2. 构建一个`embedding layer`

```
self.num_objects   --- The number of categories we want enbeddings for.(100)
self.embedding_dim --- The dimensions in the embedding.(512)
```

根据我的经验，通常输入可理解成[batch ,input_length], 经过嵌入层后变成[batch, input_lenth, output_dim], 而input_dim通常为
一维tensor中元素值的上限。下面就举例说明：

    1. input_subj为<tf.Tensor 'input_2:0' shape=(?, 1) dtype=float32>, 理解成：batchsize为none，input_lenth为1
    2. Embedding(num_object, embedding_dim, input_length = 1), ps: [num_object, embedding_dim]为[100, 512]
    3. Embedding(input_subj)

这样input_subj经过嵌入层后得到的输出的维度为: [none, input_lenth, embedding_dim], 具体的数值为：

    [none, 1] -> [none, 1, 512]

简单理解：将一维向量映射成矩阵，无非就是有batch_size个向量要映射罢了。另外我对input_dim 为字典长度的理解:
如果你的input(考虑一维向量)为[2, 1000], 那么input_dim就设置成1000。

pos: embedded_subject = subj_obj_embedding(input_subj)
在网上再查一下Embedding相关的东西理解好这行代码的含义，然后再往下看代码。

结合网上的说明以及tts的回忆，我当时的输入是[50, 100], 50代表batch size, 100代表句子的长度。然后word2vec选的是10000个词的词汇表, 200。
经过word2vec后得到的向量为[50, 100, 200]
结合Embedding的输入, 给出如下解释:

    input_dim: 10000，也就是说你的每个词取值可能性为10000. ---input_dim理解为所有的取值可能性或者词汇表大小。
    output_dim: 200, 也就是用维数为200的一维向量来表示一个词. ---output_dim就理解为表示空间的大小吧。
    input_length: 100, 意味着每句话的含有100个词

分析代码：

    input_subj是shape=(?,1)的tensor，经过subj_obj_embedding(由Embedding(100,512,1))Embedding层后得到的tenso` embedded_subject的shape为(?, 1, 512)
    这里100就是self.num_objects, 也就是说有100个object, 并且用维数为512的向量来表示每个object

简记之：

    [Embedding]: input_subj ---> embedded_subject: (?, 1) ---> (?, 1, 512)

接着:

    [Dense]: embedded_subject ---> embedded_subject: (?, 1, 512) ---> (?, 1, 1024)
    [Dropout]: embedded_subject ---> embedded_subject: (?, 1, 1024) ---> (?, 1, 1024)

总结上面几个步骤：

    input_subj 经过 Embedding、Dense、Dropout后变成embedded_subject, 即由(?, 1)变成(?, 1, 1024)

同样的操作作用于`input_obj`：

    input_obj 经过Embedding、Dense、Dropout后变成embedded_object, 即由(?, 1)变成(?, 1, 1024)


初始化subject和object上的attention, 也就是对应着论文中的公式(1)和(2):

    attend实现了Att(/mu, S or O)
    im_features --- /mu
    embedded_subject --- S
    embedded_object --- O

在代码中的表现就为

    im_features和embedded_subject经过attend函数得到了作用在subject上的初始attention ---> subject_att
    输入输出维度表现: Att( (?, 14, 14, 1024), (?, 1, 1024) ---> (?, 14, 14, 1)
    im_features和embedded_object经过attend函数得到了作用在object上的初始attention ---> object_att
    输入输出维度表现: Att( (?, 14, 14, 1024), (?, 1, 1024) ---> (?, 14, 14, 1)

注意：这里得到的subject_att和object_att还没有predicate信息。

循环执行之后，我们得到了有predicate attention module加成的object_att和subject_att。实际上到这里，文章的模型已经结束了。
接下来补充些论文的描述，然后把剩余的代码总结了。

    Image Encoding: 本文使用了预定义的ResNet50的最后的activation layer, 特征的大小是[14x14x512]
    Training details: RMSProp是我们的最优化函数，初始learning rate是0.0001，一旦validation loss在连续的三个epoch都不下降，
    那么learning rate就以30%的速度进行衰减。

line148和line149就是对self.internal_loss_weight进行指数运算, 显然：

    如果internal_loss_weight<1, 得到的序列是递减的，反之递增

不严谨的用符号表示这两行执行完之后`internal_weights`的结果

    [w^0/sum(*), w^1/sum(*), w^2/sum(*), ... , w^(len(subject_outputs)-1)/sum(*)]

`subject_outputs1`就是`subject_outputs`乘以`internal_weights`的结果, 同理得到`object_outputs1`。
最后再赋给`subject_outputs`和`object_outputs`。

在此要注意一点: line151到154的代码给我注释掉了，因为当时跑这个出bug了，这个前文有说明。

然后把这些中间结果(shape为[?, 14, 14, 1])拼起来，得到subject_att(shape为[?, 14, 14, 4])

    subject_att = Concatenate(axis=3)(subject_outputs)
    object_att = Concatenate(axis=3)(object_outputs)

然后按照第四个维度求平均值：

    subject_att = Lambda(lambda x : K.mean(x, axis = 3, keepdims=True))(subject_att)
    object_att = Lambda(lambda x: K.mean(x, axis=3, keepdims=True))(object_att)

然后经过`Activation("tanh")`层, 然后再`reshape`得到`sugject_regions`和`object_regions`。这里仅以`subject_regions`举例：

    subject_att = Activation("tanh")(subject_att)
    subject_regions = Reshape((self.output_dim * self.output_dim,), name = "subject")(subject_att)
    object_regions = Reshape((self.output_dim * self.output_dim,), name="object")(object_att)

其中，`subject_regions`和`object_regions`的维度均为(?, 196)。另外，利用所有迭代结果的平均值并不是一定的，这里是根据参数
`self.use_internal_loss`来配置的。我这里有个想法，出于稳定性和精度的两方面因素的考虑，可以在这里设置一个trade-off, 简单
来说就是利用最后几次迭代结果的平均值。

至此`build_ssas`成员函数的流程就梳理完了，我们回顾下该模型的输入和输出：

inputs:

    input_im    ---shape is (?, 224, 224, 3)
    input_subj  ---shape is (?, 1)
    input_pred  ---shape is (?, 70)
    input_obj   ---shape is (?, 1)

outputs:

    subject_regions ---shape is(?, 196)
    object_regions  ---shape is(?, 196)

现在看名字应该可以顾名思义了。

继续分析后续流程, `build_ssas`之后就是: 设置`RMSprop`优化器、求损失函数、编译模型。

接着的流程是：设置回掉函数、开始训练、验证。

`TensorBoard`是TensorFlow提供的可视化工具，该回调函数将日志信息写入TensorBorad，使得你可以动态的观察训练和测试指标的图像以及不同层的激活值直方图。

    log_dir：保存日志文件的地址，该文件将被TensorBoard解析以用于可视化

`LrReducer`这是用户自定义的关于learning rate衰减的回掉函数。

`Logger`这个也是用户自定义的回掉函数。

    logs: 访问model的信息
    on_xxx_end或者on_xxx_begin: 回掉方法

`ModelCheckpoint` 简单来说就是来设置与保存模型相关的参数

`Sequence`和数据集相关的类，主要实现`__len__`，`__getitem__`

    __len__: 返回batch的个数，也就是steps
    __getitem__: 返回每个batch的数据集

模型构造好了，数据集构造好了，接下来就可以训练、验证，以及测试了。

train主要由`model.fit_generator`实现，关键参数为：

    generator---继承Sequence，主要是提供每个batch的训练样本(输入、输出)[数据集]
    steps_per_epoch---训练batch的个数(generator提供)
    epochs---轮数
    validation_data---同generator一样，只不过这里是验证数据集[数据集]
    validation_steps---验证batch的个数
    verbose---日志显示设置
    use_multiprocessing---是否使用多进程
    workers---最大进程数
    callbacks---回掉函数list，本文代码的回掉有[ModelCheckpoint(模型存储), TensorBoard(可视化训练过程), Logger(用户自定义callback，用于输出每个epoch的训练结果), LrReducer(用户自定义callback, 用于对learning的动态调节)]

evaluate主要由于`model.evaluate_generator`实现，关键参数为:

    generator---val_generator
    steps---val_steps
    use_multiprocessing---是否使用多进程
    workers---最大进程数

输出验证结果, 根据之前提供给model的`metrics`

test的过程和evaluate是一样的，只是数据集不同而已。

至此文献代码的整理流程就梳理完了。

__pos: 处理待办，复习理解整体流程，看实现细节，配合论文回顾。__

python知识点:


`clip(x, min, max)`: 按照范围对x中的元素进行限定，举例：

    >>> val = np.array([.1, .2, .3, .4])
    >>> t1 = K.variable(value = val, dtype = 'float32')
    >>> t2 = K.clip(t1, .2, .3)
    >>> K.eval(t2)
    array([ 0.2       ,  0.2       ,  0.30000001,  0.30000001], dtype=float32)

`range`

    >>> test = [i for i in range(5)]
    [0, 1, 2, 3, 4]
    range(n)对应的取值区间为[0,n), 即做闭右开的

`**`代表乘幂运算


---
[Keras 模型中使用预训练的 gensim 词向量和可视化](https://eliyar.biz/using-pre-trained-gensim-word2vector-in-a-keras-model-and-visualizing/) (undone)

word2vec的作用：

    1. 将词量化
    2. 表示词对词之间的关系

pos: "在这篇", 也就是第二段(暂停), 新任务见下面的描述。

经过搜索知道，大体流程为: 以Glove举例，这是斯坦福给的一个word2vec算法，利用该算法得到word2vec模型，然后keras可以直接利用这个pre-trained模型做任务，具体的demo可见待办中的链接。目标：

    -搞懂Glove
    -用一下google的算法
    -给出对比实验

[两个算法的对比, click on me](https://github.com/dennybritz/cnn-text-classification-tf/issues/69)

keywords: `comparision of glove and google news word2vec model`

### Writing

这句话是写在Related Work段的承接性句子：

    To properly situate the task of referring relationships, we explore the evolution of visual relationships as a representation.
    Next, we survey the inception of referring expression comprehension as a similar task, summarize how attention has been used in the deep learning literature, and survey other technical approaches that are similar to our approach.

Related Work中的承接短语：

    Pushing along this thread, visual relationships were initially limited to spatial relationships: above, below, inside and around.

替代firstly，secondly的一种写法:

    sth. were initially done, sth. were then done.

### Keras相关的经验

Exp1：

    plot_model(model, to_file='model.png',show_shapes=True)----这行代码可以将model保存成图片。

    model.summary(): 打印出模型的概况

Exp2：

    1. isinstance---isinstance(object,type-or-tuple-or-class) -> bool
    2. python 创建类、继承、抽象方法
       class xx(object):
         @abstractmethod
         def xxx(self, xx1,xx2):
    3. python的threading

Exp3：

    1. dataset_dict = {'smart':Smartiterator, 'discovery':DicoveryIterator}
    2. dataset_dict['smart'](dir,args)

Exp4：

    1. from utils.eval_utils import get_metrics --- 从utils文件夹下的eval_utils.py文件导入get_metrics函数

Exp5：

    metric = (lambda f, t : lambda gt, pred : f(gt, pred, t))(metric_func, thresh)

Exp6：

我对这句的理解: `lambda f, t : lambda gt, pred : f(gt, pred, t)` 是函数部分, `(metric_func, thresh)` 是参数部分。起初，我认为可以等价为:

    metric = lambda gt, pred : metric_func(gt, pred, thresh)

经测验这是错误的, 原因在于：这里的`metric_func`不再是具体的函数，没有意义。举例说明:

    >>> func3 = lambda x, y, z : x + y + z
    >>> F = lambda gt, pred : func3(gt, pred, 2)
    >>> F(1,2)

出错: `***NameError name 'func3' is not defined`

如果把func3当成参数传递就没问题:

    >>> F = (lambda f : lambda gt, pred : f(gt, pred, 2))(func3)
    >>> F(1,2)
    5

简记：看到`lambda`, 配对，带入。

python 中`lambda`的用法：

_eg1_:

    >>> func = lambda a, b : a+b
    >>> func(1,3)
    >>> 4

_eg2_:

    def func(n)
      return lambda x, n : x + n

    >>> f = func(3)
    >>> f(2)
    >>> 5

_eg3(作为一个小函数传递:)_:

    >>> pairs = [(4, 'four'), (3, 'three'), (2, 'two'), (1, 'one')]
    >>> pairs
    [(4, 'four'), (3, 'three'), (2, 'two'), (1, 'one')]
    >>> pairs.sort(key = lambda pair : pair[0])
    >>> pairs
    [(1, 'one'), (2, 'two'), (3, 'three'), (4, 'four')]

返回类型:

    >>> type(xx)

### 实操这个代码遇到的些问题

Sun Apr  8 15:14:13 CST 2018: 我先测试的Visual Genome dataset这个数据集，但是有了tensorflow的bug，可通过如下命令重现bug:
 ```
&emsp;&emsp;linmengran@imac:~$ LOCATION_OF_VISUAL_GENOME_IMAGES=/Volumes/LMR_1T/base/interview/dl_projs/CV/ReferringRelationships-master/data/VisualGenome/VG_100K
&emsp;&emsp;linmengran@imac:~$ ./scripts/create_visualgenome_dataset.sh $LOCATION_OF_VISUAL_GENOME_IMAGES
 ```
* [***github路径***](https://github.com/StanfordVL/ReferringRelationships)

命令:
```
&emsp;&emsp;linmengran@imac:~$ pip list----查看python装了哪些包
&emsp;&emsp;linmengran@imac:~$ source virpy/bin/activate---启动虚拟环境
&emsp;&emsp;linmengran@imac:~$ pip3 install spyder ----虚拟环境下安装spyder，其他包也如此
&emsp;&emsp;linmengran@imac:~$ deactivate
```
写了个python文件跑上面的两条命令，生成了相应的数据集。接下来就要开始看train和test的代码了。

写外围代码，满足：可以方便的调用各个模块，如：训练、验证、测试。

关于复制文件的小经验，主要涉及合并文件夹时，覆盖不覆盖的问题:
```
&emsp;&emsp;linmengran@imac:~$ find VG_100K/ -name '*.jpg' -exec cp {} VG_100K_ALL \;  ---- 把VG_100K目录下的所有文件copy进来
&emsp;&emsp;linmengran@imac:~$ find VG_100K_2/ -name '*.jpg' -exec cp -f {} VG_100K_ALL \;   ---- 再把VG_100K_2目录下的所有文件copy进来，注意：-f代表强制复制
```
此外，为了实现强制不复制，应该执行如下命令：
```
&emsp;&emsp;linmengran@imac:~$ awk 'BEGIN { cmd="cp -i VG_100K_2/* VG_100K_ALL2/"; print "n"|cmd;}' --- -i是一种交互式的操作，每次都会询问yes/no, 所以这里用代码写上no。但是这种写法有个问题，就是会报错: "sh: /bin/cp: Argument list too long", 意思就是文件太多了。
```
我制作了两个数据集：

>* VG_100K_ALL: 代表用VG_100K_2中的数据集进行强制复制
>* VG_100K_ALL2: 代表用VG_100K中的数据集进行强制复制

另外为了验证VG_100K和VG_100K_2中的两个目录是否有同名文件，我用非-f的方式合并这两个目录到VG_100K_ALL3中；假如有提示，那么我就保留VG_100K_ALL和VG_100K_ALL2，假如没有提示，说明这两个目录没有同名文件，那么我只保留VG_100K_ALL。__验证结果表明这两个目录没有同名文件__。


我用VG_100K_ALL中的数据制作了训练数据存储于dataset-genome

__关于python写代码的一点经验，后面我再写代码的时候，就要按照data4me.py的方式来写:__

>* 将公共参数和专属参数分开，专属参数放到一个函数里面，然后只根据一个字符串参数来调用不同的专属参数

这样做的优点有：

>* 不写参数的时候可以跑
>* 只需要更改一个参数


__在跑train4me的时候自动在如下链接下载了些东西__
[deep-learning-models] (https://github.com/fchollet/deep-learning-models/releases/)

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/)
