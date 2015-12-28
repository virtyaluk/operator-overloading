class Vector
    attr_accessor :x,:y

    def initialize (x = 0, y = 0)
        @x = x
        @y = y
    end

    # Overrides + (a + b).
    def +(other)
        return Vector.new(@x + other.x, @y + other.y)
    end

    # Overrides - (a - b).
    def -(other)
        return Vector.new(@x - other.x, @y - other.y)
    end
end

v1 = Vector.new(3, 4)
v2 = Vector.new(5, 7)

raise "Condition not true." unless (v1 + v2).x == 8 && (v1 + v2).y == 11
raise "Condition not true." unless (v2 - v1).x == 2 && (v2 - v1).y == 3