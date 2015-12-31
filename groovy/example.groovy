class Vector {
	int x
	int y
	
	Vector(int x, int y) {
		this.x = x
		this.y = y
	}
	
	// Overrides + (a + b).
	Vector plus(Vector right) {
		return new Vector(this.x + right.x, this.y + right.y)
	}
	
	// Overrides - (a - b).
	Vector minus(Vector right) {
		return new Vector(this.x - right.x, this.y - right.y);
	}
}

def v1 = new Vector(3, 5)
def v2 = new Vector(6, 9)

assert (v1 + v2).x == 9 && (v1 + v2).y == 14
assert (v2 - v1).x == 3 && (v2 - v1).y == 4