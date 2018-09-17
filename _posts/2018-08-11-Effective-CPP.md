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

>* These functions are generated only if they are needed, but it doesn't take much to need them, the following
code will cause each function to be genrated.

```
Empty e1;//default constructor and destructor

Empty e2(e1);//copy constructor

e2 = e1;//copy assignment operator
```
>* defalut constructor: Give compilers a place to put "behind the scenes" code such as invocation of constructors of base classes and non-static data members.
>* defalut destructor: Give compilers a place to put "behind the scenes" code such as invocation of destructor of base classes and non-static data members.
>* The compiler-generated constructor and copy assignment operator simply copy each non-static data member of the source object over to the target object. 
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

>* the generated destructor is non-virtual, unless it's for a class inheriting from a base class that itself declares a virtual destructor.
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


>* Don’t call virtual functions during construction or destruction, because
such calls will never go to a more derived class than that of the currently
executing constructor or destructor. 

___Item 10:___ Have assignment operators return a reference to *this . 

>* To realize the chain of assignments. this is only a convention.

___Item 11:___ Handle assignment to self in operator= . 

>* Self-asignment-safe, here is a not-safe case

```

class Bitmap{}

class Widget
{
  private:
    Bitmap *pb;
};

Widget& Widget::operator=(const Widget& rhs)
{
  delete pb;//error, you should add identif test: if(this == &rhs) return *this;
  pb = new Bitmap(*rhs.pb);
  return *this;
}


```

___Item 12:___ Copy all parts of an object. 

>* Copy functions for derived class

```

PriorityCustomer::PriorityCustomer(const PriorityCustomer& rhs)
: Customer(rhs), // invoke base class copy ctor
priority(rhs.priority)
{
  logCall("PriorityCustomer copy constructor");
}

PriorityCustomer& PriorityCustomer::operator=(const PriorityCustomer& rhs)
{
  logCall("PriorityCustomer copy assignment operator");
  Customer::operator=(rhs); // assign base class parts
  priority = rhs.priority;
  return *this;
}

```

>* eliminate code duplication in copy constructors and copy assignment operators: 
if you find that your copy constructor and copy assignment operator have similar
code bodies, eliminate the duplication by creating a third member function that
both call. Such a function is typically private and is often named init. 


Chapter 3: Resource management

___Item 13:___ Use objects to manage resources

>* Common resources: memory, file descriptors, mutex locks, fonts and brushes in graphical
user interfaces (GUIs), database connections, and network sockets. 
>* Regardless of the resource, it’s important that it be released when you’re finished with it. 
>* Ensure that resources are released when control leaves that block or function---auto_ptr  
>* auto_ptr: A pointer-like object (a smart pointer). Its destructor automatically calls delete 
on what it points to. 

```

std::auto_ptr<Invsetment> pInv(createInvestment());

```

keypoints:

>* Resources are acquired and immediately turned over to resource-managing objects. 
>* Resource-managing objects use their destructors to ensure that resources are released. 
>* auto_ptr and RCSP(reference-counting-smart-pointer) 
>* tr1::shared_ptr is usually the better choice than std::auto_ptr, because its behavior
when copied is intuitive. Copying an auto_ptr sets it to null. 
>* A class’s destructor (regardless of whether it is compiler-generated or user-defined)
automatically invokes the destructors of the class’s non-static data members.  


___Item 15:___ Provide access to raw resources in resource-managing classes.

>* get, ->, *
>* conversion functions

```
FontHandle get() const { return this->f; } // explicit conversion function

operator FontHandle() const { return this->f; }  // implicit conversion function

```

>* RAII classes exist to ensure that a particular action — resource release — takes place.  

___Item 16:___ Use the same form in corresponding uses of new and delete .


>* new: 1. allocate memory, 2. constructor 
>* delete: 1. destructor 2. deallocate memory


___Item 17:___ Store new ed objects in smart pointers in standalone statements.


>* tr1::shared_ptr ’s constructor taking a raw pointer is explicit , so there’s 
no implicit conversion from the raw pointer to the tr1::shared_ptr. 
>* Although we’re using object-managing resources everywhere here, this call may
leak resources. 

Chapter 4

___Item 18:___ Make interfaces easy to use correctly and hard to use incorrectly.


>* Cross-dll-problem: Use custom-deleters supported tr1::shared_ptr to solve the problem.
>* shared_ptr in Boost

___Item 19:___ Treat class design as type design.


>* 12 problems

___Item 20:___ Prefer pass-by-reference-to-const to pass-by-value.


>* If you peek under the hood of a C++ compiler, you’ll find that references
are typically implemented as pointers, so passing something by reference 
usually means really passing a pointer.
>* Built-in types, iterators and function objects of STL---pass-by-value(not by reference)


___Item 21:___ Don’t try to return a reference when you must return an object.

___Item 22:___ Declare data members private


>* From an encapsulation point of view, there are really only two access levels:
private (which offers encapsulation) and everything else (which doesn’t).
>* Protected members can be accessed by derived classes.

___Item 23:___ Prefer non-member non-friend functions to member functions.

>* encapsulation, packaging flexibility, and functional extensibility. 

___Item 24:___ Declare non-member functions when type conversions should apply
to all parameters.

>* non-explicit constructor allow implicit type conversion
>* To support mixed-mode arithmetic, make operator a non-memeber function. 
>* If you need type conversions on all parameters to a function (including
the one that would otherwise be pointed to by the this pointer), the function
must be a non-member. 

___Item 25:___ Consider support for a non-throwing swap .

>* swap function is a mainstay of exception-safe programming. 
>* Specialization for function, eg:

```
template<>
void swap<Widget>(Widget& lhs, Widget& rhs)
```

>* Partially specialize a function template: simply add an overload, eg:

```
namespace std
{
  template<typename T>
    void swap(Widget<T>& lhs, Widget<T>& rhs)//an overloading of std::swap
    {
      lhs.swap(rhs);
    }
}
```

>* if you want to have your class-specific version of swap called in as many
contexts as possible (and you do), you need to write both a non-member version
in the same namespace as your class and a specialization of std::swap. 

Chapter5 Implementations

___Item 26:___ Postpone variable definitions as long as possible.

>* you’re better off postponing encrypted ’s definition until you know you’ll need it.
>* replace default contructor and assignemnt with copy constructor
>* avoid constructing and destructing unneeded objects, and avoid unnecessary default constructions. 

___Item 27:___ Minimize casting

casting syntax:

```
//(C-style cast)
(T) expression // cast expression to be of type T

//(Function-style cast)
T( expression ) // cast expression to be of type T

//(C++-style cast)
const_cast<T>( expression )             //cast away the constness of objects 
dynamic_cast<T>( expression )           //safe downcasting
reinterpret_cast<T>( expression )       //low-level cast(eg int* to int)
static_cast<T>( expression )            //force implicit conversions, eg: non-const -> const  

```

>* a single object (e.g., an object of type Derived ) might have more than one address
(e.g., its address when pointed to by a Base* pointer and its address when pointed to by
a Derived* pointer). That can’t happen in C. It can’t happen in Java. It can’t happen in C#.
It does happen in C++. 

>* A case: What you might not expect is that it does not invoke that function on the current
object! Instead, the cast creates a new, temporary copy of the base class part of *this ,
then invokes onResize on the copy! 

```
class SpecialWindow: public Window 
{
  public:
    virtual void onResize() 
    {
      static_cast<Window>(*this).onResize();
      ...
    }

}
```
Rectification:

```
class SpecialWindow: public Window 
{
  public:
    virtual void onResize() 
    {
      Window::onResize()  //call Window::onResize on *this
      ...
    }

}

```
>* Prefer C++-style casts to old-style casts.

___Item 28:___ Avoid returning “handles” to object internals.


>* case

```

public:
...
Point& upperLeft() const { return pData->ulhc; }
Point& lowerRight() const { return pData->lrhc; }
...

```

you can modify the points by reference, modify it by

```

public:
...
const Point& upperLeft() const { return pData->ulhc; }
const Point& lowerRight() const { return pData->lrhc; }
...

```

>* Actually, It doesn’t matter whether the handle is a pointer, a reference, or an iterator.
It doesn’t matter whether it’s qualified with const. It doesn’t matter whether the member
function returning the handle is itself const. All that matters is that a handle is being
returned, because once that’s being done, you run the risk that the handle will outlive
the object it refers to. 

___Item 29:___ Strive for exception-safe code.

>* Use mutex for concurrency control 
>* Use Lock class, which is part of resource manage classes, as a way to ensure that mutexes are released.
>* Exception-safe functions
>* pimpl idiom
>* side effects
>* The strong guarantee can often be implemented via copy-and-swap, but the strong guarantee
is not practical for all functions.
>* A function can usually offer a guarantee no stronger than the weakest guarantee of the
functions it calls---pregnant theory

___Item 30:___ Understand the ins and outs of inlining.

>* The idea behind an inline function is to replace each call of that function with its
code body. In statistics to see that this is likely to increase the size of your object
code. 
>* Even with virtual memory, inline-induced code bloat can lead to additional paging,
a reduced instruction cache hit rate, and the performance penalties that accompany
these things. 
>* Member functions and friend functions in a class are implicitly declared inline.

___Item 31:___ Minimize compilation dependencies between files.

>* Use forward declaration to split interface and implementation to minimize compilation
dependencied
>* make your header files self-sufficient whenever it’s practical, and when it’s not,
depend on declarations in other files, not definitions. 

Chapter 6 Inheritance and Object-Oriented Design

>* public inheritance means “is-a,” 
>* a virtual function means “interface must be inherited” 
>* a non-virtual function means “both interface and implementation must be inherited.” 

___Item 32:___ Make sure public inheritance models “is-a.”

___Item 33:___ Avoid hiding inherited names.

>* scope: derived member function with the same name with base class will hide the member
function in the base class.
>* inheritance and name hiding
* To make hidden names visible again, employ using declarations or forwarding functions. 

___Item 34:___ Differentiate between inheritance of interface and inheritance of implementation.

>* Make a choice among these options: inherit only the interface, inherit interface and implementation with overriding,
  and inherit interface and implementation withut overriding.
>* You can not define an object of abstract class, which has pure virtual function.
>* Pure virtual function: 1. must be redeclared by any concrete class that inherits them
2. Pure vitual funcions typically have no definition in abstract classes.
> The purpose of declaring a pure virtual function is to have derived classes inherit a
function interface only.
>* virtual functions: The purpose of declaring a simple virtual function is to have derived
classes inherit a function interface as well as a default implementation. 
>* non-virtual functions: The purpose of declaring a non-virtual function is to have derived
classes inherit a function interface as well as a mandatory implementation.
>* non-virtual functions means invariant.
>* Under public inheritance, derived classes always inherit base class interfaces. 

___Item 35:___ tr1::function 完成strategy(page: 205).

>* A non-pure virtual function suggests that there is a default implementation

>* NVI(non-tirtual interface) is a particular manifestation of the Template Method(not the C++ templates). the non-virtual function is called the virtual function's wrapper. 
>* NVI can provide "do before stuff" and "do after stuff" in the code.

Strategy pattern(pass a function pointer to constructor here)

```
class GameCharacter 
{
	public:
	typedef int (*HealthCalcFunc)(const GameCharacter&);
	explicit GameCharacter(HealthCalcFunc hcf = defaultHealthCalc)
	: healthFunc(hcf )
	{}
	int healthValue() const
	{ return healthFunc(*this); }
	...
	private:
	HealthCalcFunc healthFunc;
};

```
The Strategy Pattern via tr1::function

```
class GameCharacter; // as before
int defaultHealthCalc(const GameCharacter& gc); // as before

class GameCharacter 
{
	public:
	// HealthCalcFunc is any callable entity that can be called with
	// anything compatible with a GameCharacter and that returns anything
	// compatible with an int; see below for details
	typedef std::tr1::function<int (const GameCharacter&)> HealthCalcFunc;// int (const GameCharacter&) is target signature of this tr1::function instanfiation
	explicit GameCharacter(HealthCalcFunc hcf = defaultHealthCalc)
	: healthFunc(hcf )
	{}
	int healthValue() const
	{ return healthFunc(*this); }
	...
	private:
	HealthCalcFunc healthFunc;
};

```

```
short calcHealth(const GameCharacter&); // health calculation
																				// function; note
																				// non-int return type
struct HealthCalculator 
{																							 // class for health
		int operator()(const GameCharacter&) const // calculation function object
		{ ... }									
};

class GameLevel 
{
	public:
	float health(const GameCharacter&) const; // health calculation
	...																			  // mem function; note
};																					// non-int return type

class EvilBadGuy: public GameCharacter 
{ // as before
...
};

class EyeCandyCharacter: public GameCharacter 
{																						// another character
... 																				// type; assume same
};  																				// constructor as

// EvilBadGuy
// character using a health calculation function
EvilBadGuy ebg1(calcHealth); 

// character using a health calculation function object
EyeCandyCharacter ecc1(HealthCalculator()); 

// character using a health calculation member function
GameLevel currentLevel;
EvilBadGuy ebg2( 
std::tr1::bind(&GameLevel::health, currentLevel, _1) 
);
```
>* NVI, Template Method, Strategy, tr1::function version Stategy, classic strategy pattern

___Item 36:___ Never redefine an inherited non-virtual function.

>* Virtual functions are dynamically bound.
>* recall the item 7, which depicts destructor of base class should be virtual. so, it is similar.

___Item 37:___ Never redefine a function's inherited default parameter value.

Recall:

>* Dynamic type indicates how it __will__ behave. Virtual functions are dynamically bound, meaning that the particular function called is determined by the dynamic
type of the object through which it’s invoked.

>* Never redefine an inherited default parameter value, because default parameter values are statically bound, while virtual functions the only functions you should
be redefining are dynamically bound.

___Item 38:___ Model “has-a” or “is-implemented-in-termsof” through composition.

>* Composition: means either "has-a" or "is-implemented-in-terms-of"


position_c: Item 38 en: 184, ch:216

#### TODO

>* Search inline video, and code about item 31

#### confuse me

>* pass objects by reference-to-const explained as item 20, and it can be ensured by that
const member functions manipulate the resulting const-qualified objects.
>* local static object replace non-local static object by calling function(item 4)
>* Item6, what are the subtleties of Uncopyable
>* item 21
>* why const Rational operator*(const Rational& rhs) const;(item 3, 20, 21)
>* the comparison between member function, friend function and non-member function
>* pimpl(pointer to implementation)
>* the trip of using st::swap(), page 132
>* c++ style cast, especially dynamic_casts
>* explicit
>* Use forward to split interface and implementation.
>* I did not review all details in item 31, next time focus on code and blogs.
>* forward declaration

### Review:

There are too many details I did not care befor, and I will review them frequently from now on.

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2018/06/today/) 
