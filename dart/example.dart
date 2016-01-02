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