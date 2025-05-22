local Entity = Object:extend()

function Entity:new(img, scale, angle)
  self.id = tostring(math.random(1, 1e10)) .. "-" .. tostring(math.random(1, 1e10))
  self.img = img or nil
  self.scale = scale or 1
  self.angle = angle or 0
  self.x = 0
  self.y = 0
end

function Entity:draw()
  if self.img then
    LG.draw(self.img, self.x, self.y, self.angle, self.scale, self.scale)
  end
end

function Entity:update()
  return
end

function Entity:keypressed(key)
  return
end

function Entity:keyreleased(key)
  return
end

function Entity:drawDebugInfo()
  LG.setColor(1, 0, 0, 0.4)
  -- LG.rectangle('fill', self.x, self.y, self:getWidth(), self:getHeight())
  LG.polygon("fill", self:getComplexHitbox())
  LG.setColor(1, 1, 1)
end

function Entity:setId(id)
  self.id = id
end

function Entity:getHeight()
  if self.img then
    return math.floor(self.img:getHeight() * self.scale)
  end
end

function Entity:getWidth()
  if self.img then
    return math.floor(self.img:getWidth() * self.scale)
  end
end

function Entity:setCoordinates(x, y)
  self.x = x * BASE_SIZE
  self.y = y * BASE_SIZE
end

function Entity:setAbsoluteCoordinates(x, y)
  self.x = x
  self.y = y
end

function Entity:getCenter()
  return self:getWidth() / 2, self:getHeight() / 2
end

function Entity:getCoordinates()
  return self.x, self.y
end

function Entity:getCenterCoordinates()
  return self.x + (self:getWidth() / 2), self.y + (self:getHeight() / 2)
end

function Entity:getHitbox()
  return
      self.x,
      self.y,
      self:getWidth(),
      self:getHeight()
end

function Entity:getComplexHitbox()
  local x, y = self.x, self.y
  local w, h = self:getWidth(), self:getHeight()
  local x1, y1 = x, y
  local x2, y2 = x + w, y
  local x3, y3 = x + w, y + h
  local x4, y4 = x, y + h
  
  return { x1, y1, x2, y2, x3, y3, x4, y4 }
end

function Entity:checkCollision(object)
  local x1, y1, w1, h1 = self:getHitbox()
  local x2, y2, w2, h2 = object:getHitbox()

  local collision =
      x1 <= x2 + w2 and
      x1 + w1 >= x2 and
      y1 <= y2 + h2 and
      y1 + h1 >= y2

  local side = nil
  if collision then
    if y1 + h1 <= y2 + h2 / 2 then
      side = "up"
    elseif y1 >= y2 + h2 / 2 then
      side = "down"
    elseif x1 + w1 <= x2 + w2 / 2 then
      side = "left"
    elseif x1 >= x2 + w2 / 2 then
      side = "right"
    end
  end

  return collision, side
end

function Entity:checkBorderCollision(screenWidth, screenHeight, side)
  local x, y, w, h = self:getHitbox()

  local collision = {
    left = x < 0,
    right = x + w > screenWidth,
    top = y < 0,
    bottom = y + h > screenHeight
  }

  if side then
    return collision[side]
  end

  return collision
end

function Entity:interact()
  return
end

function Entity:setInteractionCallBack(callback)
  self.interact = callback
end

function Entity:collisionCallback()
  return
end

function Entity:setCollisionCallback(callback)
  self.collisionCallback = callback
end

return Entity
