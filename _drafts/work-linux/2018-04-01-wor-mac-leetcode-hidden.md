---
layout: post
title: <font color="ff0000">Leetcode</font>
date: 2018-4-01
description: "Leetcode notes"
tag: HNotes
---

### 目录

* [最长回文子串](#Longest-Palindromic-substring)
* [正则表达式匹配](#Regular-Expression-Matching)
* [通配符匹配](#Wildcard-Matching)
* [Longest Common Prefix](#Longest-Common-Prefix)
* [搜索](#search)
* [经验](#experience)


### <a name="Longest-Palindromic-substring"></a>最长回文子串


__回文串__: 正反都一样，即s[i] == s[n-1-i]，(0 <= i <= n-1)

#### 思路一: 寻找递推关系

首先定义f(i, j)代表s_i,...,s_j之间的最长回文串

* __正常情况__: 字符串长度不是1，按照s[i]与s[j]是否相等进行处理
* __边界__: 字符串的长度为1，此时f[i][j] == s[i]

>* 相等(s[i] == s[j])，并且s[i+1][j-1] == f[i+1][j-1]，则f[i][j] == s[i][j]
>* 不相等(s[i] != s[j] 或者 s[i+1][j-1] != f[i+1][j-1])， 则f[i][j] = max(f[i+1][j-1], f[i][j-1], f[i+1][j])

代码：

（递归）

position_c: coding

#### 思路二: 动态规划(undone)

要利用动态规划的思路求解，可以按照以下几步切入进行:

>* 寻找最优子结构、构造递推公式
>* 思考边界情况
>* 尽量用表把子问题的解存储起来，自底向上的利用非递归的方式来实现

动态规划主要可以解决重复计算的问题，对于palindrome string问题来说，有这样一个事实：如果我们已经知道bab是palindrome，那么对于ababa只需要判断首尾字母就可以了。这里，定义一个二进制变量P(i,j)，通过该变量可以知道s_i,...,s_j子串是不是palindrome string。则有如下递推：

    P(i, j) = (P(i+1, j-1) and S_i == S_j)

边界:

    P(i, i) = 1
    P(i, i+1) = (S_i == S_i+1)

复杂度:

* Time: O(n^2)
* Space: O(n^2)

代码:

```
string longestPalindrome(string s) {
  int len = s.length();
  //Boundary treatment
  if(len == 1) return s;
  if(len == 2 && s[0] == s[1]) return s;
  else if(len == 2 && s[0] != s[1]) return "";
  string res = "";
  bool p[len][len];
  //Initialize p
  for(int i = 0; i < len; ++i)
    for(int j = 0; j < len; ++j)
    {
      if(j >= i && j-i <= 1) p[i][j] = true;
      else p[i][j] = false;//tips:you can ignore this line
    }
  //DP process
  for(int j = 2; j < len; ++j)
    for(int i = j-2; i>=0; --i)
    {
      if(s[i] == s[j] && p[i+1][j-1] == true)
      {
        p[i][j] = true;
        if(j-i+1 > res.length())res = s.substr(i, j-i+1);
      }
      else
        p[i][j] = false;
    }
  //Return result
  return res;
}
```

#### 思路三: Expand Around Center

首先，根据palindrome string的镜像特点，我们可以通过"从中心向两边等距延拓"得到palindrome string，这里我们称之为'中心延拓palindrome string'”。基于这个认识有了这样的一个思路：___“把所有中心延拓palindrome string比较一下，选出最长的”___。接下来分析"中心"这个细节。

中心有两种情况：__单字符中心__和__双字符中心__。那么在一个字符串中，这两种中心有什么特点呢？

假设字符串的长度为n，显然单字符中心的个数为n，而双字符中心的个数为n-1。显然我们只需要___“把这2n-1个中心延拓palindrome string比较一下，选出最长的”___。

代码：


position: coding

- [1. Leetcode Solution](https://leetcode.com/problems/longest-palindromic-substring/solution/)
- [2. Leetcode 比较好的解法](https://leetcode.com/problems/longest-palindromic-substring/discuss/)


### <a name="Regular-Expression-Matching"></a>正则表达式匹配

position: 理解题意


对于Example 3我比较存疑

Example 3:

```
Input:
s = "ab"
p = ".*"
Output: true
Explanation: ".*" means "zero or more (*) of any character (.)".
```

#### Recursion


### <a name="Wildcard-Matching"></a>通配符匹配


#### 思路一: 递归

去掉匹配字符的子串仍是匹配的, 注意几个规则:

>* p中相应位置是普通字符或?, 直接进行匹配. 匹配成功则在s、p同时将该字符去掉
>* p中相应位置是*，向前看一位, 分三种情况: a). 如果前面为空or*, 直接返回return; b). 如果前面为普通字符, 则在s中一直向前去字符直至匹配到该普通字符; c). 如果前面为?, s不为空直接返回true, s为空直接返回false

代码:

```
待填充

```


position: coding

### <a name="Longest-Common-Prefix"></a>Longest Common Prefix

#### 拨洋葱

LCP(S_1, S_2,..., S_n)代表[S_1, S_2,..., S_n]的Longest Common Prefix, 则有如下递推:

LCP(S_1, S_2,..., S_n) = LCP(LCP(S_1, S_2,..., S_n-1), S_n)

注意: 在迭代过程中只要出现empty string, 算法就可以终止了.

position: coding

#### 垂直扫描

统计同位置的相同元素个数

position: coding

#### 分治法

LCP(S_1, S_2,..., S_n) = LCP(LCP(S_1, S_2,..., S_k), LCP(S_k+1, S_2,..., S_n))

position_c2: coding

#### 二分搜索

将一个字符串拆成两半

position_c3: coding

##### Further Thoughts / Follow up

[Further thoughts/follow up](https://leetcode.com/problems/longest-common-prefix/solution)

这个问题可以用普通的LCP算法来解决, 只不过对于频繁的LCP query是否有优化方案呢?

position_c4: 弄清楚利用trie进行优化的原理, coding

#### Trie

trie 用于检索一个字符串集合中的任意一个字符串, 可应用于自动补全、拼写检查、IP路由. 相对于balanced trees以及hash tables的特色为:

>* Finding all keys with a common prefix.
>* Enumerating a dataset of strings in lexicographical order.


position_c: [implement trie(prefix tree----Another reason why trie outperforms hash table, is that as hash table increase...](https://leetcode.com/articles/implement-trie-prefix-tree/) (ps: 理解trie算法, 掌握如何从[S_1,..., S_n]中构建一个trie, 然后实现优化的LCP query

### <a name="search"></a>搜索

___广度搜索:___

+ 寻找每个状态的所有下一个可能性, 停止规则就是找到目标了立马停止

### <a name="experience"></a>经验

题型: 线性结构、树形结构、图形结构、高级算法

+ 技巧1: 每天循环上面的类型

note1:

+ idea: 手算、拨洋葱(拆成相同的子问题)
+ 前、中、后序遍历的通用解法: 定义op为vist和print, 也就是压栈的时候压(节点和操作类型)
+ rotate image: 一圈圈的转

动态规划

+ 倒推, eg: 3158(312. Burst Balloons)

时间短、任务急刷这个list:

+ leetcode 697. Degree of an array
+ leetcode 611: valid triangle number, tip: 最小两边大于第三边. 1. 枚举, 2. 如何O(n^2)
+ leetcode 592: Fraction Addition and Subtraction, tip: 约分公式
+ leetcode 454: 4sum, tip: O(n^4) to O(n^2), hash
+ leetcode 412: Fizz Buzz
+ leetcode 398: Random Pick Index, tip: 水塘抽验, 终局思维(不理解)
+ leetcode 395: Longest substring with At least K repeating characters
+ leetcode 放气球, tip: 终局思想
+ leetcode 会议室开会: tip: 贪心
+ leetcode n: xxx

生长学习法:

+ 还原事物从无到有的过程, 想清楚每个环节的why
+ 如何想到的(不懵，把每一步手算、抽象)
+ 手算、抽象
+ 终局思维: 终
+ 线性表里stack的题比较难, tip: 一步步走, 总结各种case局的时候是什么情况, 然后忘前推

动态规划:

+ 确定子问题、边界
+ 确定递推式子

resource:

+ [Wildcard-Matching](http://www.mamicode.com/info-detail-986984.html)

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/)
