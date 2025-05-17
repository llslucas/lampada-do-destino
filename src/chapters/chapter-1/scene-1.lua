-- Capítulo 1 - Abertura do jogo
local GenericScene = require 'src.core.generic-scene'
local Scene = GenericScene:extend()

local Escritorio = require 'src.maps.escritorio'
local Player = require 'src.characters.player'
local Npc = require 'src.characters.npc'

local player, manager

function Scene:new()
  --Scene setup
  Scene.super.new(self)

  self.map = Escritorio()

  player = Player()
  player:setCoordinates(11, 6)
  player:turn('up')
  self.map.entities:add(player)

  manager = Npc('manager')
  manager:setCoordinates(9, 16)
  manager:turn('up')

  manager:addDialog('gerente', 'David, Adam te deixou responsavel pelos pertences dele, precisamos que voce va ate o armario e recolha-os. Ele foi promovido e transferido para outra unidade. Aqui esta a autorizacao.')
  manager:addDialog('david', '** Promovido? Transferido? Estranho, ele nao me disse nada sobre isso. **')

  GAME.CUTSCENE = true
  self:addEvent(function() manager:setDestination(9,14) end)
  self:addEvent(function() manager:setDestination(11,14) end)
  self:addEvent(function() manager:setDestination(11,8) end)
  self:addEvent(function() player:turn('down') end)
  self:addEvent(function() manager:listenDialog() end)
  self:addEvent(function() manager:listenDialog() end)
  self:addEvent(function() manager:setDestination(11,14) end)
  self:addEvent(function() manager:setDestination(9,16) end)
  self:addEvent(function() manager:setDestination(9,16) end)
  self:addEvent(function() self.map.entities:remove(manager) end)
  self:addEvent(function() GAME.CUTSCENE = false end)

  self:makeCoroutine()

  self.map.entities:add(manager)
end

function Scene:resumeCoroutine()
  if not manager.moving and #self.dialogs.objects == 0 then
    Scene.super.resumeCoroutine(self)
  end
end

return Scene



