### How does it work?

The usual operators can be overloaded using [metamethods](http://lua-users.org/wiki/MetamethodsTutorial). If an object (either a Lua table or C userdata) has a metatable then we can control the meaning of the arithmetic operators (like `+`, `-`, `*`, `/`, `^`), concatenation `..`, calling `()` and comparison operators `==`, `~=`, `<`, `>`.

Overriding `()` allows for 'function objects' or _functors_, which can be used wherever Lua expects something that is callable.

Note a restriction on overloading operators like `==:` both arguments must be of the same type. You cannot create your own `SuperNumber` class and get `sn == 0` to work, unfortunately. You would have to create an instance of `SuperNumber` called `Zero` and use that in your comparisons.

You can control the meaning of `a[i]` but this is not strictly speaking _overloading the [] operator_. `__index` fires when Lua cannot find a key inside a table. __index can be set to either a table or to a function; objects are often implemented by setting `__index` to be the metatable itself, and by putting the methods in the metatable. Since `a.fun` is equivalent to `a['fun']`, there is no way to distinguish between looking up using explicit indexing and using a dot. A naive `Set` class would put some methods in the metatable and store the elements of the set as keys in the object itself. But if `Set` a method 'set', then `s['set']` would always be true, even though 'set' would not be a member of the set.

The size operator and action when garbage-collected can be overridden by C extensions, not by plain Lua 5.1. This is restriction has been removed for Lua 5.2.

#### Metamethods

Lua has a powerful extension mechanism which allows you to overload certain operations on Lua objects. Each overloaded object has a metatable of function metamethods associated with it; these are called when appropriate, similar to the concept of operator overloading from many other languages.

A metatable is a regular Lua table containing a set of metamethods, which are associated with events in Lua. Events occur when Lua executes certain operations, like addition, string concatenation, comparisons etc. Metamethods are regular Lua functions which are called when a specific event occurs. The events have names like "add" and "concat" which correspond with string keys in the metatable like "__add" and "__concat". In this case to add (`+`) or concatenate (`..`) two Lua objects.

#### Metatables

We use the function setmetatable() to make a table act as a metatable for a certain object.

```lua
local x = {value = 5} -- creating local table x containing one key,value of value,5

local mt = {
  __add = function (lhs, rhs) -- "add" event handler
    return { value = lhs.value + rhs.value }
  end
}

setmetatable(x, mt) -- use "mt" as the metatable for "x"

local y = x + x

print(y.value) --> 10  -- Note: print(y) will just give us the table code i.e table: <some tablecode>

local z = y + y -- error, y doesn't have our metatable. this can be fixed by setting the metatable of the new object inside the metamethod
```

When the addition operator finds that its operands aren't numbers, it tries checking if one of them has a metatable with an `__add` key. In this case it does, so it runs the function stored under that key in the metatable, equivalent to this:

```lua
local y = (getmetatable(x).__add(x, x)) -- x + x
```

Metatables are still triggered with math operators if one of the operands is a number. And the left operand is always the first parameter to the function, and the right operand is always the second. This means that the table that has the metamethod might not necessarily be the first parameter to the metamethod.

#### More events

The following are notes on other of the metamethod events that Lua handles. For a full list of metamethod events, see: [MetatableEvents](http://lua-users.org/wiki/MetatableEvents).

##### __index

This is a very commonly used and versatile metamethod, it lets you run a custom function or use a "fallback" table if a key in a table doesn't exist. If a function is used, its first parameter will be the table that the lookup failed on, and the second parameter will be the key. If a fallback table is used, remember that it can trigger an `__index` metamethod on it if it has one, so you can create long chains of fallback tables.

```lua
local func_example = setmetatable({}, {__index = function (t, k)  -- {} an empty table, and after the comma, a custom function failsafe
  return "key doesn't exist"
end})

local fallback_tbl = setmetatable({   -- some keys and values present, together with a fallback failsafe
  foo = "bar",
  [123] = 456,
}, {__index=func_example})

local fallback_example = setmetatable({}, {__index=fallback_tbl})  -- {} again an empty table, but this time with a fallback failsafe

print(func_example[1]) --> key doesn't exist
print(fallback_example.foo) --> bar
print(fallback_example[123]) --> 456
print(fallback_example[456]) --> key doesn't exist
```

##### __newindex

This metamethod is called when you try to assign to a key in a table, and that key doesn't exist (contains nil). If the key exists, the metamethod is not triggered.

```lua
local t = {}

local m = setmetatable({}, {__newindex = function (table, key, value)
  t[key] = value
end})

m[123] = 456
print(m[123]) --> nil
print(t[123]) --> 456
```

#### Comparison operators

`__eq` is called when the `==` operator is used on two tables, the reference equality check failed, and both tables have the same `__eq` metamethod (!).

`__lt` is called to check if one object is "less than" another. Unlike `__eq`, it's not an error if the two objects have different `__lt` metamethods, the one on the left will be used.

That's all you need for all of the comparison operators to work with your object. But there will be some cases where both `__lt` and `__eq` will need to be called by the same operator. To avoid this, you can optionally add the `__le` (less than or equal to) metamethod. Now only one of the metamethods will be called with any of the comparison operators.

For example, we can improve the example at the top of the page like this:

```lua
local mt
mt = {
  __add = function (lhs, rhs)
    return setmetatable({value = lhs.value + rhs.value}, mt)
  end,
  __eq = function (lhs, rhs)
    return lhs.value == rhs.value
  end,
  __lt = function (lhs, rhs)
    return lhs.value < rhs.value
  end,
  __le = function (lhs, rhs) -- not really necessary, just improves "<=" and ">" performance
    return lhs.value <= rhs.value
  end,
}
```

##### __metatable

`__metatable` is for protecting metatables. If you do not want a program to change the contents of a metatable, you set its `__metatable` field. With that, the program cannot access the metatable (and therefore cannot change it).

### Example

```lua
Vector = {}
Vector.__index = Vector
Vector.__class = 'Vector'

function Vector:new(x, y)
  obj = {x = x, y = y}
  setmetatable(obj, self)
  return obj
end

--[[
	Overrides + (a + b).
--]]
function Vector:__add(right)
  if type(right) == 'number' then
    return Vector:new(self.x + right, self.y + right)
  else
    return Vector:new(self.x + right.x, self.y + right.y)
  end
end

--[[
	Overrides - (a - b).
--]]
function Vector:__sub(right)
  if type(right) == 'number' then
    return Vector:new(self.x - right, self.y - right);
  else
    return Vector:new(self.x - right.x, self.y - right.y)
  end
end

v1 = Vector:new(2, 5)
v2 = Vector:new(3, 7)

assert((v1 + v2).x == 5 and (v1 + v2).y == 12, "Condition not true.")
assert((v2 - v1).x == 1 and (v2 - v1).y == 2, "Condition not true.")
```

### Further reading

- [Lua Unofficial FAQ (uFAQ)](http://www.luafaq.org/)
- [Metamethods Tutorial](http://lua-users.org/wiki/MetamethodsTutorial)