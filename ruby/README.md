### How does it work?

If you have two objects `a` and `b`, what does `a + b` equal? What does it even mean to add two arbitrary [objects](http://ruby.about.com/od/mr/g/Object.htm) together? For Ruby's base types (numbers, strings, etc), sensible and useful behavior has been added. But for any types you define yourself, you'll get a simple __undefined method__ [exception](http://ruby.about.com/od/rubyfeatures/a/exceptions.htm) if you try to add them. It's very easy to define a behavior though.

Operators are just [methods](http://ruby.about.com/od/oo/ss/methods.htm) in Ruby. All of the arithmetic operators in Ruby just call methods on _the left_ hand operand.

So in the example above, `a + b`, what you're really doing there is `a.call(:+, b)`. You're calling the method called `+` and passing `b` as an argument. This is the same with all of the arithmetic operators.

Note that this is only true of the _arithmetic_ operators. Other things that could be considered operators (and are considered operators in other languages) cannot be defined this way. For example, the method call operator (the dot operator) cannot be defined in this way, but you have __method_missing__ for that. The call operator itself (the parentheses) operator cannot be defined in this way. And a few other things like the `..` [Range](http://ruby.about.com/od/rubysbasicfeatures/ss/Ranges.htm) operator cannot be defined as a method. Only the arithmetic operators `+`, `-`, `*`, `/`, `%` and `**`, shift operators `>`, bitwise operators `|`, `^` and `&`, comparison operators `==`, `===`, `>`, `=`, and index operators `[]` and `[]=` may be defined.

##### Defining Operators

Defining an operator is as easy as [defining a method](http://ruby.about.com/od/oo/ss/methods.htm) (because it is defining a method). Just remember that you'll be defining the operator for the _left-hand side_ of any expression.

If you have objects of different type, `a + b` will not necessarily do the same thing as `b + a`. To define an operator, simply define a method with the same name as the operator. In this case, symbols are allowed as method names. So, if you had a `Money` class that represented an amount of money, you could define the `+` and `-` methods to add or subtract sums of money.

```ruby
class Money
  attr_accessor :value

  def +(b)
    result = dup
    result.value += b.value
    return result
  end

  def -(b)
    result = dup
    result.value += b.value
    return result
  end
end
```

And that's it. You can now add two and subtract `Money` objects. And not only that, but because of duck typing you can also add and subtract any objects that respond to the `value` message. So if you were to buy a car, the car's `value` could be subtracted from your `balance`.

Note that you must [duplicate](http://ruby.about.com/od/advancedruby/a/deepcopy.htm) your object in order for this to really make sense. When you say `a + b`, you're really creating a third object to represent the result. No one expects `a + b` to modify either `a` or `b`. The line `result = dup` will duplicate the current object, in this case `a` from the left-hand side of the expression. The operator method should return the result.

##### What About Assignment?

Assignment is handled differently in Ruby. In some other languages, you can reassign the assignment operator to mean something different, but not in Ruby. And as for the arithmetic assignment operators, you they take their cues from the assignment operators.

There is no way or no need to assign the `+=` type operators. The expression `a += b` is the same as `a = a + b`. Ruby uses the existing addition operator as well as its own assignment mechanics to implement the various assignment operators.

##### Non-Arithmetic Idioms

All languages have [idioms](http://ruby.about.com/od/gl/g/Idiom.htm). In Ruby, one common idiom is to add to a collection using the "shift left" operator. In other words, "shift this object onto the collection." This is similar to `+=`, add an element to the collection and assign it to the collection. However, it's faster as this doesn't create a third object. This is used with Ruby Arrays and Strings. You'll often see things like `a = [1,2,3]; a`. __This type of usage is implemented in the same way with the same methods, but a third object should not be created, the method should return self.__

### Example

```ruby
class Vector
  attr_accessor :x, :y

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
```

### Further reading
- [Overloading Operators](http://ruby.about.com/od/oo/ss/Overloading-Operators.htm)
- [Ruby for Newbies: Operators and their Methods](http://code.tutsplus.com/tutorials/ruby-for-newbies-operators-and-their-methods--net-18163)
- [Struggling With Ruby: Operator Overloading](http://strugglingwithruby.blogspot.com/2010/04/operator-overloading.html)