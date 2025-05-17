local Animation = require 'src.core.animation'
local DavidLampada = Animation:extend()

function DavidLampada:new()
  local img = LG.newImage('assets/img/characters/david-lampada.png')
  self.super.new(self, img, 6, 1)
end

return DavidLampada