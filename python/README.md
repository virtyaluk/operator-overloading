### How does it work?

Python is an interesting language. It’s meant to be very explicit and easy to work with. But what happens when how you want or need to work with Python isn’t just what the native types expose? Well, you can build classes and give those classes attributes or methods that let you use them, but then you end up having to call methods instead of being able to just add items together where it makes sense.

But what if you _could_ just add them together? What if your `Area` class instances could just be added together to make a larger area? Well, thankfully, you can. This practice is called Operator Overloading because you’re overloading, or overwriting, how operators work. By “operator”, I mean symbols like `+`, `-`, and `*`.

Remember back in [Object-Oriented Python](http://teamtreehouse.com/library/objectoriented-python) when we overloaded `__init__()` to change how our classes initialized themselves? And we overrode `__str__()` to change how our class instances became strings? Well, we’re going to do the same thing in this article with `__add__` and some friends. This controls how instances add themselves together and with others. OK, let’s get started.

##### Book Club

Many of us here at Treehouse like to read and I think it would be neat to have a way to measure the books we’ve read. Let’s ignore the fact that several services already exist to do this very thing. I want to do it locally and in Python. Obviously I should start with a `Book` class.

```python
class Book:
    title = ''
    pages = 0

    def __init__(self, title='', pages=0):
        self.title = title
        self.pages = pages

    def __str__(self):
        return self.title
```

Nothing here that we didn’t cover in _Object-Oriented Python_. We make an instance and set some attributes based on the passed-in values. We also gave our class a `__str__` method so it’ll give us the title when we turn it into a string.

What I want to be able to do, though, is something like:

```python
book1 = Book('Fluency', 381)
book2 = Book('The Martian', 385)
book3 = Book('Ready Player One', 386)
sum([book1, book2, book3])
```

And get back `1152` (also, I had no idea I read so many books with similar page numbers). Currently, that’s not going to work. Python is going to give me an error about `"TypeError: unsupported operand type(s) for +: 'int' and 'Book'"`. That’s because our `Book` class has no idea what to do with a plus sign. Let’s fix that.

##### Reverse Adding

So the `sum()` function in Python is pretty swell. It takes a list of numbers and adds them all together. So if you have a bunch of, say, baseball inning scores, you can add them together in one method without having to have a counter variable or anything like that.

But, `sum()` does something you probably don’t expect. It starts with `0` and then adds the first itme in the list to that. So if the first item doesn’t know how to add itself to `0`, Python fails. But before it fails, Python tries to do a revered add with the operators.

Basically, remember how `2 + 5` and `5 + 2` are the same thing due to the commutative property of addition? Python takes advantage of that and swaps the operators. So instead of `0 + Book`, it tries `Book + 0`. `0 + Book` won’t work because the int class has no idea how to add itself to books. Our `Book` class can’t do the reverse add yet but we can give it the ability to.

This method has the best name in the 1990s. We have to override `__radd__`, or “reverse add”.

```python
def __radd__(self, other):
    return self.pages + other
```

OK, let’s try it.

```shell
>>> from books import Book
>>> book1 = Book('Fluency', 381)
>>> book2 = Book('The Martian', 385)
>>> book3 = Book('Ready Player One', 386)
>>> sum([book1, book2, book3])
1152
```

Excellent!

But what if we want to add two `Book` instances together directly? If we do:

```shell
>>> book1 + book2
```

from our above example, we get another `TypeError` about `+` being unsupported for the `Book` type. Well, yeah, we told Python how to add them in reverse, but no matter how Python tries to put these together, one of them has to be in front, so `__radd__` isn’t being used.

##### Adding

Time for regular adding, then. As you might have guessed, we override the `__add__` method.

```python
def __add__(self, other):
    return self.pages + other
```

And now we can add books together:

```shell
>>> book1 + book2
766
```

Well, adding `Book` instances together seems to be pretty well sewn up. But what if we want to compare books to each other? Let’s override a few more methods so we can use `<`, `>`, and friends.

##### Comparative Literature

There’s a handful of methods we have to override to implement the comparison operators in our class. Let’s just do them all at once.

```python
def __lt__(self, other):
    return self.pages < other

def ___le__(self, other):
    return self.pages <= other

def __eq__(self, other):
    return self.pages == other

def __ne__(self, other):
    return self.pages != other

def __gt__(self, other):
    return self.pages > other

def __ge__(self, other):
    return self.pages >= other
```

This works fine for `<`, `>`, `==`, and `!=`, but blows up on `<=` and `>=` because we haven’t said what to compare against on `other` in those examples. We’ll update those two to automatically compare against `.pages` but we should also make them so they make sure it’s a valid comparison.

```python
def __le__(self, other):
    if isinstance(other, Book):
        return self.pages <= other.pages
    elif isinstance(other, (int, float)):
        return self.pages <= other
    else:
        return NotImplemented

def __ge__(self, other):
    if isinstance(other, Book):
        return self.pages >= other.pages
    elif isinstance(other, (int, float)):
        return self.pages >= other
    else:
        return NotImplemented
```

Yes, this is more work but it makes our code smarter. If we’re comparing two `Book` instances, we’ll use their `pages` attributes. If not, but we’re comparing against a number, we’ll compare that like normal. Then, finally, we’ll return a `NotImplemented` error for anything else. Let’s try it out.

```shell
>>> book1 <= book3
True
>>> book3 > book2
True
>>> book3 > 500
False
```

Great! Now we can add books together to get total page counts and we can compare books to each other.

##### That’s just the beginning

If we wanted to, there are several more methods that it would make sense to override on our classes. We might want to make our `Book` class give back the page count when it’s turned into an `int`. We’d do this with the `__int__` method. Or maybe we want to be able to increase or decrease page counts with `+=` and `-=`. We’d do that by overriding `__iadd__` and `__isub__`. To see the entire list of magic methods that can be overridden, check [the Python documentation](https://docs.python.org/3/reference/datamodel.html#special-method-names).

### Example

```python
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
```

### Further reading
- [Operator Overloading in Python](http://blog.teamtreehouse.com/operator-overloading-python)