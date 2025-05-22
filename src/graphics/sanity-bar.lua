local Entity = require 'src.core.entity'
local SanityBar = Entity:extend()

function SanityBar:new()
  local image = LG.newImage('assets/img/graphics/sanity-bar.png')
  SanityBar.super.new(self, image, IMAGE_SCALING)
  self:setCoordinates(1,1)
  self.sanity = 100
  self.imgNormal = LG.newImage('assets/img/characters/david-mini/david-normal.png')
  self.imgMedo = LG.newImage('assets/img/characters/david-mini/david-medo.png')
end

function SanityBar:draw()
  self.super.draw(self)

  local avatar
  avatar = self.sanity >= 50 and self.imgNormal or self.imgMedo

  -- draw avatar
  LG.draw(avatar, self.x + 7 * IMAGE_SCALING, self.y + 7 * IMAGE_SCALING)

  -- draw bar
  LG.setColor(0/255, 106/255, 255/255)
  LG.rectangle("fill", self.x + 64 * IMAGE_SCALING, self.y + 35 * IMAGE_SCALING, 157/100 * self.sanity, 26 * IMAGE_SCALING)
  LG.setColor(1,1,1)
end

return SanityBar