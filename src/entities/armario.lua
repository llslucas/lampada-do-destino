local MapObject = require 'src.entities.map-object'
local Armario = MapObject:extend()

function Armario:new(x, y, id)
  Armario.super.new(self, nil)

  self.id = id or 'armario'
  self.imgFechado = LG.newImage('assets/img/objects/armario-fechado.png')
  self.imgAberto = LG.newImage('assets/img/objects/armario-aberto.png')
  self.img = self.imgFechado
  self.status = 'fechado'

  self:setCoordinates(x, y)
end

function Armario:interact()
  if self.status == 'fechado' then
    self.img = self.imgAberto
    self.status = 'aberto'
  elseif self.status == 'aberto' then
    self:postOpenCallback()
  end
end

function Armario:postOpenCallback()
  return
end

function Armario:setPostOpenCallback(callback)
  self.postOpenCallback = callback
end

return Armario