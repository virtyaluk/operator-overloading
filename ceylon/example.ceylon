class Vector(Integer nx, Integer ny)
	satisfies Numeric<Vector> {
	shared Integer x = nx;
	shared Integer y = ny;
	
	// Overrides + (a + b).
	shared actual Vector plus(Vector other) {
		return Vector(x + other.x, y + other.y);
	}
	
	// Overrides - (a - b).
	shared actual Vector minus(Vector other) {
		return Vector(x - other.x, y - other.y);
	}
	
	// Overrides / (a / b).
	shared actual Vector divided(Vector other) {
        return Vector(0, 0);
	}
	
	// Overrides * (a * b).
	shared actual Vector times(Vector other) {
		return Vector(0, 0);
	}
    
	// Overrides negation -a.
    shared actual Vector negated {
        return Vector(-x, -y);
    }
}

value v1 = Vector(4, 6);
value v2 = Vector(3, 9);

assert((v1 + v2).x == 7, (v1 + v2).y == 15);
assert((v2 - v1).x == -1, (v2 - v1).y == 3);