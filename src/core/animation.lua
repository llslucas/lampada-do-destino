local Animation = Object:extend()

function Animation:new(interval)
  self.frames = {}
  self.currentFrame = 1
  self.timer = 0
  self.interval = interval or 0.2
end

function Animation:update(dt)
  self.timer = self.timer + dt
  if self.timer >= self.interval then
    self.currentFrame = (self.currentFrame % #self.frames) + 1
    self.timer = 0
  end
end

return Animation