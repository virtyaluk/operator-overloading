### How does it work?

Almost all of the operators in Ceylon can be expressed in terms of methods defined on classes and/or interfaces in the language module. Those operators which do not have such a definition are called primitive operators. The primitive operators are:

- `.` (member),
- `=` (assignment),
- `===` (identity),
- `is`,
- `of`,
- `()` (positional invocation),
- `{}` (named argument invocation)

Many non-primitive operators are polymorphic, which means that it is possible to specify the behaviour of operators in a type-specific way by satisfying the interface(s) used in the operator's definition.

However, not every non-primitive operator is polymorphic. Some are defined only in terms of the primitive operators, for example.

Ceylon discourages the creation of intriguing executable ASCII art. Therefore, true operator overloading is not supported by the language. Instead, almost every operator (every one except the primitive `.`, `()`, `is`, `=`, `===`, and `of` operators) is considered a shortcut way of writing some more complex expression involving other operators and ordinary function calls.

For example, the `<` operator is defined in terms of the interface [Comparable](https://modules.ceylon-lang.org/repo/1/ceylon/language/1.2.0/module-doc/Comparable.type.html), which has a method named `compare()`. The operator expression

```ceylon
x < y
```

means, by definition,

```ceylon
x.compare(y) === smaller
```

The equality operator `==` is defined in terms of the class `Object`, which has a method named `equals()`. So

```ceylon
x == y
```

means, by definition,

```ceylon
x.equals(y)
```

Therefore, it's easy to customize operators like `<` and `==` with specific behavior for our own classes, just by implementing or refining methods like `compare()` and `equals()`. Thus, we say that operators are _polymorphic_ in Ceylon.

Apart from `Comparable` and `Object`, which provide the underlying definition of comparison and equality operators, the following interfaces are also important in the definition of Ceylon's polymorphic operators:

- [Summable](https://modules.ceylon-lang.org/repo/1/ceylon/language/1.2.0/module-doc/Summable.type.html) supports the infix `+` operator,
- [Invertible](https://modules.ceylon-lang.org/repo/1/ceylon/language/1.2.0/module-doc/Invertible.type.html) supports the prefix and infix `-` operators,
- [Ordinal](https://modules.ceylon-lang.org/repo/1/ceylon/language/1.2.0/module-doc/Ordinal.type.html) supports the unary `++` and `--` operators,
- [Numeric](https://modules.ceylon-lang.org/repo/1/ceylon/language/1.2.0/module-doc/Numeric.type.html) supports the infix `*` and `/` operators,
- [Exponentiable](https://modules.ceylon-lang.org/repo/1/ceylon/language/1.2.0/module-doc/Exponentiable.type.html) supports the power operator `^`,
- [Comparable](https://modules.ceylon-lang.org/repo/1/ceylon/language/1.2.0/module-doc/Comparable.type.html) supports the comparison operators `<`, `>`, `<=`, `>=`, and `<=>`,
- [Enumerable](https://modules.ceylon-lang.org/repo/1/ceylon/language/1.2.0/module-doc/Enumerable.type.html) supports the range operators `..` and `:`,
- [Correspondence](https://modules.ceylon-lang.org/repo/1/ceylon/language/1.2.0/module-doc/Correspondence.type.html) supports the index operator,
- [Ranged](https://modules.ceylon-lang.org/repo/1/ceylon/language/1.2.0/module-doc/Ranged.type.html) supports the subrange operators,
- [Boolean](https://modules.ceylon-lang.org/repo/1/ceylon/language/1.2.0/module-doc/Boolean.type.html) is the basis of the logical operators `&&`, `||`, `!`, and
- [Set](https://modules.ceylon-lang.org/repo/1/ceylon/language/1.2.0/module-doc/Set.type.html) is the basis of the set operators `|`, `&`, and, `~`.

### Example

A simple example might be writing a `Vector` class which implements `Numeric`. This would allow us to write expressions using the operators `+` (addition), `-` (subtraction), `*` (multiplication), `/` (division), and `-` (additive inverse). For example:

```ceylon
class Vector(Integer nx, Integer ny) satisfies Numeric<Vector> {
  shared Integer x = nx;
  shared Integer y = ny;

  // Overrides + (a + b).
  shared actual Vector plus(Vector other) {
    return Vector(x + other.x, y + other.y);
  }

  // Overrides - (a - b).
  shared actual Vector minus(Vector other) {
    return Vector(x - other.x, y - other.y);
  }

  // Overrides / (a / b).
  shared actual Vector divided(Vector other) {
    return Vector(0, 0);
  }

  // Overrides * (a * b).
  shared actual Vector times(Vector other) {
    return Vector(0, 0);
  }

  // Overrides negation -a.
  shared actual Vector negated {
    return Vector(-x, -y);
  }
}

value v1 = Vector(4, 6);
value v2 = Vector(3, 9);

assert((v1 + v2).x == 7, (v1 + v2).y == 15);
assert((v2 - v1).x == -1, (v2 - v1).y == 3);
```

### Further reading

- [Ceylon: The language module](http://ceylon-lang.org/documentation/1.2/tour/language-module/#operator_polymorphism)
- [Operator Polymorphism](http://ceylon-lang.org/documentation/1.2/reference/operator/operator-polymorphism/)
- [Interface Numeric](https://modules.ceylon-lang.org/repo/1/ceylon/language/1.2.0/module-doc/api/Numeric.type.html)