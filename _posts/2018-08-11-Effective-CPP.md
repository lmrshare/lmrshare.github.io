---
layout: post
title: "Effective C++"
date: 2018-08-11 
description: "Notes about Effective C++"
tag: Computer Basises
---

### Effective C++

Here is my notes about the book Effective C++.

#### Introduction

>* Declaration:tells compilers about the name and type of something, but it omits certain details.
>* size_t: the type size_t in namespace std . That namespace is where virtually everything in C++’s standard library is located.size_t , by the way, is just a typedef for some unsigned type that C++
uses when counting things. It’s also the type taken by the operator[] functions in ___vector , deque , and
string , a convention we’ll follow when defining our own operator[] functions___. 
>* Signature: Reveal function's ___type___, Specially, ___parameter and its type___ represent the signature.
>* default constructor: It can be called without any arguments. Such a constructor either has no parameters or has a
default value for every parameter.
>* Declaried constructor: That prevents them from being used to perform implicit type conversions,
though they may still be used for explicit type conversions 
>* copy constructor:is used to ___initialize___ an object with a different object of the same type.a particularly
important function, because it defines how an object is passed by value. Pass-by-value means call the copy constructor.
>* copy assignment operator: copy the value from one object to another of the same type. 

#### Accustoming Yourself to C++ 

___Item 1:___

>* Sublanguage: C, Object-Oriented C++, Template C++, STL. 
>* Object-Oriented C++: Classes (including constructors and destructors), encapsulation,
inheritance, polymorphism, virtual functions (dynamic binding) 
>* Switch from one sublanguage to another: You should change strategy. eg:

___case1:___ pass-by-value for built-in type(C-like) is of efficiency.

___case2:___ Utilize pass-by-reference from C part of C++ to oriented-C++ part.

___case3:___ When you cross into the STL, however, you know that iterators and function objects are modeled on pointers in C,
so for iterators and function objects in the STL, the old C pass-by-value rule applies again. 

___Item 2:___ Prefer consts, enums, and inlines to #defines.

>* Confused #define ASPECT_RATIO 1.653: You may have no idea where 1.653 came from. 
1) preprocessor remove ASPECT_RATIO 2_) ASPECT_RATIO may not get entered into symbol table.
3) you can replace the macro with const double ASPECT_RATIO = 1.653 for ASPECT_RATIO is definitely seen by compilers. 
>* class-specific constants: To limit the scope of a constant to a class, you must make it a member, and to
ensure there’s at most one copy of the constant, you must make it a static member.
>* there’s no way to create a class-specific constant using a #define , because #defines don’t respect scope. Once a
macro is defined, it’s in force for the rest of the compilation (unless it’s#undefed somewhere along the line) 
>* Older complier case think it is illeagal to provide a initiallizationfor a static class member at its
point of declaration, so it should be:

```
class CostEstimation
{
  static const double FudgeFactor;//declaration 
  ...
}

const double CostEstimation::FudgeFactor = 1.35;//definitaion
```

>* compilers insist on knowing the size of the array during compilation, however initial static const integer is 
illegal(older compiler), you can do it like this: 

```
class GamePlayer {
private:
enum { NumTurns = 5 };//the values of an enumerated type can be used where int s are expected
int scores[NumTurns];
...
// “the enum hack” — makes
// NumTurns a symbolic name for 5
// fine
};


```

>* enum hack behaves in some ways more like a #define than a const does. 
For example, it’s legal to take the address of a const, but it’s not 
legal to take the address of an enum, and it’s typically not legal to 
take the address of a #define, either. If you don’t want to let people
get a pointer or reference to one of your integral constants, an enum is
a good way to enforce that constraint. 
>* Also, though good compilers won’t set aside storage for const objects of
integral types (unless you create a pointer or reference to the object), 
sloppy compilers may, and you may not be willing to set aside memory for 
such objects. Like #define s, enums never result in that kind of unnecessary
memory allocation. 
>* How to get all the efficiency of a macro plus all the predictable behavior 
and type safety of a regular function by using a template for an inline function 

```
template<typename T>
inline void callWithMax(const T& a, const T& b)
{
f(a > b ? a : b);
}

```

___Item 3:___ Use const whenever possible 

>* Const: firstly, Look forward , then it can not be changed. Look backward if there is nothing
forward, then the nearest thing can not be changed.
>* STL iterators are modeled on pointers, so an iterator acts much like a T* pointer. 
>* const_iterator act like const T*.

```
const std::vector<int>::iterator iter = vec.begin(); // act like T* const
std::vector<int>::const_iterator iter = vec.begin(); // act like const T*
```

>* Within a function declaration:const can refer to the function’s ___return value___,
to individual ___parameters___, and, for member functions, to ___the function as a whole___.

>* Return value is const: ___reduce the incidence of client errors___ without giving up
safety or efficiency. 


```
class Rational { ... };
const Rational operator*(const Rational& lhs, const Rational& rhs);

//client behavior
Rational a, b, c;
(a * b) = c;
// invoke operator= on the
// result of a*b!
// Although it is incredible, It may be a mistake, like: if(a* b = c)

```

>* const member function: identify which member functions may be invoked on const objects. 
1)you know which functions may modify an object and which may not. 2)they make it possi-
ble to work with const objects. That’s a critical aspect of writing effi-
cient code, because, as Item 20 explains, one of the fundamental ways
to improve a C++ program’s performance is to pass objects by refer-
ence-to- const . That technique is viable only if there are const member
functions with which to manipulate the resulting const -qualified
objects. 

position_c: think about it

#### xxx

>* yyy

### Review:

There are too many details I did not care befor, and I will review them frequently from now on.

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2018/06/today/) 
