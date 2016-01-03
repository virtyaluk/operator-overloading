### How does it work?

Changing the way user defined types work with built-in operators.

##### Overview

Simply, operators are procedures, and their arguments are called _operands_. Operators that take one operand ([Operator Not](http://bourabai.kz/einf/freebasic/KeyPgOpNot.html)) are called _unary operators_, operators that take two operands ([Operator +](http://bourabai.kz/einf/freebasic/KeyPgOpAdd.html)) are called _binary operators_ and operators taking three operands ([Operator Iif](http://bourabai.kz/einf/freebasic/KeyPgIif.html)) are called _ternary operators_.

Most operators are not called like procedures. Instead, their operator symbol is placed next to their operands. For unary operators, their sole operand is placed to the right of the symbol. For binary operators, their operands - referred to as the left and right-hand side operands - are placed to the left and right of the operator symbol. FreeBASIC has one ternary operator, [Operator Iif](http://bourabai.kz/einf/freebasic/KeyPgIif.html), and it is called like a procedure, with its operands comma-separated surrounded by parenthesis. For example, the following code calls [Operator Iif](http://bourabai.kz/einf/freebasic/KeyPgIif.html) to determine if a pointer is valid. If it is, [Operator * (Value Of)](http://bourabai.kz/einf/freebasic/KeyPgOpValueOf.html) is called to dereference the pointer, and if not, [Operator / (Divide)](http://bourabai.kz/einf/freebasic/KeyPgOpDivide.html) is called to find the value of twenty divided by four.

```vb
Dim i As Integer = 420
Dim p As Integer Ptr = @i

Dim result As Integer = IIf( p, *p, CInt( 20 / 4 ) )
```

Notice the call to [Operator Iif](http://bourabai.kz/einf/freebasic/KeyPgIif.html) is similar to a procedure call, while the calls to [Operator * (Value Of)](http://bourabai.kz/einf/freebasic/KeyPgOpValueOf.html) and [Operator / (Divide)](http://bourabai.kz/einf/freebasic/KeyPgOpDivide.html) are not. In the example, `p` is the operand to [Operator * (Value Of)](http://bourabai.kz/einf/freebasic/KeyPgOpValueOf.html), and `20` and `4` are the left and right-hand side operands of [Operator / (Divide)](http://bourabai.kz/einf/freebasic/KeyPgOpValueOf.html), respectively.

All operators in FreeBASIC are predefined to take operands of standard data types, like [Integer](http://bourabai.kz/einf/freebasic/KeyPgInteger.html) and [Single](http://bourabai.kz/einf/freebasic/KeyPgSingle.html), but they may also be overloaded for user-defined types; that is, they can be defined to accept operands that are objects as well. There are two types of operators that can be overloaded, _global operators_ and _member operators_.

##### Global Operators

Global operators are those that are declared in module-level scope (globally). These are the operators [- (Negate)](http://bourabai.kz/einf/freebasic/KeyPgOpNegate.html), [Not (Bitwise Not)](http://bourabai.kz/einf/freebasic/KeyPgOpNot.html), [-> (Pointer To Member Access)](http://bourabai.kz/einf/freebasic/KeyPgOpPtrMemberAccess.html), [* (Value Of)](http://bourabai.kz/einf/freebasic/KeyPgOpValueOf.html), [+ (Add)](http://bourabai.kz/einf/freebasic/KeyPgOpAdd.html), [- (Subtract)](http://bourabai.kz/einf/freebasic/KeyPgOpSubtract.html), [* (Multiply)](http://bourabai.kz/einf/freebasic/KeyPgOpMultiply.html), [/ (Divide)](http://bourabai.kz/einf/freebasic/KeyPgOpDivide.html), [\ (Integer Divide)](http://bourabai.kz/einf/freebasic/KeyPgOpIntegerDivide.html), [& (Concatenate)](http://bourabai.kz/einf/freebasic/KeyPgOpConcatConvert.html), [Mod (Modulus)](http://bourabai.kz/einf/freebasic/KeyPgOpModulus.html), [Shl (Shift Left)](http://bourabai.kz/einf/freebasic/KeyPgOpShiftLeft.html), [Shr (Shift Right)](http://bourabai.kz/einf/freebasic/KeyPgOpShiftRight.html), [And (Bitwise And)](http://bourabai.kz/einf/freebasic/KeyPgOpAnd.html), [Or (Bitwise Or)](http://bourabai.kz/einf/freebasic/KeyPgOpOr.html), [Xor (Bitwise Xor)](http://bourabai.kz/einf/freebasic/KeyPgOpXor.html), [Imp (Bitwise Imp)](http://bourabai.kz/einf/freebasic/KeyPgOpImp.html), [Eqv (Bitwise Eqv)](http://bourabai.kz/einf/freebasic/KeyPgOpEqv.html), [^ (Exponentiate)](http://bourabai.kz/einf/freebasic/KeyPgOpExponentiate.html), [= (Equal)](http://bourabai.kz/einf/freebasic/KeyPgOpEqual.html), [<> (Not Equal)](http://bourabai.kz/einf/freebasic/KeyPgOpNotEqual.html), [< (Less Than)](http://bourabai.kz/einf/freebasic/KeyPgOpLessThan.html), [> (Greater Than)](http://bourabai.kz/einf/freebasic/KeyPgOpGreaterThan.html), [<= (Less Than Or Equal)](http://bourabai.kz/einf/freebasic/KeyPgOpLessThanOrEqual.html) and [>= (Greater Than Or Equal)](http://bourabai.kz/einf/freebasic/KeyPgOpGreaterThanOrEqual.html).

Declaring a custom global operator is similar to declaring a procedure. The [Declare](http://bourabai.kz/einf/freebasic/KeyPgDeclare.html) keyword is used with the [Operator](http://bourabai.kz/einf/freebasic/KeyPgOperator.html) keyword. The operator symbol is placed next followed by the comma-separated list of parameters surrounded in parenthesis that will represent the operands passed to the operator. Unlike procedures, operators can be overloaded by default, so the [Overload](http://bourabai.kz/einf/freebasic/KeyPgOverload.html) keyword is not necessary when declaring custom operators. At least one of the operator's parameters must be of user-defined type (after all, operators with built-in type parameters are already defined).

The following example declares the global operators [- (Negate)](http://bourabai.kz/einf/freebasic/KeyPgOpNegate.html) and [+ (Multiply)](http://bourabai.kz/einf/freebasic/KeyPgOpMultiply.html) to accept operands of a user-defined type.

```vb
Type Rational
    As Integer numerator, denominator
End Type

Operator - (ByRef rhs As Rational) As Rational
    Return Type(-rhs.numerator, rhs.denominator)
End Operator

Operator * (ByRef lhs As Rational, ByRef rhs As Rational) As Rational
    Return Type(lhs.numerator * rhs.numerator, _
        lhs.denominator * rhs.denominator)
End Operator

Dim As Rational r1 = (2, 3), r2 = (3, 4)
Dim As Rational r3 = -(r1 * r2)
Print r3.numerator & "/" & r3.denominator
```

Here the global operators are defined for type `Rational`, and are used in the initialization expression for `r3`. The output is `-6/12`.

##### Member Operators

Member operators are declared inside a [Type](http://bourabai.kz/einf/freebasic/KeyPgType.html) or [Class](http://bourabai.kz/einf/freebasic/KeyPgClass.html) definition, like member procedures, and they are the cast and assignment operators [Let (Assign)](http://bourabai.kz/einf/freebasic/KeyPgOpAssignment.html), [Cast (Cast)](http://bourabai.kz/einf/freebasic/KeyPgCast.html), [+= (Add And Assign)](http://bourabai.kz/einf/freebasic/KeyPgOpCombineAdd.html), [-= (Subtract And Assign)](http://bourabai.kz/einf/freebasic/KeyPgOpCombineSub.html), [*= (Multiply And Assign)](http://bourabai.kz/einf/freebasic/KeyPgOpCombineMultiply.html), [/= (Divide And Assign)](http://bourabai.kz/einf/freebasic/KeyPgOpCombineDivide.html), [\= (Integer Divide And Assign)](http://bourabai.kz/einf/freebasic/KeyPgOpCombineIntegerDivide.html), [^= (Exponentiate And Assign)](http://bourabai.kz/einf/freebasic/KeyPgOpCombineExponentiate.html), [&= (Concat And Assign)](http://bourabai.kz/einf/freebasic/KeyPgOpCombineConcat.html), [Mod= (Modulus And Assign)](http://bourabai.kz/einf/freebasic/KeyPgOpCombineModulus.html), [Shl= (Shift Left And Assign)](http://bourabai.kz/einf/freebasic/KeyPgOpCombineShiftLeft.html), [Shr= (Shift Right And Assign)](http://bourabai.kz/einf/freebasic/KeyPgOpCombineShiftRight.html), [And= (Conjunction And Assign)](http://bourabai.kz/einf/freebasic/KeyPgOpCombineAnd.html), [Or= (Inclusive Disjunction And Assign)](http://bourabai.kz/einf/freebasic/KeyPgOpCombineOr.html), [Xor= (Exclusive Disjunction And Assign)](http://bourabai.kz/einf/freebasic/KeyPgOpCombineXor.html), [Imp= (Implication And Assign)](http://bourabai.kz/einf/freebasic/KeyPgOpCombineImp.html) and [Eqv= (Equivalence And Assign)](http://bourabai.kz/einf/freebasic/KeyPgOpCombineEqv.html).

When declaring member operators, the [Declare](http://bourabai.kz/einf/freebasic/KeyPgDeclare.html) and [Operator](http://bourabai.kz/einf/freebasic/KeyPgOperator.html) keywords are used followed by the operator symbol and its parameter list. Like member procedures, member operators are defined outside the [Type](http://bourabai.kz/einf/freebasic/KeyPgType.html) or [Class](http://bourabai.kz/einf/freebasic/KeyPgClass.html) definition, and the symbol name is prefixed with the name of the [Type](http://bourabai.kz/einf/freebasic/KeyPgType.html) or [Class](http://bourabai.kz/einf/freebasic/KeyPgClass.html) name.

The following example overloads the member operators [Cast (Cast)](http://bourabai.kz/einf/freebasic/KeyPgCast.html) and [*= (Multiply And Assign)](http://bourabai.kz/einf/freebasic/KeyPgOpCombineMultiply.html) for objects of a user-defined type.

```vb
Type Rational
    As Integer numerator, denominator
    
    Declare Operator Cast () As Double
    Declare Operator Cast () As String
    Declare Operator *= (ByRef rhs As Rational)
End Type

Operator Rational.cast () As Double
    Return numerator / denominator
End Operator

Operator Rational.cast () As String
    Return numerator & "/" & denominator
End Operator

Operator Rational.*= (ByRef rhs As Rational)
    numerator *= rhs.numerator
    denominator *= rhs.denominator
End Operator

Dim As Rational r1 = (2, 3), r2 = (3, 4)
r1 *= r2
Dim As Double d = r1
Print r1, d
```

Notice that the member operator [Cast (Cast)](http://bourabai.kz/einf/freebasic/KeyPgCast.html) is declared twice, once for the conversion to [Double](http://bourabai.kz/einf/freebasic/KeyPgDouble.html) and once for the conversion to [String](http://bourabai.kz/einf/freebasic/KeyPgString.html). This is the only operator (or procedure) that can be declared multiple times when only the return type differs. The compiler decides which cast overload to call based on how the object is used (in the initialization of the [Double](http://bourabai.kz/einf/freebasic/KeyPgDouble.html) `d`, `Rational.Cast as double` is called, and in the [Print](http://bourabai.kz/einf/freebasic/KeyPgPrint.html) statement, `Rational.Cast as string` is used instead).

### Example

```vb
Type Vector
  As Integer X, Y
End Type

' Overrides + (a + b).
Operator + (ByRef lhs As Vector, ByRef rhs As Vector) As Vector
  Return Type(lhs.X + rhs.X, lhs.Y + rhs.Y)
End Operator

' Overrides - (a - b).
Operator - (ByRef lhs As Vector, ByRef rhs As Vector) As Vector
  Return Type(lhs.X - rhs.X, lhs.Y - rhs.Y)
End Operator

Dim As Vector r1 = (2, 3), r2 = (3, 4)
Dim As Vector r3 = r1 + r2, r4 = r2 - r1

Assert(r3.X = 5 And r3.Y = 7)
Assert(r4.X = 1 And r4.Y = 1)
```

### Further reading

- [Operator Overloading](http://bourabai.kz/einf/freebasic/ProPgOperatorOverloading.html)