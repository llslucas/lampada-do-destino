local Map = Object:extend()
local Aggregate = require 'src.aggregate.aggregate'

function Map:new(mapName, marginUp, marginBottom, marginLeft, marginRight)
  self.bg = {}
  self.bg.img = LG.newImage('assets/img/maps/' .. mapName .. '.png')
  self.bg.width = self.bg.img:getWidth()
  self.bg.height = self.bg.img:getHeight()
  self.marginUp = marginUp and marginUp * BASE_SIZE or 0
  self.marginBottom = marginBottom and marginBottom * BASE_SIZE or 0
  self.marginLeft = marginLeft and marginLeft * BASE_SIZE or 0
  self.marginRight = marginRight and marginRight * BASE_SIZE or 0

  self.entities = Aggregate()
end

function Map:draw()
  LG.draw(self.bg.img, 0, 0, 0, IMAGE_SCALING, IMAGE_SCALING)
end

return Map