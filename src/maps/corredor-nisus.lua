local Map = require 'src.core.map'
local Escritorio = Map:extend()

local InvisibleWall = require 'src.entities.invisible-wall'
local Door = require 'src.entities.door'
local MesaNavio = require 'src.entities.mesa-navio'

function Escritorio:new()
  Escritorio.super.new(self, 'corredor-nisus')

  -- Border invisible Walls
  self.entities:add(InvisibleWall(8,2 , 10,1)) --top wall
  self.entities:add(InvisibleWall(7,3, 1,7)) -- top left wall
  self.entities:add(InvisibleWall(18,3, 1,10)) -- top right wall
  self.entities:add(InvisibleWall(8,9, 7,1)) -- top bottom wall  
  self.entities:add(InvisibleWall(15,9, 1,5)) -- middle left wall

  self.entities:add(InvisibleWall(0,13, 15,1)) -- bottom top wall 1
  self.entities:add(InvisibleWall(18,13, 2,1)) -- bottom top wall 2

  self.entities:add(InvisibleWall(0,18, 20,1)) -- bottom wall

  -- Door 
  local door = Door(8,8, 1,1)
  self.entities:add(door)

  -- Objects

  -- Mesa Navio
  local mesaNavio = MesaNavio()
  mesaNavio:setCoordinates(16, 3)
  self.entities:add(mesaNavio)

  door:setCollisionCallback(
    function()
      WORLD.SCENE.dialogs:addDialog('david', 'Algo me espera depois desta porta...')
    end
  )

end

return Escritorio