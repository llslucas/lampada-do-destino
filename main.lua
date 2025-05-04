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
  WORLD.addEntity(player)

  npc = Npc('npc1')
  npc:setCoordinates(64,64)

  WORLD.addEntity(npc)
end

function love.draw()
  drawGrid(32)
  WORLD.drawEntities()
end

function love.update(dt)
  WORLD.updateEntities(dt)
end