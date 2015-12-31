use std::ops::{Add, Sub};

#[derive(Debug, Copy, Clone)]
struct Vector {
  x: i32,
  y: i32
}

// Overrides + (a + b).
impl Add for Vector {
  type Output = Vector;

  fn add(self, other: Vector) -> Vector {
    Vector { x: self.x + other.x, y: self.y + other.y }
  }
}

// Overrides - (a - b).
impl Sub for Vector {
  type Output = Vector;

  fn sub(self, other: Vector) -> Vector {
    Vector { x: self.x - other.x, y: self.y - other.y }
  }
}

fn main() {
  let v1 = Vector { x: 3, y: 5 };
  let v2 = Vector { x: 7, y: 4 };

  assert!((v1 + v2).x == 10 && (v1 + v2).y == 9, "Condition not true.");
  assert!((v2 - v1).x == 4 && (v2 - v1).y == -1, "Condition not true.");
}