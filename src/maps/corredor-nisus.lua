local Map = require 'src.core.map'
local Escritorio = Map:extend()

local InvisibleWall = require 'src.entities.invisible-wall'
local Door = require 'src.entities.door'
local MesaNavio = require 'src.entities.mesa-navio'
local Camera = require 'src.entities.camera'
local MapObject = require 'src.entities.map-object'

function Escritorio:new()
  Escritorio.super.new(self, 'corredor-nisus')

  -- Border invisible Walls
  self.entities:add(InvisibleWall(8, 2, 10, 1))  --top wall
  self.entities:add(InvisibleWall(7, 3, 1, 7))   -- top left wall
  self.entities:add(InvisibleWall(18, 3, 1, 10)) -- top right wall
  self.entities:add(InvisibleWall(8, 9, 7, 1))   -- top bottom wall
  self.entities:add(InvisibleWall(15, 9, 1, 5))  -- middle left wall

  self.entities:add(InvisibleWall(0, 13, 15, 1)) -- bottom top wall 1
  self.entities:add(InvisibleWall(18, 13, 2, 1)) -- bottom top wall 2

  self.entities:add(InvisibleWall(0, 18, 20, 1)) -- bottom wall

  -- Door
  local door = Door(8, 8, 1, 1)
  self.entities:add(door)

  -- Objects

  -- Mesa Navio
  local mesaNavio = MesaNavio()
  mesaNavio:setCoordinates(16, 3)

  mesaNavio:setInteractionCallBack(function(self)
    WORLD.SCENE.dialogs:addDialog('david', "Parece que tem algo escrito no fundo da gaveta.")
    WORLD.SCENE.dialogs:addDialog('david', '"Não seja pego", "se livre da lâmpada", "saia daqui!"')
    WORLD.SCENE.dialogs:addDialog('david-susto', 'Será que Adam escreveu isto?')

    self:setInteractionCallBack(function() return end)
  end)

  self.entities:add(mesaNavio)

  --Quadro de avisos
  local quadroAvisos = MapObject('quadro-avisos')
  quadroAvisos:setCoordinates(9, 2)

  quadroAvisos:setInteractionCallBack(function(self)
    WORLD.SCENE.dialogs:addDialog('david', 'Há recortes de notícias de jornal aqui...')

    WORLD.SCENE.dialogs:addDialog('empty',
      '"Os funcionários sumiram sem deixar rastros, o gerente afirma que pediram demissão e saíram do país."')
    WORLD.SCENE.dialogs:addDialog('empty',
      '"Celestia sai na frente na corrida e lança o primeiro comprimido indutor de comportamento do mercado. Ainda não se sabe como estão realizando seus testes."')
    WORLD.SCENE.dialogs:addDialog('empty', '"O último desaparecimento é do escriturário geral, David."')

    WORLD.SCENE.dialogs:addDialog('david-susto', '...')

    door:setCollisionCallback(
      function(self)
        WORLD.SCENE.dialogs:addDialog('empty', 'David...')
        WORLD.SCENE.dialogs:addDialog('david-susto', 'Adam?!?!')

        self:setCollisionCallback(function() WORLD.STORYMANAGER:advanceScene() end)
      end
    )

    self:setInteractionCallBack(function() return end)
  end)

  self.entities:add(quadroAvisos)

  -- Cameras
  local camera1 = Camera()
  camera1:setAbsoluteCoordinates(256, 400)

  local camera2 = Camera(90, 30)
  camera2:setAbsoluteCoordinates(615, 525)

  local camera3 = Camera()
  camera3:setAbsoluteCoordinates(417, 50)

  self.enemies:add(camera1, camera2, camera3)  
end

return Escritorio
