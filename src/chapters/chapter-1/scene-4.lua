-- Capítulo 1 - Prólogo
-- Cena 4 - Dentro do alçapão
local GenericScene = require 'src.core.generic-scene'
local Scene = GenericScene:extend()

local Mapa = require 'src.maps.alcapao'
local NormalOverlay = require 'src.graphics.normal-overlay'
local Player = require 'src.characters.player'

local player

function Scene:new()
  --Scene setup
  Scene.super.new(self)

  self.map = Mapa()
  self.overlay = NormalOverlay(0.9)

  player = Player()
  player:setCoordinates(14, 9)
  player:turn('down')

  self.map.entities:add(player)

  --Events init

  GAME.CUTSCENE = true

  self:addEvent(function ()
    self.waitTime = 2
  end)

  self:addEvent(function ()
    self.showOverlay = true
    self.waitTime = 2
  end)

  self:addEvent(function ()
    self.showOverlay = false
    self.waitTime = 2
  end)

  self:addEvent(function ()
    self.showOverlay = true
    self.waitTime = 2
  end)

  self:addEvent(function ()
    self.showOverlay = false

    local adam = self.map.entities:getItemById('adam')
    adam:setCoordinates(5, 9)
    player:turn('left')
    self.dialogs:addDialog('david-susto', '!!!')

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
