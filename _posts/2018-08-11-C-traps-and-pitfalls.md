---
layout: post
title: "Notes of C traps and pitfalls
date: 2018-08-11 
description: "Notes about C traps and pitfalls."
tag: Computer Basises
---

### C traps and pitfalls

Here is my notes about the book ___C traps and pitfalls____.


Lexical

#### Token

_>* += are two tokens. 
>* A _string enclosed in double quotes, on the other hand, is a short-hand way of writing a pointer to a nameless arrays.
>**** writing ’yes’ instead of "yes" may well go undetected. The latter means ‘‘the address of the first of four consecutive memory locations containing y,
e, s, and a null character, respectively.’’ The former means ‘‘an integer that is composed of the values of
the characters y, e, and s in some implementation-defined manner.’’ Any similarity between these two
quantities is purely coincidental. 

Syntactic

#### Declarations

>* declaration has two parts: a ___type___ and a list of stylized ___expressions___ that are expected to evaluate to that type.
>* writting a cast for that type:___remove___ the ___variable name and the semicolon___ from the declaration and ___enclose___ the whole thing in parentheses. 
>* we cast 0 to a 'pointer to function returning void' by saying ___(void (*)())0___.
>* precedence level: function call > unary operators > 
>* Casts are unary operators,have the same precedence as any other unary operator.   
>* Unary operators are right-associative, so *p++ is *(p++).
>* binary operators: arithmetic operators > shift operators > relational operators > logical operators > assignment operators > conditional operator. 
>* all the compound assignment operators have the same precedence and they all group right to left, so that
a = b = c means the same as b = c; a = b; 
>* Lowest of all is the comma operator. 
>* The Dangling else Problem.: Here is the rule that an else is always associated with the closest unmatched if. 

#### Linkage

>* You Must Check External Types Yourself:  
>* Although arrays and pointers behave very similarly in some contexts, ___they are not the same___. 
>* Although using the name of ___an array of characters___ will generate a pointer to the first element of that array, that pointer is generated as needed and not actually kept around. 
>* char filename[] = "/etc/passwd"; char *filename;: The two declarations of filename use storage in different ways; they cannot coexist.  

#### Semantic Pitfalls 

>* Expression Evaluation Sequence: Only the four C operators &&, ||, ?:, and , specify an order of evaluation. All other C operators evaluate their operands in undefined order. 
>* the assignment operators do not make any guarantees about evaluation order. 
>* Integer Overflow: If either operand is unsigned, the result is unsigned, and is defined to be modulo 2^n, where n is the word size. If both operands are signed, the result is undefined.   
>* Shift Operators: In a right shift, If the item being shifted is ___unsigned___, zeroes are shifted in. If the item is signed, the implementation is permitted to fill
vacated bit positions either with zeroes or with copies of the sign bit. If you care about vacated bits in a
right shift, declare the variable in question as unsigned. You are then entitled to assume that vacated bits
will be set to zero. 

#### Library Functions 

>* setbuf (stdout, buf): it tells the I/O library that all output written to stdout should henceforth use buf as an output buffer, and that
output directed to stdout should not actually be written until buf becomes full or until the programmer
directs it to be written by calling fflush. The appropriate size for such a buffer is defined as BUFSIZ in
<stdio.h>.  

#### The Preprocessor

>* The programs we run are not the programs we write: they are first transformed by the C preprocessor. 
>* Macros: we may want to define things that appear to be functions but do not have the execution over-
head normally associated with a function call 
>* Macros are not Functions: Be careful for ___an operand that is used mul-times may be evaluated mul-times___, especially for operator such as xx[i++], *xx++.
>* Macros are not Functions:

#### Portability Pitfalls 

>* C compilers usually produce object programs that must then be processed by loaders in order to be able to access library subroutines. Loaders, in turn, often impose
their own ___restrictions___ on the kinds of names they can handle. 
>* External identifiers, which are used by various assemblers and loaders, are more restricted, so, Because of all this, it is important to be careful when choosing identifiers in programs intended to be
portable.   
>* If you care whether a character value with the high-order bit on is treated as a negative number, you
should probably declare it as unsigned char. Such values are guaranteed to be zero-extended when
converted to integer, whereas ordinary char variables may be signed in one implementation and unsigned
in another. 
>* if c is a character variable, one can obtain the unsigned integer equivalent of c by writing (unsigned char) c(I am not very convinced for the explanation) 
>* Calling realloc with a pointer to an allocated area and a new size stretches or shrinks
the memory to the new size, possibly copying it in the process. 
>* The Seventh Edition of the reference manual for the UNIX system contains a copy of the same paragraph.
In addition, it contains a second paragraph describing realloc:
Realloc also works if ptr points to a block freed since the last call of malloc, realloc, or calloc; thus
sequences of free, malloc and realloc can exploit the search strategy of malloc to do storage com-
paction. Thus, the following is legal under the Seventh Edition:

```
free (p);
p = realloc (p, newsize);
```

This idiosyncrasy remains in systems derived from the Seventh Edition: it is possible to free a storage
area and then reallocate it. By implication, freeing memory on these systems is guaranteed not to change
its contents until the next time memory is allocated. Thus, on these systems, one can free all the elements
of a list by the following curious means:
```
for (p = head; p != NULL; p = p->next)
free ((char *) p);
```
without worrying that the call to free might invalidate p->next. Needless to say, this technique is not recommended, if only because not all 
C implementations preserve memory long enough after it has been freed. However, the Seventh Edition manual leaves one thing
unstated: the original implementation of realloc actually required that the area given to it for reallocation be
free first. For this reason, there are many C programs floating around that free memory first and then reallocate it, and this is something 
to watch out for when moving a C program to another implementation.

position_c: [Portability Pitfalls]

#### Good cases for me

>** case1: the following way of copying the first n elements of array x to array y doesn’t work


```
i = 0;
while (i < n)
  y[i] = x[i++];

or


i = 0;
while (i < n)
  y[i++] = x[i];

```

The exploration of the book: ___The trouble is that there is no guarantee that the address of y[i] will be evaluated before i is incremented.___

My viewpoint: 

1. Perhaps the address of y[i] will be evaluated after i is incremented, then y[0] is not assigned.
2. Perhaps the address of y[i] will be evaluated befor i is incremented, and that is we expected.

>** case2: 

```
main()
{
  int i;
  char c;
  for (i=0; i<5; i++) 
  {
    scanf ("%d", &c);
    printf ("%d ", i);
  }
  printf ("\n");
}

```

Ostensibly, this program reads five numbers from its standard input and writes 0 1 2 3 4 on its
standard output. In fact, it doesn’t always do that. On one compiler, for example, its output is 0 0 0 0
0 1 2 3 4.

___Hint___: The memory near c may be resetted to zero.

>** case3: Overflow test

Suppose, for example, that a and b are two integer variables, known to be non-negative, and you
want to test whether a+b might overflow.

```
if (a + b < 0)
  complain();
```

The point is that once a+b has overflowed, all bets are off as to what the result will be. For example,
on some machines, an addition operation sets an internal register to one of four states: ___positive___, ___negative___,
___zero, overflow. On such a machine, the compiler would have every right to implement the example
given above by adding a and b and checking whether this internal register was in negative state afterwards.
If the operation overflowed, the register would be in overflow state, and the test would fail.

One correct way of doing this particular test relies on the fact that ___unsigned arithmetic is well-defined__
for all values___, as are the conversions between signed and unsigned values:

```
if ((int) ((unsigned) a + (unsigned) b) < 0)
  complain();
```

>** case3: 

```
void printnum (n, p)
{
  if (n < 0) 
  {
    (*p) (’-’);
    printneg (n, p);
  } 
  else
    printneg (-n, p);
}

void printneg (n, p)
{
  long q;
  int r;
  q = n / 10;
  r = n % 10;
  // forRecall that integer division behaves in a somewhat implementation-dependent way when one of the operands is negative. 
  if (r > 0) 
  {
    r -= 10;
    q++;
  }
  if (n <= -10)
    printneg (q, p);
  (*p) ("0123456789"[-r]);
}

```

### Review:

There are too many details I did not care befor, and I will review them frequently from now on.

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2018/06/today/) 
