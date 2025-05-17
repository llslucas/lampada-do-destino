local Entity = require 'src.core.entity'
local ImageBox = Entity:extend()

function ImageBox:new(photoName)
  ImageBox.super.new(self, LG.newImage('assets/img/graphics/image-box.png'), IMAGE_SCALING)
  self.photo = Entity(LG.newImage('assets/img/photos/' .. photoName .. '.png'), IMAGE_SCALING)

  self:setCoordinates(6, 4)
  self.photo:setAbsoluteCoordinates(self.x + BORDER_DISTANCE/2, self.y + BORDER_DISTANCE/2)
end

function ImageBox:draw()
  ImageBox.super.draw(self)
  self.photo:draw()
end

return ImageBox