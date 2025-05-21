local Map = require 'src.core.map'
local Alcapao = Map:extend()

local InvisibleWall = require 'src.entities.invisible-wall'
local Door = require 'src.entities.door'
local MesaNavio = require 'src.entities.mesa-navio'

function Alcapao:new()
  Alcapao.super.new(self, 'alcapao')

  -- Border invisible Walls
  self.entities:add(InvisibleWall(11, 6, 4, 1)) -- top wall
  self.entities:add(InvisibleWall(15, 7, 1, 4)) -- right wall
  self.entities:add(InvisibleWall(3, 8, 1, 3)) -- left wall
  self.entities:add(InvisibleWall(4, 11, 11, 1)) -- bottom wall

  self.entities:add(InvisibleWall(6, 7, 5, 1)) -- cage

  local door = Door(4, 7, 2, 1)
  door:setCollisionCallback(function()
    WORLD.SCENE.dialogs:addDialog('david-susto', 'ADAM!!!')
  end)

  self.entities:add(door)
end

return Alcapao
