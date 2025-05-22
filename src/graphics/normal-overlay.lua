local Entity = require 'src.core.entity'
local NormalOverlay = Entity:extend()

function NormalOverlay:new(opacity)
  self.opacity = opacity or 0.7
end

function NormalOverlay:draw()
  love.graphics.setColor(0, 0, 0, self.opacity)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  love.graphics.setColor(1, 1, 1, 1)
end

return NormalOverlay