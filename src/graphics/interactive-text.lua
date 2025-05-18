local Entity = require 'src.core.entity'
local InteractiveText = Entity:extend()

function InteractiveText:new(text, x, y)
  InteractiveText.super.new(self)
  self.text = text or ''
  self.hovered = false
  self.x = x or 0
  self.y = y or 0
end

function InteractiveText:draw()
  LG.setFont(FONTS.PAPER)

  if self.hovered then
    LG.setColor(0, 0, 1)
  else
    LG.setColor(0, 0, 0)
  end

  LG.print(self.text, self.x, self.y)

  LG.setColor(1, 1, 1)

  LG.setFont(FONTS.NORMAL)
end

function InteractiveText:getHeight()
  LG.getFont():getHeight(self.text)
end

function InteractiveText:getWidth()
  LG.getFont():getWidth(self.text)
end

function InteractiveText:setCoordinates(x, y)
  self.x = x
  self.y = y
end

function InteractiveText:getText()
  return self.text
end

function InteractiveText:setText(text)
  self.text = text
end

function InteractiveText:hover()
  self.hovered = true
end

function InteractiveText:unhover()
  self.hovered = false
end

return InteractiveText