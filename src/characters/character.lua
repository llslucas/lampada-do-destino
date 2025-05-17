local Entity = require 'src.core.entity'
local Character = Entity:extend()

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

  if self.destinationX ~= self.x then
    self:moveX(offset)
  end

  if self.destinationY ~= self.y then
    self:moveY(offset)
  end

  if self.moving then
    self.timer = self.timer + dt
    if self.timer >= self.interval then
      self.currentFrame = (self.currentFrame % #self.quads[1]) + 1
      self.timer = 0
    end
  else
    if self.currentFrame % 2 == 0 then
      self.currentFrame = (self.currentFrame % #self.quads[1]) + 1
    end
  end
end

function Character:setCoordinates(x,y)
  Character.super.setCoordinates(self, x, y)
  self.destinationX = self.x
  self.destinationY = self.y
end

function Character:setDestination(x,y)
  self.destinationX = x * BASE_SIZE
  self.destinationY = y * BASE_SIZE
end

function Character:getHeight()
  return Character.super.getHeight(self) / 4
end

function Character:getWidth()
  return Character.super.getWidth(self) / 4
end

function Character:turn(direction)
  local directions = {down = 1, up = 2, left = 3, right = 4}
  self.direction = directions[direction]
end

function Character:moveX(distance)
  if self:checkGlobalCollision(self.destinationX, self.y) then
    self.destinationX = self.x
  end

  if self.destinationX > self.x then
    self.x = math.min(self.x + distance, self.destinationX)
    self:turn('right')
  elseif self.destinationX < self.x then
    self.x = math.max(self.x - distance, self.destinationX)
    self:turn('left')
  end

  self.moving = true
end

function Character:moveY(distance)
  if self:checkGlobalCollision(self.x, self.destinationY) then
    self.destinationY = self.y
  end

  if self.destinationY > self.y then
    self:turn('down')
    self.y = math.min(self.y + distance, self.destinationY)
  elseif self.destinationY < self.y then
    self:turn('up')
    self.y = math.max(self.y - distance, self.destinationY)
  end

  self.moving = true
end

function Character:walkUp(chunks)
  chunks = chunks or 1
  if self.destinationX == self.x and self.destinationY == self.y then
    self:turn('up')
    self.moving = true
    self.destinationY = self.y - WALK_DISTANCE * chunks
  end
end

function Character:walkDown(chunks)
  chunks = chunks or 1
  if self.destinationX == self.x and self.destinationY == self.y then
    self:turn('down')
    self.moving = true
    self.destinationY = self.y + WALK_DISTANCE * chunks
  end
end

function Character:walkLeft(chunks)
  chunks = chunks or 1
  if self.destinationX == self.x and self.destinationY == self.y then
    self:turn('left')
    self.moving = true
    self.destinationX = self.x - WALK_DISTANCE * chunks
  end
end

function Character:walkRight(chunks)
  chunks = chunks or 1
  if self.destinationX == self.x and self.destinationY == self.y then
    self:turn('right')
    self.moving = true
    self.destinationX = self.x + WALK_DISTANCE * chunks
  end
end

function Character:checkFutureCollision(object, destinationX, destinationY)
  local futureHitbox = {
    x = destinationX,
    y = destinationY,
    w = self:getWidth(),
    h = self:getHeight()
  }

  local objectHitbox = {}
  objectHitbox.x, objectHitbox.y, objectHitbox.w, objectHitbox.h = object:getHitbox()

  local collision = futureHitbox.x < objectHitbox.x + objectHitbox.w and
                    futureHitbox.x + futureHitbox.w > objectHitbox.x and
                    futureHitbox.y < objectHitbox.y + objectHitbox.h and
                    futureHitbox.y + futureHitbox.h > objectHitbox.y

  return collision
end

function Character:checkFutureBorderCollision(destinationX, destinationY)
  local futureHitbox = {
    x = destinationX,
    y = destinationY,
    w = self:getWidth(),
    h = self:getHeight()
  }

  local screenWidth, screenHeight = LG.getWidth(), LG.getHeight()

  local collision = futureHitbox.x < WORLD.SCENE.map.marginLeft or
                    futureHitbox.y < WORLD.SCENE.map.marginUp or
                    futureHitbox.x + futureHitbox.w > screenWidth - WORLD.SCENE.map.marginRight or
                    futureHitbox.y + futureHitbox.h > screenHeight - WORLD.SCENE.map.marginBottom

  return collision
end

function Character:checkGlobalCollision(destinationX, destinationY)
  for _, entity in WORLD.SCENE.map.entities:getItens() do
    if self.id ~= entity.id then
      local collision = self:checkFutureCollision(entity, destinationX, destinationY)
      if collision then
        return collision
      end
    end
  end

  return self:checkFutureBorderCollision(destinationX, destinationY)
end

return Character