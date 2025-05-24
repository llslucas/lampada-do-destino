local Entity = require 'src.core.entity'
local MenuOption = Entity:extend()

function MenuOption:new(text, x, y)
  MenuOption.super.new(self)
  self.text = text or ''
  self.property = nil
  self.hovered = false
  self.x = x or 0
  self.y = y or 0
end

function MenuOption:draw()
  LG.setFont(FONTS.MENUOPTION)

  if self.hovered then
    LG.setColor(1, 0.592, 0)
  else
    LG.setColor(1, 1, 1)
  end

  LG.print(self.text .. (self.property and (": " .. self.property) or ''), self.x, self.y)

  LG.setColor(1, 1, 1)

  LG.setFont(FONTS.NORMAL)
end

function MenuOption:keypressed(key)
  if key == 'right' then
    self:increments()
  elseif key == 'left' then
    self:decrements()
  end

  if key == 'space' then
    self:interactionCallback()
  end
end

function MenuOption:getHeight()
  LG.getFont():getHeight(self.text)
end

function MenuOption:getWidth()
  LG.getFont():getWidth(self.text)
end

function MenuOption:setCoordinates(x, y)
  self.x = x
  self.y = y
end

function MenuOption:getText()
  return self.text
end

function MenuOption:setText(text)
  self.text = text
end

function MenuOption:getProperty()
  return self.property
end

function MenuOption:setProperty(property)
  self.property = property
end

function MenuOption:hover()
  self.hovered = true
end

function MenuOption:unhover()
  self.hovered = false
end

function MenuOption:increments()
  self.property = self.property + 1
  self:callback()
end

function MenuOption:decrements()
  self.property = self.property - 1
  self:callback()
end

function MenuOption:callback()
  return
end

function MenuOption:setCallback(callback)
  self.callback = callback
end

function MenuOption:interactionCallback()
  return
end

function MenuOption:setInteractionCallback(callback)
  self.interactionCallback = callback
end

return MenuOption
