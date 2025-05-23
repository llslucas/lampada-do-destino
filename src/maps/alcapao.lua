local Map = require 'src.core.map'
local Alcapao = Map:extend()

local InvisibleWall = require 'src.entities.invisible-wall'
local Door = require 'src.entities.door'
local MapObject = require 'src.entities.map-object'
local BgmDark = require 'src.sounds.bgm.bgm-dark'

function Alcapao:new()
  Alcapao.super.new(self, 'alcapao')
  self:setTheme(BgmDark())

  -- Border invisible Walls
  self.entities:add(InvisibleWall(12, 8, 4, 1)) -- top wall
  self.entities:add(InvisibleWall(16, 9, 1, 4)) -- right wall
  self.entities:add(InvisibleWall(4, 9, 1, 3)) -- left wall
  self.entities:add(InvisibleWall(5, 13, 11, 1)) -- bottom wall

  local adam = MapObject('adam')
  adam:setCoordinates(-5, -5)
  adam:setInteractionCallBack(function()
    WORLD.STORYMANAGER:advanceScene()
  end)

  self.entities:add(adam)

  local cage = MapObject('grades')
  cage:setCoordinates(5, 7)
  self.entities:add(cage) -- cage

  local door = Door(8, 10, 2, 1)
  door:setInteractionCallBack(function()
    WORLD.SCENE.dialogs:addDialog('david', 'Está trancado!')
  end)

  self.entities:add(door)
end

return Alcapao
