local Entity = require 'src.core.entity'
local Door = Entity:extend()

function Door:new(x, y, width, height)
  Door.super.new(self)
  self:setId('door')
  self.x = x * BASE_SIZE
  self.y = y * BASE_SIZE
  self.width = width * BASE_SIZE
  self.height = height * BASE_SIZE
end

function Door:draw()
  if DRAW_HITBOX then
    LG.setColor(0, 1, 0, 0.4)
    LG.rectangle('fill', self.x, self.y, self.width, self.height)
    LG.setColor(1, 1, 1)
  end
end

function Door:update()
  return
end

function Door:getWidth()
  return self.width
end

function Door:getHeight()
  return self.height
end

function Door:interact()
  print('Interação com a porta efetuada')
end

return Door