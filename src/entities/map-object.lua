local Entity = require 'src.core.entity'

local MapObject = Entity:extend()

function MapObject:new(imgName)
  MapObject.super.new(self)
  self.id = imgName
  self.img = LG.newImage('assets/img/objects/' .. imgName .. '.png')
end

return MapObject