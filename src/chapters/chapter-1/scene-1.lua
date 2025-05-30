-- Capítulo 1 - Prólogo
-- Cena 1 - Notícia repentina

local GenericScene = require 'src.core.generic-scene'
local Scene = GenericScene:extend()

local Escritorio = require 'src.maps.escritorio'
local Player = require 'src.characters.player'
local Npc = require 'src.characters.npc'

local player, manager, armarioAdam

function Scene:new()
  --Scene setup
  Scene.super.new(self)

  self.map = Escritorio()

  player = Player()
  player:setCoordinates(13, 13)
  player:turn('up')

  manager = Npc('manager')
  manager:setCoordinates(1, 6)
  manager:turn('right')

  self.map.entities:add(player, manager)

  manager:addDialog('gerente',
    'David, Adam te deixou responsável pelos pertences dele, precisamos que você vá até o armário e recolha-os. Ele foi promovido e transferido para outra unidade. Aqui está a autorização.')
  manager:addDialog('david', '** Promovido? Transferido? Estranho, ele não me disse nada sobre isso. **')

  armarioAdam = self.map.entities:getItemById('armario-adam')

  armarioAdam:setPostOpenCallback(
    function()
      self.dialogs:addDialog('david',
        'Tem uma caixa aqui, ela contém os pertences do Adam, o que será que ele deixou para trás?')
      self.dialogs:addDialog('empty',
        '** David retira a caixa do armário e a abre, encontrando uma lâmpada, uma foto e dois papéis. **')
      self.dialogs:addDialog('david', 'Vamos ver o que temos aqui...')
      self.dialogs:addImage('lampada')
      self.dialogs:addDialog('david', 'Uma lâmpada? Que esquisito...')
      self.dialogs:addImage('nisus')
      self.dialogs:addDialog('david', 'Nisus? Já ouvi falar desse navio, é da Celestia...')
      self.dialogs:addDialog('david', 'Por fim temos dois papéis...')
      
      self:addEvent(function() WORLD.STORYMANAGER:advanceScene(self.map) end)
      self:makeCoroutine()
    end
  )

  --Events init

  GAME.CUTSCENE = true

  --Manager walk towards David
  self:addEvent(function() manager:setDestination(9, 6) end)
  self:addEvent(function() manager:setDestination(9, 13) end)
  self:addEvent(function() manager:setDestination(11, 13) end)

  --David turns to Manager
  self:addEvent(function() player:turn('left') end)

  --Manager starts to talk
  self:addEvent(function() manager:listenDialog() end)
  self:addEvent(function() manager:listenDialog() end)

  --Manager quits
  self:addEvent(function() manager:setDestination(11, 13) end)
  self:addEvent(function() manager:setDestination(9, 13) end)
  self:addEvent(function() manager:setDestination(9, 6) end)
  self:addEvent(function() manager:setDestination(1, 6) end)

  self:addEvent(function() self.map.entities:remove(manager) end)
  self:addEvent(function()
    GAME.CUTSCENE = false
    self:clearEvents()
  end)

  self:makeCoroutine()
end

function Scene:resumeCoroutine()
  if not manager.moving and #self.dialogs.objects == 0 then
    Scene.super.resumeCoroutine(self)
  end
end

return Scene
