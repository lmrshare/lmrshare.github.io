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

>* const member function: Identify which member functions may be invoked on const objects. 
1)you know which functions may modify an object and which may not. 2)they make it possible
to work with const objects. That’s a critical aspect of writing effcient code, because, as
Item 20 explains, one of the fundamental ways to improve a C++ program’s performance is to
pass objects by reference-to- const. That technique is viable only if there are const member
functions with which to manipulate the resulting const-qualified objects. 

>* member functions differing only in their constness can be overloaded, and this is an 
important feature of C++. 
>* Compilers insist on bitwise constness. What to do?--- mutable. eg:

```
class CTextBlock
{
  public:
    CTextBlock()
    {
      text = "Hello";
    }

    char& operator[](std::size_t position) const
    {
      return text[position];
    }

    std::size_t length() const
    {
      if(!len_is_valid)
      {
        text_length = strlen(text);
        len_is_valid = true;
      }

        return text_length;
    }

    void print() const
    {
      text[0] = 'J';
      std::cout << text << std::endl;
    }
  private:
    char *text;
    mutable std::size_t text_length;
    mutable bool len_is_valid;

};

```

>* non-cast member function call the cast one. 

```
class TextBlock
{
  public:
    ...
  const char& operator[](size_t position) const;
    {
        ...
        ...
        ...
    }
  char& operator[](size_t position)
  {
    return
      const_cast<char&>(
          static_cast<const TextBlock&>(*this)[position]
          );
  }
};

```

>* Declaring something const helps compilers detect usage errors. const can be applied
to objects at any scope, to function parameters and return types, and to member functions
as a whole.
>* Compilers enforce bitwise constness, but you should program using logical constness.
>* When const and non- const member functions have essentially identical implementations,
code duplication can be avoided by having the non-const version call the const version. 

___Item 4:___ Make sure that objects are initialized before they’re used. 

>* C++ stipulate that data members of an object are initialized before the 
body of a constructor is entered. So, it is better to use the member initialization
list instead of assignments.

```

ABEntry::ABEntry(const std::string& name, const std::string& address,
const std::list<PhoneNumber>& phones)
: theName(name),
theAddress(address),
// these are now all initializations
thePhones(phones),
numTimesConsulted(0)
{} // the ctor body is now empty

```

Hint: 1). Copy constructor insteads of default constructor with assignments. 2) The  
The assignment-based version wasted the work of default constructor.

>* No parameter case:

```
ABEntry::ABEntry()
: theName(),//call theName’s default ctor;
theAddress(),//do the same for theAddress and thePhones, but not for numTimesConsulted;
thePhones(),
numTimesConsulted(0)
{}

```

>* A translation unit is the source code giving rise to a single object file. It’s
basically a single source file, plus all of its #include files. 

>* the relative order of initialization of nonlocal static objects defined in different
translation units is undefined. How can you be sure that a non-local object will be 
initialized before another?----Singleton. 

Singleton here realizes that move each non-local static object into its own function,
where it’s declared static. These functions return references to the objects they contain.
Clients then call the functions instead of referring to the objects. In other words,
non-local static objects are replaced with local static objects.

The approach is based on C++’s guarantee that local static objects
are initialized when the object’s definition is first encountered during
a call to that function. eg:

```
class FileSystem { ... };   // as before
FileSystem& tfs()           // this replaces the tfs object; it could be
{                           // static in the FileSystem class
  static FileSystem fs;     // define and initialize a local static object
  return fs;                // return a reference to it
}

class Directory { ... };       // as before
Directory::Directory( params ) // as before, except references to tfs are
{                              // now to tfs()
  ...
  std::size_t disks = tfs().numDisks();
  ...
}

Directory& tempDir()    // this replaces the tempDir object; it
{                       // could be static in the Directory class
  static Directory td( params ); // define/initialize local static object
  return td;                     // return reference to it
}

```

Avoid initialization order problems across translation units by replacing non-local
static objects with local static objects.

___Item 5:___ Know what functions C++ silently writes and calls. 

>* Compiler will declare copy construcor, copy asignment operator, destructor and default constructor.
They are public inline.

```
class Empty{};

```

actually, it is:

```
class Empty
{
  public:
    Empty(){};//default constructor
    ~Empty(){};//destructor
    Empty(const Empty &e){};//copy constructor
    Empty& operator=(const Empty &e){};//copy assignment operator
};

```

>* The compiler-generated constructor and copy assignment operator  
simply copy each non-static data member of the source object over to the target object. 
>* Explicitly disallow the use of compiler-generated functions you do not want. 


```
class HomeForSale 
{
  public:
      ...
  private:
      ...
      HomeForSale(const HomeForSale&); // declarations only 
      HomeForSale& operator=(const HomeForSale&);// declarations only 
};

```

With the above class definition, compilers will thwart client attempts
to copy HomeForSale objects, and if you inadvertently try to do it in a
member or a friend function, the linker will complain.

move the link-time error up to compile time:

```
class Uncopyable 
{
  protected:
    Uncopyable() {}
    ~Uncopyable() {}
  private:
    Uncopyable(const Uncopyable&);
    Uncopyable& operator=(const Uncopyable&);
};

class HomeForSale: private Uncopyable // class no longer
{  // declares copy ctor or
...// copy assign. operator
};


```
___Item 7:___ Chapter 2 Declare destructors virtual in polymorphic base classes


>* The purpose of virtual functions is to allow customization of derived class implementations 
>* Any class with virtual functions should almost certainly have a virtual destructor. 
If a class does not contain virtual functions, that often indicates it is not meant to
be used as a base class.When a class is not intended to be a base class, making the 
destructor virtual is usually a bad idea. 
>* Ensure delete thw whole object. eg:


```
class TimeKeeper {
public:
TimeKeeper();
virtual ~TimeKeeper();//it muset be virtual
...
};
TimeKeeper *ptk = getTimeKeeper();//factory function
...
delete ptk;
// now behaves correctly

```

>* If a class contations a virtual, objects of that type will increase in size. Because
each class with virtual functions has a virtual table which is an array of function pointers.
>* Pure virtual functions result in abstract classes---classes that can’t be instantiated 
(i.e., you can’t create objects of that type).
>* you must provide a definition for the pure virtual destructor for the way destructors work
is that the most derived class’s destructor is called first, then the destructor of each
base class is called. Compilers will generate a call to pure virual destrucor of the abstract
class from its derived classes’ destructors, so you have to be sure to provide a body for
the function. If you don’t, the linker will complain.
>* Polymorphic base classes should declare virtual destructors. If a class has any virtual 
functions, it should have a virtual destructor. Classes not designed to be base classes or not designed to be used
polymorphically should not declare virtual destructors. 


___Item 8:___ Prevent exceptions from leaving destructors. 

>* Process exception in destructor. Destructors should never emit exceptions. If functions
called in a destructor may throw, the destructor should catch any exceptions, then swallow
them or terminate the program. If class clients need to be able to react to exceptions thrown
during an operation, the class should provide a regular (i.e., non-destructor) function that
performs the operation. 

Case 1

```
DBConn::~DBConn()
{
  try
  {
    db.close();
  }
  catch(...)
  {
    std::abort();//Terminate the program if close throws
  }
}

```

Moving the responsibility for calling close from DBConn ’s destructor to
DBConn ’s client

```

class DBConn 
{
  public:
  ...
   void close()
  {
   db.close();
   closed = true;
  }

   ~DBConn()
  {
    if (!closed) 
    {
      try 
      {
        db.close();
      }
      catch (...) 
      {
        make log entry that call to close failed;
        ...
      }
    }
  }
}

```

___Item 9:___ Never call virtual functions during construction or destruction. 



position_c: Never call virtual functions during construction or destruction. 

#### confuse me

>* pass objects by reference-to-const explained as item 20, and it can be ensured by that
const member functions manipulate the resulting const-qualified objects.
>* local static object replace non-local static object by calling function(item 4)
>* Item6, what are the subtleties of Uncopyable

### Review:

There are too many details I did not care befor, and I will review them frequently from now on.

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2018/06/today/) 
