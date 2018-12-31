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


___Sat Dec 29 09:24:54 CST 2018(dynamic-programming):___

+ 64
+ 72
+ 85(dp[i][j] = max(dp[i-1][j], d[i][j-1], S[i][j]))
+ 87(3d-dp,[i, j, n])
+ 91(focus on the '0', it is a priority with me)
+ 95(m思路: 从小往大生成，新来一数，肯定比现有的节点都大 那么n可以成为现在所有树的父节点，并且他们都是n的左子树 第二步就是沿着现有子树的右侧尝试不断插入。 如果插入以后，n还有子树，那么这些子树都是n的左子树)
+ 96(列出所有的子问题, it is a priority with me)
+ 97(m思路: dp[i][j]: 代表子问题[a_1, ..., a_i]和[b_1, ..., b_j]是否可以拼成[c_1, ..., c_i+j], 遍历[c_i+j+n-1,...,c_i+j] && dp[i-*][j-*], 其中n满足[1, i+j])
+ 115[it is a priority with me](m思路： dp[i][j]: 代表子问题[a_1, ..., a_i]和[b_1, ..., b_j]，分两种情况. case1: a_i != b_j, 此时递归式为: dp[i][j] = dp[i-1][j](意味着a_i一定要剔除); case 2: a_i == b_j, 此时递归式为: dp[i][j] = dp[i-1][j] + dp[i-1][j-1](前者代表删除了a_i, 后者代表保留a_i).)
+ 123(2d-dp[hard], local and global, not very clear, it is a priority with me)
+ 132(m思路: dp[i][j]代表[a_i,...,a_j]的最小切割次数, 则递推式为dp[i][j]=min(dp[i][i+m]+dp[i+m+1][j]))
+ 139(m思路: dp[i]represents the subproblem[a_i,...,a_n], so the relationship is: dp[i] = s[a_i,...,a_j] && dp[j+1])
+ 140(hard, funny, it is a priority for me. m思路: 思路同139差不多, 用dp[i]代表[a_i,...,a_n]的结果(<i, vector<string> >), 则对于dp[i]: if(s[a_i,...,a_j]) for s:dp[j+1] res.push_back(s[a_i,...,a_j] + s). 最后返回dp[1]就可以了.)
+ 152(medium, it is a priority for me. m思路: dp[i]代表[a_i,...a_n]之间的子序列的最大乘积, s[i]代表以a[i]打头的最大乘积, 则递推式为: dp[i] = max(s[i], dp[i+1])
+ 174(hard, it is a priority for me. m思路: dp[i][j]代表所需要的最小血量, s[i][j]为相应的剩余血量. dp[i][j] = min{func(dp[i-1][j], s[i-1][j], d[i][j]), func(dp[i][j-1], s[i][j-1], d[i][j])}, 然后, 再确定相应的剩余血量.)
+ 188(it is similar to 123)
+ 198(m思路: dp[i]代表[a_i,...,a_n]被偷的最大金额, 则递归式易知: dp[i]=max(a_i+dp[i+2], dp[i+1]).ps: 前面代表a_i被偷, 后面代表a_i没被偷.)
+ 213(m思路: 这道题的思路同上一个类似, 需要分情况讨论： case1： a_1抢, a_2不抢, a_n抢, 则[a_3,...,a_n-1]就是198所处理的问题; case2: a_1不抢, 【a_2,...,a_n]就是198所处理的问题, 然后max一下就行了.)
+ 221(medium, it is a priority for me. m思路: dp[i][j]代表矩形里的最大正方形面积, 递推式: dp[i][j] = max{dp[i-1][j], dp[i][j-1], m[i][j]开头的最大正方形面积}, m[i][j]仍然可以拆分成子问题)
+ 256(need to buy)


+ summary1: 编辑距离这道题在看到题解后发现我的问题：1. 确定不出子问题 2. 递推式写不出来。我发现, dp的子问题拆分都差不多, 我将其称作索引话. 递推式的写法, 要考虑到所有的子问题的情况, 以及他们之间的关系.
+ summary2: 87 is a 3d-dp problem.

resource:

+ [Wildcard-Matching](http://www.mamicode.com/info-detail-986984.html)
+ [Edit Distance](https://www.dreamxu.com/books/dsa/dp/edit-distance.html)
+ [Scramble String---recursion](http://www.shilei.club/index.php/2018/08/15/article13/)
+ [Scramble String---non-recursion)](http://www.lisite.top/author/lisite/page/5)
+ [Best Time to Buy and Sell Stock III](https://blog.csdn.net/linhuanmars/article/details/23236995)


___Sun Dec 30 09:56:06 CST 2018(tree):___

广度优先:

+ 将已发现和未发现的顶点沿着广度的方向进行扩展
+ 白色: 未发现; 顶点被发现了变成非白色(灰色、黑色)
+ $(u, v) \in E$, 如果u是黑色的, 那么v一定是非白色(已经被发现);
+ 广度优先搜索构造了一颗广度优先树 

深度优先:

+ 时间戳: 着色为灰时d[v], v的邻接表被完全检索后(着色为黑)记为f[v]
+ 定点u在d[u]前为白色，[d[u], f[u]]之间为灰色, f[u]以后为黑色

inorder、preorder、postorder的几个关键点:

+ preorder最简单, 用一个stack一直压进去就可以了, 注意要先压右子节点
+ inorder和postorder大体差不多, 先用stack一路将p(当前所访问的节点)到叶子节点入栈, 然后处理根和右子树. inorder要先访问根然后将右子树给p(人为实现的递归过程), 而postorder则要先确定右子树是否访问了, 访问了则访问根, 没访问就要把右子树给p(人为实现的递归过程)
+ inorder需要一个p来指示当前访问的节点, postorder除了需要p以外, 还需要visited来标示p的子树的访问情况

___Mon Dec 31 09:20:41 CST 2018(tree):___

+ 思考1: 仰视图, 考虑遮挡问题
+ 思考2: print_tree

summary:

+ 对于验证二叉树这道题: 用中序遍历代码最简单, 如果左树合理, 只需要知道其最大值, 然后和根判断, 然后判断到右子树可.
+ 中序遍历的性质: 输出的序列一定是从小到大排列的, 因此, 如果考虑输出序列的话, 只需要确定$p_i > \max_{j < i}{p_{j}}$, 因此用一个变量记录这个max值即可.
+ 后序遍历也是可以做的, 就是稍稍麻烦一点, 思路就是用后序模拟中序, 即在进入右子树开始的那个时刻先和根判断一下


<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/)
