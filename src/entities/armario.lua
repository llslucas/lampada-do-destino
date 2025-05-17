local MapObject = require 'src.entities.map-object'
local Armario = MapObject:extend()

function Armario:new(x, y)
  Armario.super.new(self, nil)

  self.id = 'armario'
  self.imgFechado = LG.newImage('assets/img/objects/armario-fechado.png')
  self.imgAberto = LG.newImage('assets/img/objects/armario-aberto.png')
  self.img = self.imgFechado
  self.status = 'fechado'

  self:setCoordinates(x, y)
end

function Armario:interact()
  self.img = self.imgAberto
end

return Armario