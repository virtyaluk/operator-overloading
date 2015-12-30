# cpanm Carp::Assert
use Carp::Assert;

{
  package vector;
  use overload
    '+' => "plus",
    '-' => "minus";

  sub new {
    my ($class, $x, $y) = @_;
    my %info;
    $info{x} = $x;
    $info{y} = $y;
    bless \%info, $class;
  }

  sub area {
    my ($self) = @_;
    $$self{x} * $$self{y}
  }

  # Overrides + (a + b).
  sub plus {
    my ($this, $that) = @_;
    new vector($$this{x} + $$that{x}, $$this{y} + $$that{y});
  }

  # Overrides - (a - b).
  sub minus {
    my ($this, $that) = @_;
    new vector($$this{x} - $$that{x}, $$this{y} - $$that{y});
  }
}

$v1 = new vector(3,6);
$v2 = new vector(5,8);

assert(($v1 + $v2)->{x} == 8 and ($v1 + $v2)->{y} == 14);
assert(($v2 - $v1)->{x} == 2 and ($v2 - $v1)->{y} == 2);