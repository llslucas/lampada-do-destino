local Image = require 'src.core.image'
local Character = Image:extend()

local createQuads = require 'src.utils.create-quads'

function Character:new(sprite, scale)
  Character.super.new(self, sprite, scale)
  self.quads = createQuads(sprite, 4, 4)
  self.direction = 1
  self.currentFrame = 1
  self.destinationX = self.x
  self.destinationY = self.y
  self.speed = WALK_SPEED
  self.interval = WALK_ANIMATION_INTERVAL
  self.timer = 0
  self.moving = false
end

function Character:draw()
  LG.draw(
    self.img,
    self.quads[self.direction][self.currentFrame],
    self.x,
    self.y,
    self.angle,
    self.scale,
    self.scale
  )
end

function Character:update(dt)
  local offset = self.speed * dt
  self.moving = false

  if self.destinationX > self.x then
    self:turnRight()
    self.x = math.min(self.x + offset, self.destinationX)
    self.moving = true
  elseif self.destinationX < self.x then
    self:turnLeft()
    self.x = math.max(self.x - offset, self.destinationX)
    self.moving = true
  end

  if self.destinationY > self.y then
    self:turnDown()
    self.y = math.min(self.y + offset, self.destinationY)
    self.moving = true
  elseif self.destinationY < self.y then
    self:turnUp()
    self.y = math.max(self.y - offset, self.destinationY)
    self.moving = true
  end

  if self.moving then
    self.timer = self.timer + dt
    if self.timer >= self.interval then
      self.currentFrame = (self.currentFrame % #self.quads[1]) + 1
      self.timer = 0
    end
  else
    self.currentFrame = 1
  end
end

function Character:setCoordinates(x,y)
  Character.super.setCoordinates(self, x, y)
  self.destinationX = x
  self.destinationY = y
end

function Character:turnDown()
  self.direction = 1
end

function Character:turnUp()
  self.direction = 2
end

function Character:turnLeft()
  self.direction = 3
end

function Character:turnRight()
  self.direction = 4
end

function Character:walkUp()
  if self.destinationX == self.x and self.destinationY == self.y then
    self.destinationY = self.y - WALK_DISTANCE
    self.moving = true
  end
end

function Character:walkDown()
  if self.destinationX == self.x and self.destinationY == self.y then
    self.destinationY = self.y + WALK_DISTANCE
    self.moving = true
  end
end

function Character:walkLeft()
  if self.destinationX == self.x and self.destinationY == self.y then
    self.destinationX = self.x - WALK_DISTANCE
    self.moving = true
  end
end

function Character:walkRight()
  if self.destinationX == self.x and self.destinationY == self.y then
    self.destinationX = self.x + WALK_DISTANCE
    self.moving = true
  end
end

return Character