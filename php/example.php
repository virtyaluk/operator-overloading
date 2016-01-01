<?

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

?>