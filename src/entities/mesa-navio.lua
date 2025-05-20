local MapObject = require 'src.entities.map-object'
local MesaNavio = MapObject:extend()

function MesaNavio:new()
  MesaNavio.super.new(self, 'mesa-navio')
end

return MesaNavio
