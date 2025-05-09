local Buttons = Object:extend()

local Button = require 'src.entity.graphics.button'

function Buttons:new(initialX, initialY)
  self.buttons = {}
  self.isHovered = false
  self.initialX = initialX or LG.getWidth()/2
  self.initialY = initialY or LG.getHeight()/2
end

function Buttons:add(text, callback, x, y)
  x = x or self.initialX
  y = y or self.initialY + #self.buttons * 70 + 30
  table.insert(self.buttons, Button(x, y, text, callback))
end

function Buttons:draw()
  self.isHovered = false

  for _, button in ipairs(self.buttons) do
    button:draw()
  end

  love.mouse.setCursor(love.mouse.getSystemCursor(self.isHovered and "hand" or "arrow"))
end

function Buttons:update(dt)
  for _, button in ipairs(self.buttons) do
    button:update(dt)
    if button:isHovered() then
      self.isHovered = true
    end
  end
end

return Buttons