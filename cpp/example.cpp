#include <iostream>
#include <assert.h>

class Vector
{
  public:
    int x, y;

    Vector(int nx, int ny)
    {
      x = nx;
      y = ny;
    }

	// Overrides + (a + b).
    Vector operator +(const Vector& rhs)
    {
      Vector v (this->x + rhs.x, this->y + rhs.y);
      return v;
    }

	// Overrides - (a - b).
    Vector operator -(const Vector& rhs)
    {
      Vector v(this->x - rhs.x, this->y -rhs.y);
      return v;
    }
};

int main()
{
  Vector v1 (3, 5);
  Vector v2 (4, 7);

  assert((v1 + v2).x == 7 && (v1 + v2).y == 12);
  assert((v2 - v1).x == 1 && (v2 - v1).y == 2);

  return 0;
}