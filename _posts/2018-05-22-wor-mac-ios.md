---
layout: post
title: "做iOS项目涉及到的知识点-1"
date: 2018-5-10
description: "初步接触ios项目积累的经验，OC的内容居多"
tag: IOS
---

一些基本的语法知识

###  1. 属性和实例变量

写法一:

      @interface MyViewController :UIViewController
      @property (nonatomic, retain) UIButton *myButton;
      @end

>* 1. self.myButton调用的是myButton属性的getter/setter方法
>* 2. 实例变量可以理解成C++的成员变量
>* 3. object-c 2.0中@property会自动创建_开头的实例变量

写法二:

    #import "ViewController.h"

    @interface ViewController ()
    @property (nonatomic, strong) UIButton *myButton;
    @end

    @implementation ViewController
    @synthesize myButton;

归纳总结:

>* 1. `@synthesize`只能出现在`@implementation`代码段中
>* 2. 让编译器自动生成setter和getter
>* 3. `@synthesize myButton = xxx`这种写法指定了与属性对应的实例变量，那么self.myButton其实操作的是实例变量_xxx, 而不是`myButton`了;
>* 4. `@syncthesize myButton`生成的实例变量是`myButton`，也可理解成操作的是`myButton`, 如果没有`@syncthesize myButton`, 生成的实例变量就是`_myButton`

这四条总结起来就是`@synthesize`映射了属性与实例变量，`self.某某`调用的是实例变量的`setter`和`getter`；默认的映射是与之同名的实例变量(可见有了这个关键字生成的是与之同名的实例变量)；没有这个关键字就默认生成`_某某`的实例变量。简记为"做映射, 操作实例, 默认同名"

属性和实例变量的关系：

>* 1. 属性对成员变量扩充了存取方法;
>* 2. 属性默认会生成带下划线的成员变量;
>* 3. 但只声明了变量，是不会有属性的

### 2. extern、static、const

简单总结:

    extern-全局变量修饰，跨文件访问
    const-修饰右边变量
    static-定义开始到文件结尾(修饰全局变量)
    static-定义开始到函数结束或语句块结束(修饰局部变量)
    static-本文件使用(修饰函数)

`const static`应用场景：本文件中经常使用的字符串常量。

eg1.:

>* 1. `classA.h`文件:

    @interface ClassA : NSObject
    + (nullable NSUserDefaults *)sharedUserDefaults;
    @end

    extern NSString * _Nonnull WWKEPostBoxIdentifierHost;
    extern NSString * _Nonnull WWKEPostBoxIdentifierShareExtension;


>* 2. `classA.m`文件:

    #import "ClassA.h"

    NSString *APPGROUP_NAME = @"group.com.tencent.ww";

    NSString *WWKEPostBoxIdentifierHost = @"host";
    NSString *WWKEPostBoxIdentifierShareExtension = @"shareext";

    @implementation ClassA
    + (nullable NSUserDefaults *)sharedUserDefaults{
        return [[NSUserDefaults alloc] initWithSuiteName:APPGROUP_NAME];
    }

    @end

>* 3. `classB.h`文件：

    #import "ClassA.h"

    @interface ClassB : ClassA

    @end

    extern NSString * _Nonnull WWKEPostBoxIdentifierShareExtension1;


>* 4. `classB.m`文件：

    NSString * WWKEPostBoxIdentifierShareExtension1 = [WWKEPostBoxIdentifierShareExtension copy];

    @implementation ClassB
    + (nullable NSUserDefaults *)sharedUserDefaults{
        WWKEPostBoxIdentifierShareExtension1 = [WWKEPostBoxIdentifierShareExtension copy];
        return [[NSUserDefaults alloc] initWithSuiteName:@"sss"];
    }

    @end

___注意___: `NSString * WWKEPostBoxIdentifierShareExtension1 = [WWKEPostBoxIdentifierShareExtension copy];`这行有bug:

    nitializer element is not a compile-time constant

想得通, `WWKEPostBoxIdentifierShareExtension`初始化的时机不能保证在这行之前完成，因此有这个bug。注意，`WWKEPostBoxIdentifierShareExtension1 = [WWKEPostBoxIdentifierShareExtension copy];`这行是没问题的，这说明此时`WWKEPostBoxIdentifierShareExtension`已经初始化完毕。

eg2:

>* 1. `classA.h`和`classA.m`文件不变，`classB.h`变成：

    #import "ClassA.h"

    @interface ClassB : ClassA

    @end


>* 2. `classB.m`变成：

    #import "ClassB.h"

    NSString *WWKEPostBoxIdentifierHost = @"host";
    NSString *WWKEPostBoxIdentifierShareExtension = @"shareext";

    @implementation ClassB

    @end

此时会报链接错误, 注意，`extern`修饰的变量不要出现两次初始化。经调试，只要把任意一处的初始化删掉一个都可通过编译。

___ref:___

- [1. OC中关键字extern、static、const探究](https://www.jianshu.com/p/3fa703e80720)

### 3. NSUserDefaults

通过`NSUserDefaults`访问plist文件中的偏好设置

### 4. 写在`.h`和`.m`中的`@property`有什么区别

初步看是作用域的问题，后续仔细看下[`@property`](https://jiangxh1992.github.io/ios/2016/10/31/Property%E5%B1%9E%E6%80%A7/)学习下`property`

___ref:___

- [1. NSUserDefaults](https://www.jianshu.com/p/459c15cf6ce2)

### 5. NSFileCoordinator

NSFileCoordinator是协调在host app与extension apps之间移动数据的非UI组件

___ref:___

- [1. NSFileCoordinator](https://www.jianshu.com/p/3e3674630190)

### 6. CFNotificationCenterGetDarwinNotifyCenter

简单说下为什么用这个吧，详细的解释见参考文献

    1. 系统级的通知中心, 可用于Extension和容器app的交互
    2. NSNotificationCenter，KVO，Delegate都不行，因为Extension和容器app不是一个App

此外，如果想实现更复杂的进程间的交互，可以使用`MMWormhole`

___ref:___

- [1. 为什么用](https://www.jianshu.com/p/e807ee6e46e5)

### 7. OC与C++混编

主要总结C++调用OC的三种情况：

    1. 在C++的头文件中写个struct把oc对象藏起来

    2. 在C++的头文件中这样`id xxx`

    3. 通过c的函数指针把C++和OC结合起来

      a.OC对象里函数指针包起实际调用的方法
      b.把OC本身通过void*传给C++对象(与调用无关，只是传递)
      c.把OC的函数指针传给C++对象

详细介绍见参考文章

___ref:___

- [1. 混编](https://awhisper.github.io/2016/05/01/%E6%B7%B7%E7%BC%96ObjectiveC/)

### 8. Object-C 继承(undone)

___ref:___

-[1. ?]()

### 9. Category和Extension

一种对类进行扩展的方法， 无需创建子类就可以添加新方法, 可以为任何已经存在的class添加方法, 包括没有源码的类.

参考资料：

### 10. nonatomic

>* 1. 在ios中，一般都声明为非原子的，这处于性能的考虑
>* 2. 在mac OS X中，可以声明为atomic, 因为在mac上不需要怎么考虑性能问题
>* 3. 即使是atomic也不一定能保证是线程安全的，还需要更深层次的锁定机制才行[]

### 11. strong与weak

>* 1. ARC是编译器特性而不是运行时特性, 因此不是类似于其他语言的垃圾回收器，其性能与手动内存管理是一样的
>* 2. Strong指针的特点就是可以保持对象的生命，也就是说：当指针获得新值或者不存在时(如局部变量方法返回、实例变量对象释放)对象可能被释放。之所以这里说的是"可能"，理由在于：一个对象可以有多个"拥有者"
>* 3. 默认所有实例变量和局部变量都是Strong指针
>* 4. weak型的指针变量仍然可以指向一个对象，但是不属于对象的拥有者. 也就是说只有使用权, 而不会影响对象的回收。
>* 5. weak型的指针变量自动变为nil是非常方便的，这样阻止了weak指针继续指向已释放对象，避免了野指针的产生，不然会导致非常难于寻找的Bug，空指针消除了类似的问题(野指针跟阳痿差不多)
>* 6. weak指针主要用于“父-子”关系
>* 7. 有了ARC之后，只需要关心对象之间的关联，也就是"谁是谁的拥有者"

___ref:___

- [1. strong属性与weak属性的区别](https://www.jianshu.com/p/f9e5b3f9c088)

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
