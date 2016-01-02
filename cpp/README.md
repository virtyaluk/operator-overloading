### How does it work?

C++ allows you to specify more than one definition for a __function__ name or an __operator__ in the same scope, which is called __function overloading__ and __operator overloading__ respectively.

An overloaded declaration is a declaration that had been declared with the same name as a previously declared declaration in the same scope, except that both declarations have different arguments and obviously different definition (implementation).

When you call an overloaded __function__ or __operator__, the compiler determines the most appropriate definition to use by comparing the argument types you used to call the function or operator with the parameter types specified in the definitions. The process of selecting the most appropriate overloaded function or operator is called __overload resolution__.

You can redefine or overload most of the built-in operators available in C++. Thus a programmer can use operators with user-defined types as well.

Overloaded operators are functions with special names the keyword operator followed by the symbol for the operator being defined. Like any other function, an overloaded operator has a return type and a parameter list.

```cpp
Vector operator+(const Vector&);
```

declares the addition operator that can be used to __add__ two Vector objects and returns final Vector object. Most overloaded operators may be defined as ordinary non-member functions or as class member functions. In case we define above function as non-member function of a class then we would have to pass two arguments for each operand as follows:

```cpp
Vector operator+(const Vector&, const Vector&);
```

Following is the list of operators which can be overloaded:

| `+` | `-` | `*` | `/` | `%` | `^` |
|---|---|---|---|---|---|
| `&` | `|` | `~` | `!` | `,` | `=` |
| `<` | `>` | `<=` | `>=` | `++` | `--` |
| `<<` | `>>` | `==` | `!=` | `&&` | `||` |
| `+=` | `-=` | `/=` | `%=` | `^=` | `&=` |
|  `|=` | `*=` | `<<=` | `>>=` | `[]` | `()` |
| `->` | `->*` | `new` | `new []` | `delete` | `delete []` |

Following is the list of operators, which can not be overloaded:

| `::` | `.*` | `.` | `?:` |
|---|---|---|---|

### Example

Following is the example to show the concept of operator over loading using a member function. Here an object is passed as an argument whose properties will be accessed using this object, the object which will call this operator can be accessed using __this__ operator as explained below:

```cpp
#include <iostream>
#include <assert.h>

class Vector
{
  public:
    int x, y;

    Vector(int nx, int ny)
    {
      x = nx;
      y = ny;
    }

	// Overrides + (a + b).
    Vector operator +(const Vector& rhs)
    {
      Vector v (this->x + rhs.x, this->y + rhs.y);
      return v;
    }

	// Overrides - (a - b).
    Vector operator -(const Vector& rhs)
    {
      Vector v(this->x - rhs.x, this->y -rhs.y);
      return v;
    }
};

int main()
{
  Vector v1 (3, 5);
  Vector v2 (4, 7);

  assert((v1 + v2).x == 7 && (v1 + v2).y == 12);
  assert((v2 - v1).x == 1 && (v2 - v1).y == 2);

  return 0;
}
```

### Further reading
- [C++ Overloading (Operator and Function)](http://www.tutorialspoint.com/cplusplus/cpp_overloading.htm)
- [operator overloading](http://en.cppreference.com/w/cpp/language/operators)
- [C++ Programming/Operators/Operator Overloading](http://bit.ly/1YVYuum)