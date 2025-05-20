local Map = require 'src.core.map'
local Escritorio = Map:extend()

local InvisibleWall = require 'src.entities.invisible-wall'
local Door = require 'src.entities.door'
local MapObject = require 'src.entities.map-object'
local Armario = require 'src.entities.armario'

function Escritorio:new()
  Escritorio.super.new(self, 'corredor-nisus')

  -- Border invisible Walls
  self.entities:add(InvisibleWall(0,8, 17,1)) --top wall
  self.entities:add(InvisibleWall(0,12, 20,1)) -- bottom wall

  -- Door 
  local door = Door(17,8, 3, 1)
  self.entities:add(door)

  door:setCollisionCallback(
    function()
      WORLD.SCENE.dialogs:addDialog('david', 'Algo me espera depois desta porta...')
    end
  )

end

return Escritorio