### How does it work?

__Operator overloading__ is a programming language features that allows operators to act differently depending on the type of data they are operating on. Since OOP lets us create custom types (classes), there are plenty of opportunities to do useful and interesting code manipulations using operator overloading.

Current operator overloading in PHP is somewhat limited. Most of it is contained in class methods delimited by two underscores (__) which are called magical functions. Currently available are string casting and automatic serializing / unserializing (you can read more about those in the [manual](http://www.php.net/oop5.magic)). A native PHP5 extension called [SPL](http://www.php.net/~helly/php/ext/spl/) (Standard PHP Library) implements some array operator overloading to provide iterateable objects, which was a very welcome addition in PHP5.

[A recent article](http://webreflection.blogspot.com/2008/06/from-future-php-javascript-like-number.html) I read shows some very imaginative techniques to implement mathematical operator overloading using a PECL extension called [opreator](http://pecl.php.net/package/operator). The author's implementations are very interesting, and he's pushing for a native overloading implementation to make for a much easier use of such techniques.

All available operators and their associated magical functions listed in following table:

| __op__ | __mf__ |
|---|---|
| `+` | `__add($val)` |
| `-` | `__sub($val)` |
| `*` | `__mul($val)` |
| `/` | `__div($val)` |
| `%` | `__mod($val)` |
| `<<` | `__sl($val)` |
| `>>` | `__sr($val)` |
| `.` | `__concat($val)` |
| `|` | `__bw_or($val)` |
| `&` | `__bw_and($val)` |
| `^` | `__bw_xor($val)` |
| `=` | `__assign($val)` |
| `+=` | `__assign_add($val)` |
| `-=` | `__assign_sub($val)` |
| `*=` | `__assign_mul($val)` |
| `/=` | `__assign_div($val)` |
| `%=` | `__assign_mod($val)` |
| `<<=` | `__assign_sl($val)` |
| `>>=` | `__assign_sr($val)` |
| `.=` | `__assign_concat($val)` |
| `|=` | `__assign_bw_or($val)` |
| `&=` | `__assign_bw_and($val)` |
| `^=` | `__assign_bw_xor($val)` |
| `===` | `__is_identical($val)` |
| `!==` | `__is_not_identical($val)` |
| `==` | `__is_equal($val)` |
| `!=` | `__is_not_equal($val)` |
| `<` | `__is_smaller($val)` |
| `<=` | `__is_smaller_or_equal($val)` |
| `>` | `__is_greater($val)` |
| `>=` | `__is_greater_or_equal($val)` |
| `$++` | `__post_inc()` |
| `$--` | `__post_dec()` |
| `++$` | `__pre_inc()` |
| `--$` | `__pre_dec()` |
| `~$` | `__bw_not()` |
| `(bool)$` | `__bool()` |
| `!$` | `__bool_not()` |

### Example

```php
class Vector {
  public $x = 0;
  public $y = 0;

  public function __construct($x, $y) {
    $this->x = $x;
    $this->y = $y;
  }

  // Overrides + (a + b).
  function __add($rhs) {
    return new Vector($this->x + $rhs->x, $this->y + $rhs->y);
  }

  // Overrides - (a - b).
  function __sub($rhs) {
    return new Vector($this->x - $rhs->x, $this->y - $rhs->y);
  }
}

$v1 = new Vector(3, 5);
$v2 = new Vector(2, 7);

$v3 = $v1 + $v2;
$v4 = $v2 - $v1;

assert($v3->x == 5 && $v3->y == 12);
assert($v4->x = 1 && $v4->y == 2);
```

### Further reading

- [Operator Overloading in PHP](http://www.techfounder.net/2008/07/08/operator-overloading-in-php/)
- [php/pecl-php-operator](https://github.com/php/pecl-php-operator)