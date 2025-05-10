-- Dependências globais
LG = love.graphics
Object = require 'lib.classic'

-- Variáveis globais
require 'src.global.fonts'
require 'src.global.game'
require 'src.global.parameters'
require 'src.global.functions'
require 'src.global.world'

-- Dependências locais
local Player = require 'src.characters.player'
local Npc = require 'src.characters.npc'
local drawGrid = require 'src.utils.draw-grid'
local Map = require 'src.core.map'
local InvisibleWall = require 'src.entities.invisible-wall'

-- Variáveis locais
local player

function love.load()
  math.randomseed(os.time())
  LG.setFont(FONTS.NORMAL)

  LG.setBackgroundColor(1,1,1)

  player = Player()
  player:setCoordinates(9,16)
  WORLD.ENTITIES:add(player)

  local npc = Npc('npc1')
  npc:setCoordinates(4,5)
  npc:addDialog('Quem sera esse cara?')
  npc:addDialog('Nunca vi na vida...')
  
  WORLD.ENTITIES:add(npc)

  WORLD.MAP = Map('escritorio')
  WORLD.ENTITIES:add(InvisibleWall(2,4, 16,1))
  WORLD.ENTITIES:add(InvisibleWall(2,5, 1,12))
  WORLD.ENTITIES:add(InvisibleWall(2,17, 7,1))
  WORLD.ENTITIES:add(InvisibleWall(11,17, 7,1))
  WORLD.ENTITIES:add(InvisibleWall(17,5, 1,12))
end

function love.draw()
  WORLD.MAP:draw()
  drawGrid(32)
  WORLD.ENTITIES:draw()
  WORLD.DIALOGS:draw()
end

function love.update(dt)
  if WORLD.DIALOGS.show then
    WORLD.DIALOGS:update(dt)

    if love.keyboard.isDown('space') then
      WORLD.DIALOGS:next()
    end
    return
  end

  WORLD.ENTITIES:update(dt)
end