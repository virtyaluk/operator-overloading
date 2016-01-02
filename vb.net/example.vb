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