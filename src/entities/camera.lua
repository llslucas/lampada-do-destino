local Entity = require 'src.core.entity'
local Camera = Entity:extend()

function Camera:new(defaultAngle, limitAngle)
  local img = LG.newImage('assets/img/objects/camera-full.png')
  Camera.super.new(self, img, IMAGE_SCALING)
  self.animationIncrement = 1
  self.animationInterval = 2
  self.animationTime = 0
  self.changeSideTime = 0
  self.limitAngle = limitAngle or 60
  self.defaultAngle = defaultAngle or 0
  self.upperLimit = self.defaultAngle + self.limitAngle
  self.lowerLimit = self.defaultAngle - self.limitAngle

  self.angle = self.defaultAngle
end

function Camera:draw()
  LG.draw(self.img, self.x, self.y, math.rad(self.angle), self.scale, self.scale, self:getWidth() / 2, 5)
end

function Camera:update(dt)
  self.animationTime = self.animationTime + dt

  if self.angle >= self.upperLimit or self.angle  <= self.lowerLimit then
    self.changeSideTime = self.changeSideTime + dt

    if self.changeSideTime >= 5 then
      self.animationIncrement = self.animationIncrement * -1
      self.changeSideTime = 0
    end
  end

  if self.animationTime >= self.animationInterval then
    if (self.angle + self.animationIncrement) <= self.upperLimit and (self.angle + self.animationIncrement) >= self.lowerLimit then
      self.angle = self.angle + self.animationIncrement
    end
  end
end

function Camera:drawDebugInfo()
  LG.setColor(1, 0, 0, 0.4)
  local points = self:getHitbox()
  LG.polygon('fill', points)
  LG.setColor(1, 1, 1)
end

function Camera:getHitbox()
  local ox = self:getWidth() / 2
  local oy = 5 -- same as in draw()

  local cosA = math.cos(math.rad(self.angle))
  local sinA = math.sin(math.rad(self.angle))
  local w = self:getWidth() * self.scale
  local h = self:getHeight() * self.scale

  -- Four corners relative to origin
  local corners = {
    { -ox, -oy },
    { -ox + w, -oy },
    { -ox + w, -oy + h },
    { -ox, -oy + h }
  }

  -- Rotate and translate corners
  local points = {}
  for i, c in ipairs(corners) do
    local rx = c[1] * cosA - c[2] * sinA + self.x
    local ry = c[1] * sinA + c[2] * cosA + self.y
    table.insert(points, rx)
    table.insert(points, ry)
  end

  return points -- returns {x1, y1, x2, y2, x3, y3, x4, y4}
end

function Camera:checkCollision(object)
  local points = self:getHitbox()
  local px, py = object:getCenterCoordinates()

  local inside = false
  local j = #points - 1
  for i = 1, #points, 2 do
    local xi, yi = points[i], points[i+1]
    local xj, yj = points[j], points[j+1]
    if ((yi > py) ~= (yj > py)) and
        (px < (xj - xi) * (py - yi) / (yj - yi + 1e-12) + xi) then
      inside = not inside
    end
    j = i
  end
  return inside
end

return Camera
