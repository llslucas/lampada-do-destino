-- Capítulo 1 - Prólogo
-- Cena 3 - Nisus

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
  player:setCoordinates(0, 15)
  player:turn('right')

  self:initSanityBar(player)

  self.map.entities:add(player)

  self.dialogs:addDialog('david', 'O quê... Onde estou? Posso sentir o chão, cheiro de sal... isso é real?')

  --Events init
  local quadroAvisos = self.map.entities:getItemById('quadro-avisos')
  local door = self.map.entities:getItemById('door')

  quadroAvisos:setInteractionCallBack(function(self)
    WORLD.SCENE:addEvent(function ()
      WORLD.SCENE.dialogs:addDialog('david', 'Há recortes de notícias de jornal aqui...')
      WORLD.SCENE.dialogs:addDialog('empty', '"Os funcionários sumiram sem deixar rastros, o gerente afirma que pediram demissão e saíram do país."')
      WORLD.SCENE.dialogs:addDialog('empty', '"Celestia sai na frente na corrida e lança o primeiro comprimido indutor de comportamento do mercado. Ainda não se sabe como estão realizando seus testes."')
      WORLD.SCENE.dialogs:addDialog('empty', '"O último desaparecimento é do escriturário geral, David."')

      WORLD.SCENE.dialogs:addDialog('david-susto', '...')
    end)

    WORLD.SCENE:addEvent(function()
      player:setDamage(20)

      door:setCollisionCallback(
        function(self)
          WORLD.SCENE.dialogs:addDialog('empty', 'David...')
          WORLD.SCENE.dialogs:addDialog('david-susto', 'Adam?!?!')

          self:setCollisionCallback(function() WORLD.STORYMANAGER:advanceScene() end)
        end
      )

      self:setInteractionCallBack(function() return end)
    end)
    
    WORLD.SCENE:makeCoroutine()
  end)

  GAME.CUTSCENE = false
end

function Scene:resumeCoroutine()
  if #self.dialogs.objects == 0 then
    Scene.super.resumeCoroutine(self)
  end
end

return Scene
