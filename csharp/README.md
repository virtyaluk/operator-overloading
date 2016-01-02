### How does it work?

You can redefine or overload most of the built-in operators available in C#. Thus a programmer can use operators with user-defined types as well. Overloaded operators are functions with special names the keyword __operator__ followed by the symbol for the operator being defined. similar to any other function, an overloaded operator has a return type and a parameter list.

For example, go through the following function:

```csharp
public static Vector operator +(Vector left, Vector right)
  => new Vector(left.X + right.X, left.Y + right.Y);
```

The above function implements the addition operator (`+`) for a user-defined class `Vector`. It adds the attributes of two `Vector` objects and returns the resultant `Vector` object.

The following table describes the overload ability of the operators in C#:

| __Operators__ | __Overloadability__ |
|---|---|
| `+`, `-`, `!`, `~`, `++`, `--`, `true`, `false` | These unary operators can be overloaded. |
| `+`, `-`, `*`, `/`, `%`, `&`, `|`, `^`, `<<`, `>>` | These binary operators can be overloaded. |
| `==`, `!=`, `<`, `>`, `<=`, `>=` | The comparison operators can be overloaded (but see the note that follows this table). |
| `&&`, `||` | The conditional logical operators cannot be overloaded, but they are evaluated using & and |, which can be overloaded. |
| `[]` | The array indexing operator cannot be overloaded, but you can define indexers. |
| `(T)x` | The cast operator cannot be overloaded, but you can define new conversion operators (see explicit and implicit). |
| `+=`, `-=`, `*=`, `/=`, `%=`, `&=`, `|=`, `^=`, `<<=`, `>>=` | Assignment operators cannot be overloaded, but +=, for example, is evaluated using +, which can be overloaded. |
| `=`, `.`, `?:`, `??`, `->`, `=>`, `f(x)`, `as`, `checked`, `unchecked`, `default`, `delegate`, `is`, `new`, `sizeof`, `typeof` | These operators cannot be overloaded. |

_**NOTE:** The comparison operators, if overloaded, must be overloaded in pairs; that is, if `==` is overloaded, `!=` must also be overloaded. The reverse is also true, and similar for `<` and `>`, and for `<=` and `>=`._

### Example

The following program shows the complete implementation:

```csharp
using static System.Diagnostics.Debug;

namespace OperatorOverloading
{
  public struct Vector
  {
    public int X;
    public int Y;

    public Vector(int x = 0, int y = 0)
    {
      X = x;
      Y = y;
    }

    /// Overrides + (a + b).
    public static Vector operator +(Vector left, Vector right)
      => new Vector(left.X + right.X, left.Y + right.Y);

    /// Overrides - (a - b).
    public static Vector operator -(Vector left, Vector right)
      => new Vector(left.X - right.X, left.Y - right.Y);
  }

  public static class Program
  {
    public static void Main()
    {
      var v1 = new Vector(3, 4);
      var v2 = new Vector(6, 7);

      Assert((v1 + v2).X == 9 && (v1 + v2).Y == 11, "Condition not true.");
      Assert((v2 - v1).X == 3 && (v2 - v1).Y == 3, "Condition not true.");
    }
  }
}
```
### Further reading

- [Operator Overloading Tutorial](http://bit.ly/1JP7AST)
- [Overloadable Operators (C# Programming Guide)](https://msdn.microsoft.com/en-us/library/8edha89s.aspx)
- [Guidelines for Overloading Equals() and Operator == (C# Programming Guide)](http://bit.ly/1YUljE8)
- [C# - Operator Overloading](http://www.tutorialspoint.com/csharp/csharp_operator_overloading.htm)