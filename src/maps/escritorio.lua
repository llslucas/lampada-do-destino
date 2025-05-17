local Map = require 'src.core.map'
local Escritorio = Map:extend()

local InvisibleWall = require 'src.entities.invisible-wall'
local Door = require 'src.entities.door'
local MapObject = require 'src.entities.map-object'
local Armario = require 'src.entities.armario'

function Escritorio:new()
  Escritorio.super.new(self, 'escritorio')

  -- Border invisible Walls
  self.entities:add(InvisibleWall(2,2, 17,1)) --top wall
  self.entities:add(InvisibleWall(1,2, 1,4)) --left wall 1
  self.entities:add(InvisibleWall(1,8, 1,12)) --left wall 2
  self.entities:add(InvisibleWall(2,19, 17,1)) -- bottom wall
  self.entities:add(InvisibleWall(19,2, 1,18)) -- right wall

  self.entities:add(InvisibleWall(2,11, 7,2)) -- left separator wall
  self.entities:add(InvisibleWall(11,11, 8,2)) -- right separator wall

  -- Object invisible Walls
  self.entities:add(InvisibleWall(4,8, 3,3)) -- top-left desk
  self.entities:add(InvisibleWall(11,8, 3,3)) -- top-right desk
  self.entities:add(InvisibleWall(16,4, 2,6)) -- large desk

  self.entities:add(InvisibleWall(3,3, 7,2)) -- chairs

  self.entities:add(InvisibleWall(4,16, 3,3)) -- adam desk
  self.entities:add(InvisibleWall(12,16, 4,3)) -- david desk

  -- Door 
  local door = Door(0,6, 1, 2)
  self.entities:add(door)
  door:setCollisionCallback(
    function()
      GAME.pause()
      WORLD.SCENE.dialogs:addDialog('david', 'Nao posso sair daqui ainda...')
    end
  )

  -- objects 
  local armarioDavid = Armario(2, 12)
  local armarioAdam = Armario(17, 12)
  self.entities:add(armarioDavid, armarioAdam)
end

return Escritorio