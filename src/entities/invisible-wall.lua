local Entity = require 'src.core.entity'
local InvisibleWall = Entity:extend()

function InvisibleWall:new(x, y, width, height)
  InvisibleWall.super.new(self)
  self:setId('invisible-wall')
  self.x = x * BASE_SIZE
  self.y = y * BASE_SIZE
  self.width = width * BASE_SIZE
  self.height = height * BASE_SIZE
end

function InvisibleWall:draw()
  return
end

function InvisibleWall:drawDebugInfo()
  LG.setColor(1, 0, 0, 0.4)
  LG.rectangle('fill', self.x, self.y, self.width, self.height)
  LG.setColor(1, 1, 1)
end

function InvisibleWall:update()
  return
end

function InvisibleWall:getWidth()
  return self.width
end

function InvisibleWall:getHeight()
  return self.height
end

return InvisibleWall