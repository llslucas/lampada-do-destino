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


-- Variáveis locais
local player, npc

function love.load()
  math.randomseed(os.time())
  LG.setFont(FONTS.NORMAL)

  LG.setBackgroundColor(1,1,1)

  player = Player()
  player:setCoordinates(320,320)
  WORLD.ENTITIES:add(player)

  npc = Npc('npc1')
  npc:setCoordinates(64,64)
  npc:addDialog('Quem sera esse cara?')

  WORLD.ENTITIES:add(npc)
end

function love.draw()
  drawGrid(32)
  WORLD.DIALOGS:draw()
  WORLD.ENTITIES:draw()
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