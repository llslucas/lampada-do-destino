local Map = require 'src.core.map'
local Escritorio = Map:extend()

local Npc = require 'src.characters.npc'
local Player = require 'src.characters.player'
local InvisibleWall = require 'src.entities.invisible-wall'
local Door = require 'src.entities.door'

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
  door:setCollisionCallback(function(self) print('colisão com a porta detectada') end)
  self.entities:add(door)

  -- Player location
  local player = Player()
  player:setCoordinates(9,15)
  self.entities:add(player)

  -- NPCs
  local npc = Npc('npc1')
  npc:setCoordinates(4, 6)
  npc:addDialog('Acredito que ja vi este cara antes...')
  self.entities:add(npc)
end

return Escritorio