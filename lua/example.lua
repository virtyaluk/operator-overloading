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