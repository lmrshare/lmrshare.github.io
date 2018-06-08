---
layout: post
title: "Work Experience 2"
date: 2018-04-30
description: "work experience2 "
tag: Bundle
---

### 切分支:

    git checkout -b feature_xxx_demo remotes/origin/feature_xxx_demo
    git show 981734907213409712309847

### `@class`说明

    1. @class只是告诉编译器，其后面声明的名称是类的名称，至于这些类是如何定义的，暂时不用考虑，后面会再告诉你。
    2. 编译效率和循环引用的问题。

`NSTimeInterval _start = [[NSDate date] timeIntervalSinceReferenceDate];`

### git提交代码的时候出的问题:

场景描述：我提代码后把易办的部分代码冲掉了，回忆当时的操作：

    1. git add -u dir
    2. git commit -m '分包'
    3. git stash
    4. git pull --rebase
    5. git push

操作之前我看了下易办的提交，确定第一处改动没问题，我以为代码没冲突，就没管了。然而，事实表明：我的操作把易办第二处改动
冲掉了。至今没想明白这个问题，后面仔细查一下原因。(undone)

此外，提代码的注意事项：

    1. commit前diff一下，确定代码有没有冲突
    2. 如果commit之前没diff, 我一般会在push之后git log，然后git show

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
