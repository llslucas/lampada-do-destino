local Entity = require 'src.core.entity'

local MapObject = Entity:extend()

function MapObject:new(imgName)
  MapObject.super.new(self)
  if imgName then
    self.id = imgName
    self.img = LG.newImage('assets/img/objects/' .. self.id .. '.png')
  end
end

function MapObject:setImage(newImgName)
  self.id = newImgName
  self.img = LG.newImage('assets/img/objects/' .. self.id .. '.png')
end

return MapObject