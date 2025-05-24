local MapObject = require 'src.entities.map-object'
local Armario = MapObject:extend()

local ArmarioSound = require 'src.sounds.fx.armario-sound'

function Armario:new(x, y, id)
  Armario.super.new(self, nil)

  self.id = id or 'armario'
  self.imgFechado = LG.newImage('assets/img/objects/armario-fechado.png')
  self.imgAberto = LG.newImage('assets/img/objects/armario-aberto.png')
  self.img = self.imgFechado
  self.status = 'fechado'
  self.sound = ArmarioSound()

  self:setCoordinates(x, y)
end

function Armario:open()
  self.img = self.imgAberto
  self.status = 'aberto'
end

function Armario:interact()
  if self.status == 'fechado' then
    self.sound:play()
    self:open()
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

function Armario:removePostOpenCallback()
  self:setPostOpenCallback(
    function ()
      return
    end
  )
end

return Armario