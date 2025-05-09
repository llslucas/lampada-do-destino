local Button = Object:extend()

function Button:new(x, y, text, callback)
  self.text = text
  self.callback = callback

  self.width = 250
  self.height = 50
  self.hovered = false

  self.x = x - self.width / 2
  self.y = y - self.height / 2
end

function Button:draw()
  local oldFont = LG.getFont()
  LG.setFont(FONTS.Title)

  if self.hovered then
    love.graphics.setColor(135/255, 142/255, 94/255)
  else
    love.graphics.setColor(115/255, 122/255, 74/255)
  end

  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, self.height / 2, self.height / 2)

  love.graphics.setColor(1, 1, 1)
  love.graphics.setLineWidth(2)
  love.graphics.rectangle("line", self.x, self.y, self.width, self.height, self.height / 2, self.height / 2)

  love.graphics.setColor(1, 1, 1)
  love.graphics.printf(self.text, self.x, self.y + self.height / 2 - 5, self.width, "center")

  LG.setFont(oldFont)
end

function Button:update(dt)
  if self:isHovered() then
    self.hovered = true
    if love.mouse.isDown(1) then
      self.callback()
      love.mouse.setCursor(love.mouse.getSystemCursor("arrow"))
    end
  else
    self.hovered = false
  end
end

function Button:isHovered()
  local mx, my = love.mouse.getPosition()
  return mx >= self.x and mx <= self.x + self.width and my >= self.y and my <= self.y + self.height
end

function Button:setCoordinates(x, y)
  self.x = x
  self.y = y
end

return Button