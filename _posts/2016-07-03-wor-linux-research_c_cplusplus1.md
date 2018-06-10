---
layout: post
title: "整理自为知笔记的关于c和c++的(1)"
date: 2016-07-03
description: "这是在实习期间做的笔记"
tag: Bundle
---

### C部分

while

    while(*dst = *src)
    {
      do_somethind;
    }

`*dst = *src`依次完成：赋值、测试赋值、指针递增, 这三个操作组成一个原子操作, 因此while循环执行完后src，dst指向‘\0’的后一位, __该部分看完代码后进一步确定__.

main

通常我们在写主函数时都是void main()或int main() {..return 0;},但ANSI-C(美国国家标准协会,C的第一个标准ANSI发布)在C89/C99中main()函数主要形式为:

>* 1. int main(void)
>* 2.int main(int argc,char *argv[]) = int main(int argc,char **argv)
其参数argc和argv用于运行时,把命令行参数传入主程序.其中ARG是指arguments,即参数.具体含义如下:
>* 1. int argc:英文名为arguments count(参数计数)
>* 2. char **argv:英文名为arguments value/vector(参数值)

命令行两个参数为例`./xxx 2 5`:

>* argc 为3
>* argv[0] 指向程序运行时的全路径名, 即`path/to/xxx`
>* argv[1] 指向程序在DOS命令中执行程序名后的第一个字符串, 即`2`
>* argv[2] 指向执行程序名后的第二个字符串, 即`5`
>* argv[argc] 为NULL.

#### c的一些技巧 part1:

>* 1. double test = atof("10.5")
>* 2. int test = atoi("10");
>* 3. c不允许函数中定义函数

>* 4. 得到小于等于整数n的，且为2^m的倍数的整数:

    int n = 33;//n为任意输入的整数
    int m = 2;//m任意值
    n = (n>>m)<<m;
    运行后n为:32;

>* 5. n>>=1;//n = n/2;
>* 6. n&m,按位与：同时为1，值才能为1；n|m,按位或：出现1，则为1；n^m,按位异或，只有相反才为1, 异或具有交换律和结合律，由b^(a^b)=>a和a^(a^b)=>b得到一个交换两个整数值而不需要第三个变量的算法，具体实现为：

    a = a^b;
    b = b^a;
    a = b^a;
    --split-----
    int a;
    int b;
    int c;
    if(a == b)
        c = 1;
    else
        c = 0;
    这段代码等价写法:
    c = !(a ^ b)

>* 7. 赋值语句的结合性，自右向左。因此a=b=c=1的执行顺序是：

    c=1;
    b=1;
    a=1;

>* 8. 外部变量或函数的作用域：从声明开始到文件结束
>* 9. 外部变量：独立于任何函数
>* 10. 外部变量只能在一个文件中定义一次，在其他文件中使用时要加extern声明
>* 11. 头文件存储着共享的东西
>* 12. 用static声明限定外部变量和函数，可以将其后声明的对象的作用域限定为被编译源文件的剩余部分，因而，static限定的变量或函数不会和同一程序中其他源文件中同名的变量或程序冲突
>* 13. static类型的内部变量特点：作用域为本函数，但是不管该函数是否被调用，static类型的内部变量一直存在，eg：

    void test(){
    static int a = 8;
    a++;
    printf("a:%d\n",a);
    }
    main(){
    put();
    put();
    put();
    return 0;
    }
    结果为：
    a:8
    a:9
    a:10

>* 14. 变量的声明除了可以紧跟在函数开始的花括号之后，还可以跟在任何符合语句的左花括号之后，这种方式可以隐藏程序块之外的同名变量
>* 15. 不进行显示初始化时，外部变量、静态变量初始化为0，自动变量和寄存器变量的初值为无用信息外部变量和静态变量在程序开始执行前就会被初始化，且他们的初始化必须为常量表达式
>* 16. 预处理器是编译过程中单独执行的第一个步骤
>* 17. *作用于指针：访问指针所指向的对象
>* 18. 数组名代表第一个元素的地址
>* 19. 字符串常量是一个字符数组
>* 20. 二维数组是一种特殊的一维数组，即元素为一维数组
>* 21. 函数的参数如果为二维数组，那么必须指出该数组的列数，行数无所谓
>* 22. 指针数组，放的是指针，如： char *month[] ={"hello","hello1"}.ps:将char和*连起来看，同二维数组相比，指针数组的优点是：数组的每一行长度可以不同
>* 23. 命令行参数:main(int argc,char* argv[]),argc表示运行程序时命令行中参数的个数，第二个参数是一个指向字符串数组的指针`int *a = 5;a`叫做指向整形的指针，`char *month[] ={"hello","hello1"}；month`叫做指向字符串数组的指针，可见其叫法可由右侧的初始化类型决定
>* 24. 函数指针可以被赋值，存放在数组中，传递给函数以及作为函数的返回值[5.12复杂声明]
>* 25. 

    int *t = malloc(10*sizeof(int));
    t[0] = 250;t[1] = 251;
    int g = *t++;
    int gg = *t;
    输出：g:250, gg:251
>* 26.

    struct point {
    int x;
    int y;
    }
>* 27.

    typedef struct{
    int x;
    int y;
    }Point;
    然后用Point直接定义对象 Point p = {3,6};其中typedef的作用为：用来建立新的数据类型名(重命名)，如：typedef int length

>* 28. 联合union，目的：一个变量可以合法的保存多种数据类型中任何一种类型的对象。特点：联合是一个结构，它的所有成员相对于基地址的偏移量都为0

    typedef union{
    char g;
    int gg;
    float ggg;
    double gggg;
    }L;
    sizeof(L):结果为8，也就是最大类型double的长度
    L test;
    int a = 250;
    float b= 251.8;
    test.gg = a;
    test.ggg = b;
    执行后test.ggg才有意义
    结合代码：union的特点是：它是一种动态类型的变量

>* 29.

    int flag = 0;
    flag |= 01 | 02;
    将flag的第一位和第二位设置成1(|或运算符)
    flag &= ~(01|02)
    将flag的第一位和第二位设置成0(&与运算符)

>* 30. 直接访问字中的位字段

      typedef struct{
        unsigned char a : 2;
        unsigned char b : 2;
        unsigned char c : 4;
    }flag;
    sizeof(flag)：运行后为：1(即一个字节)
    typedef struct{
        unsigned char a : 3;
        unsigned char b : 2;
        unsigned char c;
    }flag;
    sizeof(flag)：运行后为：2(注意内存对齐）
    声明为unsigned保证他们是无符号常量
    typedef struct{
        unsigned char a : 4;
        unsigned char :4;
        unsigned char b : 2;
        unsigned char :0;
        unsigned char c;
    }flag;
    sizeof(flag)：运行后为：3( 无名字段 :0 强制在下一个字边界上对齐；无名字段：4起到填充作用）
>* 31. 文本流由一系列的行组成，每一行的结尾都是一个换行符

    getchar:从标准输入一次读取一个字符；
    while((c = getchar())!= EOF){.....};终端任意输入，然后敲回车，才会进入while循环迭代执行
>* 32.

     int t1;
     int t2;
     float t3;
     scanf("%d %d %f",&t1,&t2,&t3);
     printf("The output is t1:%d, t2: %d, t3: %f\n",t1,t2,t3);
>* 33. 负数的表示，最高位为0表示正数，最高位为1表示负数，如果整数用n个bit表示，则最高位的权重为-2^(n-1)，注意是负的权重，对于其他位置，比如j位(从右记位，起始位为1)权重为2^(j-1)，那么最后表示的负数就为各个位置的加权和。eg: int x = -6；则x的二进制表示为: fffffffa,根据上面的计算方法有：-2^31 + 2^30 + 2^29 + ... + 2^3 + 2^1
>* 34. 负数的符号位扩展不影响数的大小，拿上面的例子来说，无论在前面补多少个1，最终的结果仍然是-6，当然最高位为符号位

>* 35. 固定小数点的折算(固定小数点的折算与实现)

>* 36.

    int y = 0xc0000000;
    float test = 0xc0000000;
    if( 0xc0000000 == y)
       printf("1: -------------\n");
    if( 0xc0000000 == test)
       printf("2: -------------\n");
    if(y == test)
       printf("3: -------------\n");
    输出结果：第一个和第二个判断都成立，第三个判断不成立，因此打印1，2，由此可知，如果判断中出现常数，那么就根据其二进制表示进行比较，而对于第三个判断，就会先统一类型，然后进行二进制的比较

>* 37. 编译与链接的原则是：

    a. 改了就重新编译: 头文件改了，引用改头文件的c文件也得重新编译
    b. 只要有重新编译，就要发生链接
    c. makefile 是make进行编译和链接的说明书
    target：prerequisite
    command
    官方解释：
    target这一个或多个的目标文件依赖于prerequisites中的文件，其生成规则定义在command中 
    自己的理解：
    prerequisites中如果有一个以上的文件比target文件要新的话，command所定义的命令就会被执行。这就是Makefile的规则。也就是Makefile中最核心的内容。 

#### c的一些技巧 part2:

C语言中应用内存管理有两种方式，一种是系统管理，一种是应用自管理。

>* 1. 系统管理方式是指应用直接使用系统malloc和free函数进行内存申请和释放，由系统管理内存的使用情况。
>* 2. 应用自管理方式一般是使用内存池管理技术，一次性向系统申请应用需要的一大块内存，然后使用内存池把这块内存管理起来。

怎么查看gcc的预处理输出呢？

    gcc -E hello.c -o test.c

__含义__ ：test.c是预编译后的输出，hello.c是程序员写的源代码. 不管结构体的实例是什么——访问其成员其实就是加成员的偏移量（看testPointer.c）

__注意__ ：如果成员是数组，那么访问的是数组的相对地址，如果成员是指针，那么访问的是指针所指向的内容，因此如果实例代码中，如果str的s换成char* s的话，程序会在f.a->s时挂掉。

Puzzle 1(网上整理的, 原始出处记得加引用undone): 此段程序的作者希望输出数组中的所有元素，但是他却没有得到他想要的结果，是什么让程序员和计算机产生歧义？

    #include<stdio.h>
    #define TOTAL_ELEMENTS (sizeof(array) / sizeof(array[0]))
    int array[] = {23, 34, 12, 17, 204, 99, 16};
    int main()
    {
      int d;
      for(d = -1; d <= (TOTAL_ELEMENTS-2);d++)
        printf("%d\n", array[d+1]);
      return 0;
    }

__解答__: 运行上面的程序，结果是什么都没有输出，导致这个结果的原因是sizeof的返回值是一个unsinged int，为此在比较int d 和TOTAL_ELEMENTS两个值都被转换成了unsigned int来进行比较，这样就导致-1被转换成一个非常大的值，以至于for循环不满足条件。因此，如果程序员不能理解sizeof操作符返回的是一个unsigned int的话，就会产生类似如上的人机歧义。

>* 1. 宏替换顺序：一个宏的参数是另一个宏，先替换外面的宏，后替换参数。因此#define _ToStr(x) #x以后_ToStr(a+b)相当于"a+b"，而#define X a+b 再_ToStr(X)的结果相当于"X"——先替换外面的宏，给X加了引号，再替换里面的宏，对" "内的宏名不替换。

>* 2. 宏替换顺序：一个带参数的宏内部调用另一个宏，参数也是一个宏，则先替换外层的宏，再替换外层宏的参数，最后替换内层宏。因此采用两层转换之后，外边的宏先被替换了，但没有完全展开，然后参数被替换了(保证参数是宏时被展开)，最后外边的宏展开。

>* 3. 总之由外向里替换，遇到#要执行；或者：外宏，外参数，内宏，中间任何环节遇到#或者##都要执行，然后看能不能替换，这种说法解答了testHong.c。

Puzzle 2(网上整理的, 原始出处记得加引用undone): 下面这段程序输出什么?

    #include<stdio.h>

    int main()
    {
      float f = .0f;
      int i;
      for(i = 0; i < 10; i++)
        f = f + .1f;
      if(f == 1.0f)
        printf("f is 1.0 \n");
      else
        printf("f is NOT 1.0 \n");

      return 0;
    }

__解答__:不要让两个浮点数相比较。所以本题的答案是”f is NOT 1.0″，如果你真想比较两个浮点数时，你应该按一定精度来比较，比如你一定要在本题中做比较那么你应该这么做`if( (f – 1.0f)<0.1 )`

>* 1.通过手动写makefile文件可以可以替换掉IDE
>* 2.CMake是一个编译配置工具，可以根据不同平台，编译器生成相应的makefile，通过编写CMakeLists.txt，可以控制生成的Makefile，从而控制编译过程

### vim部分

一些我没怎么用的命令:

>* :help regular-expression --- 查看正则表达式
>* ctrl + w, >, <  ---- 调整宽度
>* ctrl + w, =, -, +  ---- 调整高度

#### ref

- [1. Active Shape Models with SIFT Descrip-tors and MARS](www.milbo.org/stasm-files/active-shape-models-with-sift-and-mars.pdf)

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
