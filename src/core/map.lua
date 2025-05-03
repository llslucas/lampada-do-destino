local Screen = Object:extend()

local Buttons = require 'src.aggregate.buttons'

function Screen:new(imgPath)
  self.bg = {}
  self.bg.img = LG.newImage(imgPath)
  self.bg.img:setWrap("repeat", "repeat")

  self.bg.width = LG.getWidth()
  self.bg.height = LG.getHeight()
  self.bg.scale = self.bg.width / self.bg.img:getWidth()

  self.buttons = Buttons()
end

function Screen:draw()
  LG.draw(self.bg.img, 0, 0, 0, self.bg.scale, self.bg.scale)
  self.buttons:draw()
end

function Screen:update()
  self.buttons:update()
end

return Screen