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