### How does it work?

Operator overloading is accomplished by rewriting operators whose operands are class or struct objects into calls to specially named member functions. No additional syntax is used.

#### Unary Operator Overloading

Overloadable Unary Operators

| __op__ | __rewrite__ |
|---|---|
| `-e` | `e.opUnary!("-")()` |
| `+e` | `e.opUnary!("+")()` |
| `~e` | `e.opUnary!("~")()` |
| `*e` | `e.opUnary!("*")()` |
| `++e` | `e.opUnary!("++")()` |
| `--e` | `e.opUnary!("--")()` |

For example, in order to overload the - (negation) operator for struct S, and no other operator:

```d
struct S
{
    int m;

    int opUnary(string s)() if (s == "-")
    {
        return -m;
    }
}

int foo(S s)
{
    return -s;
}
```

##### Postincrement e++ and Postdecrement e-- Operators

These are not directly overloadable, but instead are rewritten in terms of the ++e and --e prefix operators:

| __op__ | __rewrite__ |
|---|---|
| `e--` | `(auto t = e, --e, t)` |
| `e++` | `(auto t = e, ++e, t)` |

##### Overloading Index Unary Operators

Overloadable Index Unary Operators

| __op__ | __rewrite__ |
|---|---|
| `-a[b1, b2, ... bn]` | `a.opIndexUnary!("-")(b1, b2, ... bn)`|
| `+a[b1, b2, ... bn]` | `a.opIndexUnary!("+")(b1, b2, ... bn)` |
| `~a[b1, b2, ... bn]` | `a.opIndexUnary!("~")(b1, b2, ... bn)` |
|` *a[b1, b2, ... bn]` | `a.opIndexUnary!("*")(b1, b2, ... bn)` |
| `++a[b1, b2, ... bn]` | `a.opIndexUnary!("++")(b1, b2, ... bn)` |
| `--a[b1, b2, ... bn]` | `a.opIndexUnary!("--")(b1, b2, ... bn)` |

##### Overloading Slice Unary Operators

| __op__ | __rewrite__ |
|---|---|
| `-a[i..j]` | `a.opIndexUnary!("-")(a.opSlice(i, j))` |
| `+a[i..j]` | `a.opIndexUnary!("+")(a.opSlice(i, j))` |
| `~a[i..j]` | `a.opIndexUnary!("~")(a.opSlice(i, j))` |
| `*a[i..j]` | `a.opIndexUnary!("*")(a.opSlice(i, j))` |
| `++a[i..j]` | `a.opIndexUnary!("++")(a.opSlice(i, j))` |
| `--a[i..j]` | `a.opIndexUnary!("--")(a.opSlice(i, j))` |
| `-a[ ]` | `a.opIndexUnary!("-")()` |
| `+a[ ]` | `a.opIndexUnary!("+")()` |
| `~a[ ]` | `a.opIndexUnary!("~")()` |
| `*a[ ]` | `a.opIndexUnary!("*")()` |
| `++a[ ]` | `a.opIndexUnary!("++")()` |
| `--a[ ]` | `a.opIndexUnary!("--")()` |

For backward compatibility, if the above rewrites fail and `opSliceUnary` is defined, then the rewrites `a.opSliceUnary!(op)(a, i, j)` and `a.opSliceUnary!(op)` are tried instead, respectively.

#### Cast Operator Overloading

Cast Operators

| __op__ | __rewrite__ |
|---|---|
|` cast(type ) e` | `e.opCast!(type)()` |

##### Boolean Operations

Notably absent from the list of overloaded unary operators is the ! logical negation operator. More obscurely absent is a unary operator to convert to a bool result. Instead, these are covered by a rewrite to:

```d
opCast!(bool)(e)
```

So,

```d
if (e)   =>  if (e.opCast!(bool))
if (!e)  =>  if (!e.opCast!(bool))
```

etc., whenever a bool result is expected. This only happens, however, for instances of structs. Class references are converted to bool by checking to see if the class reference is null or not.

#### Binary Operator Overloading

The following binary operators are overloadable:

| Overloadable Binary Operators |
|---|
| `+`, `-`, `*`, `/`, `%`, `^^`, `&`, `|`, `^`, `<<`, `>>`, `>>>`, `~`, `in`|

The expression:

```d
a op b
```

is rewritten as both:

```d
a.opBinary!(“op”)(b)
b.opBinaryRight!(“op”)(a)
```

and the one with the ‘better’ match is selected. It is an error for both to equally match.

Operator overloading for a number of operators can be done at the same time. For example, if only the `+` or `-` operators are supported:

```d
T opBinary(string op)(T rhs)
{
    static if (op == "+") return data + rhs.data;
    else static if (op == "-") return data - rhs.data;
    else static assert(0, "Operator "~op~" not implemented");
}
To do them all en masse:

T opBinary(string op)(T rhs)
{
    return mixin("data "~op~" rhs.data");
}
```

#### Overloading the Comparison Operators

D allows overloading of the comparison operators `==`, `!=`, `<`, `<=`, `>=`, > via two functions, `opEquals` and `opCmp`.

The equality and inequality operators are treated separately because while practically all user-defined types can be compared for equality, only a subset of types have a meaningful ordering. For example, while it makes sense to determine if two RGB color vectors are equal, it is not meaningful to say that one color is greater than another, because colors do not have an ordering. Thus, one would define `opEquals` for a `Color` type, but not `opCmp`.

Furthermore, even with orderable types, the order relation may not be linear. For example, one may define an ordering on sets via the subset relation, such that `x < y` is true if `x` is a (strict) subset of `y`. If `x` and `y` are disjoint sets, then neither `x < y` nor `y < x` holds, but that does not imply that `x == y`. Thus, it is insufficient to determine equality purely based on `opCmp` alone. For this reason, `opCmp` is only used for the inequality operators `<`, `<=`, `>=`, and `>`. The equality operators `==` and `!=` always employ `opEquals` instead.

Therefore, it is the programmer's responsibility to ensure that `opCmp` and `opEquals` are consistent with each other. If `opEquals` is not specified, the compiler provides a default version that does member-wise comparison. If this suffices, one may define only `opCmp` to customize the behaviour of the inequality operators. But if not, then a custom version of `opEquals` should be defined as well, in order to preserve consistent semantics between the two kinds of comparison operators.

Finally, if the user-defined type is to be used as a key in the built-in associative arrays, then the programmer must ensure that the semantics of `opEquals` and toHash are consistent. If not, the associative array may not work in the expected manner.

##### Overloading == and !=

Expressions of the form `a != b` are rewritten as `!(a == b)`.

Given `a == b`:
__1.__ If a and b are both class objects, then the expression is rewritten as:
```d
.object.opEquals(a, b)
```

and that function is implemented as:

```d
bool opEquals(Object a, Object b)
{
    if (a is b) return true;
    if (a is null || b is null) return false;
    if (typeid(a) == typeid(b)) return a.opEquals(b);
    return a.opEquals(b) && b.opEquals(a);
}
```

__2.__ Otherwise the expressions `a.opEquals(b)` and `b.opEquals(a)` are tried. If both resolve to the same `opEquals` function, then the expression is rewritten to be `a.opEquals(b)`.
__3.__ If one is a better match than the other, or one compiles and the other does not, the first is selected.
__4.__ Otherwise, an error results.

If overridding `Object.opEquals()` for classes, the class member function signature should look like:

```d
class C
{
    override bool opEquals(Object o) { ... }
}
```

If structs declare an `opEquals` member function for the identity comparison, it could have several forms, such as:

```d
struct S
{
    // lhs should be mutable object
    bool opEquals(const S s) { ... }        // for r-values (e.g. temporaries)
    bool opEquals(ref const S s) { ... }    // for l-values (e.g. variables)

    // both hand side can be const object
    bool opEquals(const S s) const { ... }  // for r-values (e.g. temporaries)
}
```

Alternatively, you can declare a single templated `opEquals` function with an auto ref parameter:

```d
struct S
{
    // for l-values and r-values,
    // with converting both hand side implicitly to const
    bool opEquals()(auto ref const S s) const { ... }
}
```

##### Overloading <, <=, >, and >=

Comparison operations are rewritten as follows:

| __comparision__ | __rewrite 1__ | __rewrite 2__ |
|---|---|---|
| `a < b` | `a.opCmp(b) < 0` | `b.opCmp(a) > 0` |
| `a <= b` | `a.opCmp(b) <= 0` | `b.opCmp(a) >= 0` |
| `a > b` | `a.opCmp(b) > 0` | `b.opCmp(a) < 0` |
| `a >= b` | `a.opCmp(b) >= 0` | `b.opCmp(a) <= 0` |

Both rewrites are tried. If only one compiles, that one is taken. If they both resolve to the same function, the first rewrite is done. If they resolve to different functions, the best matching one is used. If they both match the same, but are different functions, an ambiguity error results.

If overriding `Object.opCmp()` for classes, the class member function signature should look like:

```d
class C
{
    override int opCmp(Object o) { ... }
}
```

If structs declare an `opCmp` member function, it should have the following form:

```d
struct S
{
    int opCmp(ref const S s) const { ... }
}
```

Note that `opCmp` is only used for the inequality operators; expressions like `a == b` always uses `opEquals`. If `opCmp` is defined but `opEquals` isn't, the compiler will supply a default version of `opEquals` that performs member-wise comparison. If this member-wise comparison is not consistent with the user-defined `opCmp`, then it is up to the programmer to supply an appropriate version of `opEquals`. Otherwise, inequalities like `a <= b` will behave inconsistently with equalities like `a == b`.

### Example

```d
struct Vector
{
  int x, y;

  this(int nx, int ny)
  {
    x = nx;
    y = ny;
  }

  Vector opBinary(string op)(Vector right)
  {
    if (op == "+")
      return Vector(x + right.x, y + right.y); // Overrides + (a + b).
    else if (op == "-")
      return Vector(x - right.x, y - right.y); // Overrides - (a - b).
  }
}

void main()
{
  Vector v1 = Vector(3, 4);
  Vector v2 = Vector(6, 8);

  assert((v1 + v2).x == 9 && (v1 + v2).y == 12);
  assert((v2 - v1).x == 3 && (v2 - v1).y == 4);
}
```

### Further reading

- [Operator Overloading](https://dlang.org/spec/operatoroverloading.html)