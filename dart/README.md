### How does it work?

You can override the operators shown in the following table. For example, if you define a `Vector` class, you might define a `+` method to add two vectors.

| __Overridable operators__ |
|---|
| `<`, `+`, `|`, `[]`, `>`, `/`, `^`, `[]=`, `<=`, `~/`, `&`, `~`, `>=`, `*`, `<<`, `==`, `-`, `%`, `>>` |

If you override `==`, you should also override `Object`’s `hashCode` getter. For an example of overriding `==` and `hashCode`, see [Implementing map keys](https://www.dartlang.org/docs/dart-up-and-running/ch03.html#implementing-map-keys).

### Example

Here’s an example of a class that overrides the `+` and `-` operators:

```dart
class Vector {
  final int x, y;

  const Vector(this.x, this.y);

  /// Overrides + (a + b).
  Vector operator +(Vector right) {
    return new Vector(x + right.x, y + right.y);
  }

  /// Overrides - (a - b).
  Vector operator -(Vector right) {
    return new Vector(x - right.x, y - right.y);
  }
}

// All Dart programs start with main().
void main() {
  final v1 = new Vector(3, 2);
  final v2 = new Vector(5, 4);

  assert((v1 + v2).x == 8 && (v1 + v2).y == 6);
  assert((v2 - v1).x == 2 && (v2 - v1).y == 2);
}
```

### Further reading
- [Overridable operators](https://www.dartlang.org/docs/dart-up-and-running/ch02.html#overridable-operators)
- [Extending a class](https://www.dartlang.org/docs/dart-up-and-running/ch02.html#extending-a-class)