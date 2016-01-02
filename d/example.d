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