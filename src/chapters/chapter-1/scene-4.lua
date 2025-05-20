-- Capítulo 1 - Prólogo
-- Cena 4 - Dentro do alçapão
local GenericScene = require 'src.core.generic-scene'
local Scene = GenericScene:extend()

local Mapa = require 'src.maps.alcapao'
local Player = require 'src.characters.player'

local player

function Scene:new()
  --Scene setup
  Scene.super.new(self)

  self.map = Mapa()

  player = Player()
  player:setCoordinates(13, 7)
  player:turn('down')

  self.map.entities:add(player)

  --Events init

  GAME.CUTSCENE = false
  self:makeCoroutine()
end

function Scene:resumeCoroutine()
  if #self.dialogs.objects == 0 then
    Scene.super.resumeCoroutine(self)
  end
end

return Scene
