---
layout: post
title: "Work Experience 1"
date: 2018-04-01
description: "work experience"
tag: Projs
---

### 调试

>* 1. 汇编级调试: 这种调试在库或者框架发生crash，同时没有这些库或者框架的源代码的时候比较有用.
>* 2. 看debug输出:

```
eg:
NSString *outputData = @"The quick brown fox jumps over a lazy dog!";
NSLog( @"text: %@", outputData );

NSString *message = @"test message";
NSLog( @"Here is a test message: '%@'", message );

double myNumber = 7.7;
NSLog(@"number: %@", @(myNumber));
```

>* 3. 在方法和函数定义的开始处打出log, 即:

```
- (void)pressButton:(id)sender
{
    NSLog( @"calling: %s", __PRETTY_FUNCTION__ );

    ...
```

该方法在分析调用序列的时候很有用: 在很多函数的开发头写上这句话, 然后就可以分析调用序列了

>* 4. 输出backtrace到控制台, 这种方法在检查crash的时候比较有用

```
NSLog(@"%@", [NSThread,callStackSymbols]);

DSLog是占用时间的，所以最好在DEBUG宏里用NSLog，在debug build的时候DEBUG是1，release build的时候是0
```

#### ref:

- [IOS Debugging Magic](https://developer.apple.com/library/content/technotes/tn2239/_index.html#//apple_ref/doc/uid/DTS40010638)

### git

查看远程分支

    git branch -r

提交文件夹下的更新

    git add -u xxx/yyy 

find 命令:

```
mengranlin@imac:~$ find . -name '*spl.x*'-----在当前目录及其子目录查找名字包含'spl.'文件. -maxdepth 3。
mengranlin@imac:~$ find . -name -maxdepth 3 '*spl.x*'-----意义同上，只是限定查找路径的个数。
```

### C++11

要支持c++11，需要在CMakeLists.txt中加上这句

    add_definitions(-std=c++11)

### 静态库操作经验:

    nm /Users/linmengran/work/git/ios/xxx/ssss | grep Masonry
    grep "\-\->ycyc" tmp.txt
    grep "sent" ~/Documents/console.log | head -5

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
