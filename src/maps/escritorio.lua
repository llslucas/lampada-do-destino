local Map = require 'src.core.map'
local Escritorio = Map:extend()

local InvisibleWall = require 'src.entities.invisible-wall'
local Door = require 'src.entities.door'
local MapObject = require 'src.entities.map-object'

function Escritorio:new()
  Escritorio.super.new(self, 'escritorio')

  -- Walls
  self.entities:add(InvisibleWall(2,4, 16,1))
  self.entities:add(InvisibleWall(2,5, 1,12))
  self.entities:add(InvisibleWall(2,17, 7,1))
  self.entities:add(InvisibleWall(11,17, 7,1))
  self.entities:add(InvisibleWall(17,5, 1,12))

  -- Door 
  local door = Door(9, 18, 2, 1)
  self.entities:add(door)

  -- objects 
  local armario = MapObject('armario')
  armario:setCoordinates(4, 4)
  armario:setInteractionCallBack(
    function()
      WORLD.SCENE.dialogs:addDialog('david', 'Preciso abrir este armario...')
    end
  )

  local estante = MapObject('estante')
  estante:setCoordinates(11, 4)

  local mesa = MapObject('mesa')
  mesa:setCoordinates(14, 5)

  self.entities:add(armario, estante, mesa)
end

return Escritorio