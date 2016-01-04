### How does it work?

Groovy allows you to overload the various operators so that they can be used with your own classes. Consider this simple class:

```groovy
class Vector {
  int x
  int y

  Vector(int x, int y) {
    this.x = x
    this.y = y
  }

  Vector plus(Vector right) {
    return new Vector(this.x + right.x, this.y + right.y)
  }
}
```

`Vector` implements a special method called `plus()`.

Just by implementing the `plus()` method, the `Vector` class can now be used with the `+` operator like so:

```groovy
def v1 = new Vector(3, 5)
def v2 = new Vector(6, 9)
assert (v1 + v2).x == 9
```
                         
The two `Vector` objects can be added together with the `+` operator.


All (non-comparator) Groovy operators have a corresponding method that you can implement in your own classes. The only requirements are that your method is public, has the correct name, and has the correct number of arguments. The argument types depend on what types you want to support on the right hand side of the operator. For example, you could support the statement

```groovy
assert (b1 + 11).x == 15
```

by implementing the `plus()` method with this signature:

```groovy
Vector plus(int capacity) {
    return new Vector(this.x + capacity, this.y + capacity)
}
```

Here is a complete list of the operators and their corresponding methods:

| __Operator__ | __Method__ | __Operator__ | __Method__ |
|---|---|---|---|
| `+` | `a.plus(b)` | `a[b]` | `a.getAt(b)` |
| `-` | `a.minus(b)` | `a[b] = c` | `a.putAt(b, c)` |
| `*` | `a.multiply(b)` | `a in b` | `b.isCase(a)` |
| `/` | `a.div(b)` | `<<` | `a.leftShift(b)` |
| `%` | `a.mod(b)` | `>>` | `a.rightShift(b)` |
| `**` | `a.power(b)` | `>>>` | `a.rightShiftUnsigned(b)` |
| `|` | `a.or(b)` | `++` | `a.next()` |
| `&` | `a.and(b)` | `--` | `a.previous()` |
| `^` | `a.xor(b)` | `+a` | `a.positive()` |
| `as` | `a.asType(b)` | `-a` | `a.negative()` |
| `a()` | `a.call()` | `~a` | `a.bitwiseNegative()` |

### Example

```groovy
class Vector {
  int x
  int y

  Vector(int x, int y) {
    this.x = x
    this.y = y
  }

  // Overrides + (a + b).
  Vector plus(Vector right) {
    return new Vector(this.x + right.x, this.y + right.y)
  }

  // Overrides - (a - b).
  Vector minus(Vector right) {
    return new Vector(this.x - right.x, this.y - right.y);
  }
}

def v1 = new Vector(3, 5)
def v2 = new Vector(6, 9)

assert (v1 + v2).x == 9 && (v1 + v2).y == 14
assert (v2 - v1).x == 3 && (v2 - v1).y == 4
```

### Further reading

- [The Groovy programming language - Operators](http://www.groovy-lang.org/operators.html)