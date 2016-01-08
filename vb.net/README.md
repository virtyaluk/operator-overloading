### How does it work?

Is a new twist in .NET that is slightly controversial. When Sun designed Java, for example, they deliberately did not include operator overloading because they considered it a source of "unnecessary complication." (So ... Sun is making your decision about whether to use this tool for you instead of leaving that choice up to you. Isn't that what they accuse Microsoft of doing?)
The idea is that you can redefine fundamental operators like addition (`+`) or subtraction (`-`) and give them new meaning.

You can even make them work with your own objects. In this article, I show you how.

Most VB.NET operators can be overloaded. But most articles, including those at MSDN, use "addition" to illustrate the idea. Just to expand outside the boundaries, I've used the "less than" and "greater than" operators (`<` and `>`).

To go even further outside the boundaries, I also decided to use an example based on high energy particle physics. It actually gets the idea across in a number of great ways.

Here's why this example works. It's impossible to think about these particles in conventional terms with properties like "size" and "weight". Physicists have defined properties for high energy particles like "charm" and "topness" to avoid using terms that don't actually exist for those particles. So if you can't compare the size of two particles because "size" doesn't exist for them, how do you determine whether one particle is "greater than" another? The answer is to use combinations of the properties they do have. But if you're writing a program and you would like to simply code `>` but actually mean a relationship using "charm" and "topness", then you need to overload the `>` operator.

In other words, you need to be able to write code like:

```vb
If Particle1 > Particle2 Then ...
```

I'll let the physicists argue about what the correct relationship actually is, but if they ever come to a conclusion, this article shows how to program it.

An operator overload is declared with a new (in VB.NET 2005) statement that you might not have used before, the `Operator` statement.

Other than this new statement, it looks much like any other overload. Here's the official Microsoft definition:

```vb
[ <attrlist> ] Public [ Overloads ] Shared [ Shadows ]
[ Widening | Narrowing ]
Operator operatorsymbol ( operand1 [, operand2 ])
[ As [ <attrlist> ] type ]
   [ statements ]
   [ statements ]
   Return returnvalue
   [ statements ]
End Operator
```

One thing that you might notice in the "official" definition is that the keywords `Public`, `Shared` and `Return` don't have brackets around them. In the notation that Microsoft uses, that means they're required.

Using this definition, here's the basic structure for a new "greater than" and "less than" (`>` and `<`) operator for an new `Particle` object.

```vb
Public Shared Operator >(ByVal value1 As Particle, ByVal value2 As Particle)
  As Boolean

  ' implementing code

End Operator

Public Shared Operator <(ByVal value1 As Particle, ByVal value2 As Particle)
  As Boolean

  ' implementing code

End Operator
```

Except for the `Operator` keyword, this is a lot like a standard `Overloads` statement, including the idea that VB.NET can tell whether this new definition of `>` should be used by the argument signature. If the arguments are `Particle` objects, the new definition is used. Otherwise, the standard meaning of `>` is used.

There are a few more conditions that you have to watch for as well. For example, note that both `>` and `<` have been overloaded. There are a number of operators that must be overloaded in pairs like this including:

- `=` and `<>`
- `>` and `<`
- `>=` and `<=`
- `IsTrue` and `IsFalse`

Another thing that can be confusing is the requirement that either an argument or the return type (or both) must be the same type as the class that defines the operator overload. If you think about it, this makes sense. My new "greater than" operator has to work with a `Particle` in some way. If neither argument or the return type is a `Particle`, how is it going to define any relationship for a `Particle`?

Expanding my code to include the class definition:

```vb
Public Class Particle
  Public Strangeness As Integer
  Public Charm As Integer
  Public Topness As Integer

  Public Shared Operator >(ByVal value1 As Particle, ByVal value2 As Particle)
    As Boolean

    ' implementing code

  End Operator
   
  Public Shared Operator <(ByVal value1 As Particle, ByVal value2 As Particle)
    As Boolean

    ' implementing code

  End Operator
End Class
```

Note that I have also included the code for some `Public` properties of `Particles`. (A more disciplined program would use `Property` declarations, but this keeps the example shorter.) I can use these "non-real world" properties of high energy particles to define any relationship the physicists can think up. (In this particular case, I made them all integers for simplicity.)

So suppose the physicists come up with some complex relationship to determine whether one `Particle` is "greater than" another like this:

```vb
value1.Strangeness > value2.Strangeness
  And value1.Charm / value2.Charm < 0.5
  And value1.Topness * value2.Topness > 20
```

### Example

```vb
Imports System.Diagnostics.Debug

Public Structure Vector
  Public X As Integer

  Public Y As Integer

  Public Sub New(ByVal nx As Integer, ByVal ny As Integer)
    X = nx
    Y = ny
  End Sub

  ' Overrides + (a + b).
  Public Shared Operator +(ByVal left As Vector, ByVal right As Vector)
    Return New Vector(left.X + right.X, left.Y + right.Y)
  End Operator

  ' Overrides - (a - b).
  Public Shared Operator -(ByVal left As Vector, ByVal right As Vector)
    Return New Vector(left.X - right.X, left.Y - right.Y)
  End Operator
End Structure

Public Class Program
  Shared Sub Main()
    Dim v1 As New Vector(4, 6)
    Dim v2 As New Vector(7, 9)

    Assert((v1 + v2).X = 11 And (v1 + v2).Y = 15, "Condition not true.")
    Assert((v2 - v1).X = 3 And (v2 - v1).Y = 3, "Condition not true.")
  End Sub
End Class
```

### Further reading
- [Operator Overloading](http://visualbasic.about.com/od/usingvbnet/a/opovrld01.htm)
- [Operator Overloading in Visual Basic 2005](http://bit.ly/1OzJZ9I)