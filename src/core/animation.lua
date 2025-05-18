local Animation = Object:extend()
local createQuads = require 'src.utils.create-quads'

function Animation:new(img, columns, rows, interval)
  self.img = img
  self.frames = createQuads(img, columns, rows)
  self.currentFrame = 1
  self.currentAnimation = 1
  self.timer = 0
  self.interval = interval or 0.2
  self.x = 0
  self.y = 0
  self.angle = 0
  self.scale = IMAGE_SCALING
end

function Animation:draw()
  LG.draw(
    self.img,
    self.frames[self.currentAnimation][self.currentFrame],
    self.x,
    self.y,
    self.angle,
    self.scale,
    self.scale
  )
end

function Animation:update(dt)
  self.timer = self.timer + dt
  if self.timer >= self.interval then
    self.currentFrame = (self.currentFrame % #self.frames[self.currentAnimation]) + 1
    self.timer = 0
  end
end

function Animation:setCoordinates(x, y)
  self.x = x
  self.y = y
end

function Animation:setAngle(angle)
  self.angle = angle
end

function Animation:setScale(scale)
  self.scale = scale
end

return Animation