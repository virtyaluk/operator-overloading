class Vector:
  def __init__(self, x = 0, y = 0):
    self.x = x
    self.y = y

  # Overrides + (a + b).
  def __add__(self, other):
    return Vector(self.x + other.x, self.y + other.y);

  # Overrides - (a - b).
  def __sub__(self, other):
    return Vector(self.x - other.x, self.y - other.y);

v1 = Vector(2, 3)
v2 = Vector(4, 6)

assert (v1 + v2).x == 6 and (v1 + v2).y == 9, "Condition not true."
assert (v2 - v1).x == 2 and (v2 - v1).y == 3, "Condition not true."