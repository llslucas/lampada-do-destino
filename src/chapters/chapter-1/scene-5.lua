-- Capítulo 1 - Prólogo
-- Cena 1 - Notícia repentina

local GenericScene = require 'src.core.generic-scene'
local Scene = GenericScene:extend()

local Escritorio = require 'src.maps.escritorio'
local Player = require 'src.characters.player'

local player, armarioAdam

function Scene:new()
  --Scene setup
  Scene.super.new(self)

  self.map = Escritorio()

  player = Player()
  player:setCoordinates(2, 14)
  player:turn('down')

  self.map.entities:add(player)

  armarioAdam = self.map.entities:getItemById('armario-adam')
  armarioAdam:open()

  --Events init

  GAME.CUTSCENE = true

  self:addEvent(function()
    player:playAnimation(1)
    self.waitTime = 2
  end)

  self:addEvent(function()
    player:stopAnimation()
    self.waitTime = 2
  end)

  self:addEvent(function()
    self.dialogs:addDialog('david-susto', 'O que diabos acabou de acontecer?!?!')
    self.dialogs:addDialog('david', 'Não importa como, eu vou te salvar, Adam, custe o que custar!')
    GAME.CUTSCENE = false
  end)

  self:makeCoroutine()
end

function Scene:resumeCoroutine()
  if #self.dialogs.objects == 0 and self.waitTime == 0 then
    Scene.super.resumeCoroutine(self)
  end
end

return Scene
