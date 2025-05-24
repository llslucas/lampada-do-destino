local Entity = require 'src.core.entity'
local MenuOption = Entity:extend()

function MenuOption:new(text, x, y)
  MenuOption.super.new(self)
  self.text = text or ''
  self.property = nil
  self.hovered = false
  self.x = x or 0
  self.y = y or 0
  self.min = 0
  self.max = 100
  self.alterDelay = 0.07
  self.elapsedTime = 0
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

function MenuOption:update(dt)
  if love.keyboard.isDown('right') or love.keyboard.isDown('left') then
    self.elapsedTime = self.elapsedTime + dt

    if self.elapsedTime >= self.alterDelay then
      if love.keyboard.isDown('right') then
        self:increments()
      elseif love.keyboard.isDown('left') then
        self:decrements()
      end
      self.elapsedTime = 0
    end
  end
end

function MenuOption:keypressed(key)
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
  if self.property then
    self.property = math.min(self.property + 1, self.max)
  end
  self:callback()
end

function MenuOption:decrements()
  if self.property then
    self.property = math.max(self.property - 1, self.min)
  end
  self:callback()
end

function MenuOption:setMinMax(min, max)
  self.min = min
  self.max = max
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
