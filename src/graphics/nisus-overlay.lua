local Entity = require 'src.core.entity'
local NisusOverlay = Entity:extend()

function NisusOverlay:new()
  local img = LG.newImage('assets/img/graphics/nisus-overlay.png')
  NisusOverlay.super.new(self, img)
end

function NisusOverlay:draw()
  love.graphics.setColor(0, 0, 0, 0.7)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  love.graphics.setColor(1, 1, 1, 1)
  local x = love.graphics.getWidth() / 2
  local y = love.graphics.getHeight() / 2
  love.graphics.draw(self.img, x, y, 0, self.scale, self.scale, self.img:getWidth() / 2, self.img:getHeight() / 2)
end

return NisusOverlay