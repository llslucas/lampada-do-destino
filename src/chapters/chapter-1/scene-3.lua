-- Capítulo 1 - Prólogo
-- Cena 1 - Notícia repentina

local GenericScene = require 'src.core.generic-scene'
local Scene = GenericScene:extend()

local Mapa = require 'src.maps.corredor-nisus'
local Player = require 'src.characters.player'

local player

function Scene:new()
  --Scene setup
  Scene.super.new(self)

  self.map = Mapa()

  player = Player()
  player:setCoordinates(0, 10)
  player:turn('right')

  self.map.entities:add(player)

  self.dialogs:addDialog('david', 'O que... Onde estou? Posso sentir o chão, cheiro de sal... isso e real?')

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
